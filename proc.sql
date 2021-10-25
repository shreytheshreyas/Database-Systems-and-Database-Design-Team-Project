/**
 * SQL or PL/pgSQL routines of the implementation.
 */



/***************************************
 * HELPER
 **************************************/

-- CREATE OR REPLACE { FUNCTION | PROCEDURE } <routine name>



/***************************************
 * TRIGGERS
 **************************************/

-- DROP TRIGGER IF EXISTS <trigger name>
-- CREATE TRIGGER <trigger name>



/***************************************
 * BASIC
 **************************************/

/**
 * Adds a new department with given parameters
 * only if did is unique.
 */
CREATE OR REPLACE FUNCTION add_department(
    IN did INTEGER,
    IN dname TEXT
)
RETURNS VOID AS $$

	INSERT INTO Departments VALUES (did, dname)
	ON CONFLICT (did) DO NOTHING --wont insert if did clashes

$$ Language sql;

/**
 * Removes a department specified by did parameter
 */
CREATE OR REPLACE FUNCTION remove_department(
    IN did INT
)
RETURNS VOID AS $$

	DELETE FROM Departments WHERE Departments.did = did;
    -- need ON DELETE for FK constraints in schema to execute assumptions

$$ Language sql;

/**
 * Adds a meeting room with the given parameters.
 * The parameters are self-explanatory.
 */
CREATE OR REPLACE FUNCTION add_room(
    floor_number INT,
    room_number INT,
    room_name TEXT,
    room_capacity INT,
    department_id INT -- extra parameter; needed for given ER model
)
RETURNS VOID AS $$

    INSERT INTO meeting_rooms (
        building_floor,
        room,
        rname,
        did,
        updated_new_cap,
        updated_date
    )
    VALUES (
        floor_number,
        room_number,
        room_name,
        department_id,
        room_capacity,
        CURRENT_DATE
    );

$$ LANGUAGE sql; -- plpgsql would be overkill here; only sql is used

-- CREATE OR REPLACE FUNCTION change_capacity

-- add_employee
CREATE OR REPLACE PROCEDURE add_employee(
    IN employee_name TEXT,
    IN employee_kind TEXT,
    IN employee_did INTEGER,
    IN mobile_contact_no INTEGER,
    IN home_contact_no INTEGER,
    IN office_contact_no INTEGER
    ) AS $$
    BEGIN
        IF EXISTS(SELECT 1 FROM departments WHERE did = employee_did) THEN 
            IF LOWER(employee_kind) != 'junior' AND LOWER(employee_kind) != 'senior' AND LOWER(employee_kind) != 'manager' THEN 
                 RAISE EXCEPTION 'Please enter a valid seniority position';
            END IF;
            
            INSERT INTO employees (ename,ekind,did,mobile_contact,home_contact,office_contact) VALUES (employee_name,LOWER(employee_kind),employee_did,mobile_contact_no,home_contact_no,office_contact_no);

        ELSE 
            RAISE EXCEPTION 'department with specified department id does not exist';
        END IF;  
    END; 

$$ LANGUAGE plpgsql;

--Asscoiated Trigger and Trigger function for add_employee
CREATE OR REPLACE FUNCTION employee_classifier_funct()
RETURNS TRIGGER AS $$
BEGIN
    CASE NEW.ekind 
        WHEN 'junior' THEN INSERT INTO junior VALUES (NEW.eid);
        WHEN 'senior' THEN
            INSERT INTO booker VALUES (NEW.eid);
            INSERT INTO senior VALUES (NEW.eid);
        WHEN 'manager' THEN 
            INSERT INTO booker VALUES (NEW.eid);
            INSERT INTO manager VALUES (NEW.eid);
    END CASE;
    
    RETURN NULL;
END; 
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS employee_classifier ON employees;
CREATE TRIGGER employee_classifier
AFTER INSERT ON employees
FOR EACH ROW EXECUTE FUNCTION 
    employee_classifier_funct();



-- remove employee
CREATE OR REPLACE PROCEDURE remove_employee(
    IN employee_id INTEGER,
    IN employee_regination_date DATE
    ) AS $$
    BEGIN 
    IF  EXISTS(SELECT 1 FROM employees WHERE eid = employee_id) THEN 
        IF EXISTS(SELECT 1 FROM employees WHERE eid = employee_id AND resigned_date is NOT NULL) THEN
            RAISE EXCEPTION 'Employee has already left the company';
        END IF;

        UPDATE employees SET resigned_date = employee_regination_date WHERE employee_id = eid;

    ELSE 
        RAISE EXCEPTION 'Employee with specified employee id does not exist';
    END IF;

    END;
$$ LANGUAGE plpgsql;
/***************************************
 * CORE
 **************************************/

CREATE OR REPLACE FUNCTION search_room (
    IN capacity INT,
    IN availability_date DATE,
    IN start_hour TIME,
    IN end_hour TIME 
    ) 
    RETURNS TABLE(room_num INTEGER, building_floor INTEGER, department_id INTEGER, 
    room_capacity INTEGER)
    AS $$
    DECLARE 
    
        tableCursor CURSOR 
        FOR (SELECT m.room, m.building_floor, m.did, m.updated_new_cap FROM meeting_rooms m WHERE m.updated_new_cap >= capacity ORDER BY m.updated_new_cap);

        rec RECORD;
        temp_hour TIME;
        flag INTEGER;
    BEGIN

        OPEN tableCursor;
        LOOP
            FETCH tableCursor INTO rec;
                EXIT WHEN NOT FOUND;

                temp_hour := start_hour;
                flag := 0;
                LOOP 
                    EXIT WHEN temp_hour = end_hour OR FLAG = 1;
                    
                    IF EXISTS(SELECT 1 FROM meeting_sessions m
                    WHERE m.room = rec.room AND m.building_floor = rec.building_floor 
                    AND m.session_date = availability_date AND m.session_time = temp_hour) THEN 
                        flag := 1;
                    END IF;

                    temp_hour := temp_hour + interval '1 hour';
                END LOOP; 

            IF flag = 0 THEN
                room_num := rec.room;
                building_floor := rec.building_floor;
                department_id := rec.did;
                room_capacity := rec.updated_new_cap;

                RETURN NEXT;
            END IF;
        END LOOP;
        CLOSE tableCursor;
    END;
$$ LANGUAGE plpgsql 

-- CREATE OR REPLACE FUNCTION book_room

-- CREATE OR REPLACE FUNCTION unbook_room

-- CREATE OR REPLACE FUNCTION join_meeting

-- CREATE OR REPLACE FUNCTION leave_meeting

-- CREATE OR REPLACE FUNCTION approve_meeting



/***************************************
 * HEALTH
 **************************************/

-- CREATE OR REPLACE FUNCTION declare_health

-- CREATE OR REPLACE FUNCTION contact_tracing



/***************************************
 * ADMIN
 **************************************/

-- CREATE OR REPLACE FUNCTION non_compliance

-- CREATE OR REPLACE FUNCTION view_booking_report

-- CREATE OR REPLACE FUNCTION view_future_meeting

-- CREATE OR REPLACE FUNCTION view_manager_report
