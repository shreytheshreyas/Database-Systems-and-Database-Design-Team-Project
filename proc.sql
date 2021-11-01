/**
 * SQL or PL/pgSQL routines of the implementation.
 */



/***************************************
 * HELPER
 **************************************/

CREATE OR REPLACE FUNCTION is_existing_employee(
    employee_id INT
)
RETURNS BOOLEAN AS $$

    SELECT EXISTS(
        SELECT
            1
        FROM
            employees e
        WHERE
            e.eid = employee_id
    );

$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION is_retired_employee(
    employee_id INT
)
RETURNS BOOLEAN AS $$

    SELECT
        (e.resigned_date IS NOT NULL
        AND e.resigned_date < CURRENT_DATE)
    FROM
        employees e
    WHERE
        e.eid = employee_id;

$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION is_existing_manager(
    employee_id INT
)
RETURNS BOOLEAN AS $$

    SELECT EXISTS(
        SELECT
            1
        FROM
            manager m
        WHERE
            m.eid = employee_id
    );

$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION is_existing_session(
    floor_number INT,
    room_number INT,
    session_date_ DATE, -- named with a trailing underscore to avoid naming clash
    session_hour TIME
)
RETURNS BOOLEAN AS $$

    SELECT EXISTS(
        SELECT
            1
        FROM
            meeting_sessions s
        WHERE
            s.building_floor = floor_number
            AND s.room = room_number
            AND s.session_date = session_date_
            AND s.session_time = session_hour
    );

$$ LANGUAGE sql;

/**
 * Checks if all the sessions in the meeting exist.
 */
CREATE OR REPLACE FUNCTION is_existing_meeting(
    floor_number INT,
    room_number INT,
    meeting_date DATE,
    start_hour TIME,
    end_hour TIME
)
RETURNS BOOLEAN AS $$
DECLARE
    session_hour TIME := start_hour;
BEGIN

    WHILE session_hour < end_hour LOOP
        IF NOT is_existing_session(floor_number, room_number, meeting_date, session_hour) THEN
            RETURN FALSE;
        END IF;
        session_hour := session_hour + INTERVAL '1 hour';
    END LOOP;
    RETURN TRUE;

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION is_approved_session(
    floor_number INT,
    room_number INT,
    session_date_ DATE, -- named with a trailing underscore to avoid naming clash
    session_hour TIME
)
RETURNS BOOLEAN AS $$

    SELECT
        s.endorser_id IS NOT NULL
    FROM
        meeting_sessions s
    WHERE
        s.building_floor = floor_number
        AND s.room = room_number
        AND s.session_date = session_date_
        AND s.session_time = session_hour;

$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION is_joining_session(
    floor_number INT,
    room_number INT,
    session_date_ DATE, -- named with a trailing underscore to avoid naming clash
    session_hour TIME,
    employee_id INT
)
RETURNS BOOLEAN AS $$

    SELECT EXISTS(
        SELECT
            1
        FROM
            joins j
        WHERE
            j.eid = employee_id
            AND j.building_floor = floor_number
            AND j.room = room_number
            AND j.session_date = session_date_
            AND j.session_time = session_hour
    );

$$ LANGUAGE sql;

/**
 * Checks if the given employee is joining all the sessions in the duration.
 */
CREATE OR REPLACE FUNCTION is_joining_entire_duration(
    floor_number INT,
    room_number INT,
    session_date DATE,
    start_hour TIME,
    end_hour TIME,
    employee_id INT
)
RETURNS BOOLEAN AS $$
DECLARE
    session_hour TIME := start_hour;
BEGIN

    WHILE session_hour < end_hour LOOP
        IF NOT is_joining_session(floor_number, room_number, session_date, session_hour, employee_id) THEN
            RETURN FALSE;
        END IF;
        session_hour := session_hour + INTERVAL '1 hour';
    END LOOP;
    RETURN TRUE;

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION is_booker_of_session(
    floor_number INT,
    room_number INT,
    session_date_ DATE, -- named with a trailing underscore to avoid naming clash
    session_hour TIME,
    employee_id INT
)
RETURNS BOOLEAN AS $$

    SELECT
        s.booker_id = employee_id
    FROM
        meeting_sessions s
    WHERE
        s.building_floor = floor_number
        AND s.room = room_number
        AND s.session_date = session_date_
        AND s.session_time = session_hour;

$$ LANGUAGE sql;

/**
 * Checks if the given employee is the booker of all the sessions in the duration.
 */
CREATE OR REPLACE FUNCTION is_booker_of_entire_duration(
    floor_number INT,
    room_number INT,
    session_date DATE,
    start_hour TIME,
    end_hour TIME,
    employee_id INT
)
RETURNS BOOLEAN AS $$
DECLARE
    session_hour TIME := start_hour;
BEGIN

    WHILE session_hour < end_hour LOOP
        IF NOT is_booker_of_session(floor_number, room_number, session_date, session_hour, employee_id) THEN 
            RETURN FALSE;
        END IF;
        session_hour := session_hour + INTERVAL '1 hour';
    END LOOP;
    RETURN TRUE;

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION is_employee_of_same_department_as_room(
    floor_number INT,
    room_number INT,
    employee_id INT
)
RETURNS BOOLEAN AS $$

    SELECT EXISTS(
        SELECT
            1
        FROM
            meeting_rooms r
            INNER JOIN employees e ON
                r.did = e.did
        WHERE
            r.building_floor = floor_number
            AND r.room = room_number
            AND e.eid = employee_id
    );

$$ LANGUAGE sql;

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
CREATE OR REPLACE PROCEDURE ChangeCapacity
	(IN floor_number INT, IN room_number INT, IN capacity INT, IN date DATE)
AS $$
	UPDATE meeting_rooms
	SET updated_new_cap = capacity, updated_date = date
	WHERE building_floor = floor_number AND room = room_number;
$$ LANGUAGE sql;


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
        IF availability_date <= CURRENT_DATE THEN 
            RAISE EXCEPTION 'Please enter a valid date';
        END IF;
        
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
$$ LANGUAGE plpgsql; 

-- CREATE OR REPLACE FUNCTION book_room

-- CREATE OR REPLACE FUNCTION unbook_room

-- CREATE OR REPLACE FUNCTION join_meeting

/**
 * Causes the employee with the given employee_id to leave the meeting with the given parameters.
 */
CREATE OR REPLACE FUNCTION leave_meeting(
    floor_number INT,
    room_number INT,
    meeting_date DATE,
    start_hour TIME,
    end_hour TIME,
    employee_id INT
)
RETURNS VOID AS $$
DECLARE
    session_hour TIME := start_hour;
    is_joining_some_session BOOLEAN := FALSE;
    is_booker_of_some_session BOOLEAN := FALSE;
BEGIN

    IF NOT is_existing_employee(employee_id) THEN
        RAISE EXCEPTION 'This employee does not exist.';
    END IF;

    IF is_retired_employee(employee_id) THEN
        RAISE EXCEPTION 'This employee is already retired.';
    END IF;

    IF NOT is_existing_meeting(floor_number, room_number, meeting_date, start_hour, end_hour) THEN
        RAISE EXCEPTION 'This meeting does not exist.';
    END IF;

    IF meeting_date < CURRENT_DATE || (meeting_date = CURRENT_DATE AND end_hour < CURRENT_TIME) THEN
        RAISE EXCEPTION 'This meeting is already over.';
    END IF;

    IF meeting_date = CURRENT_DATE AND start_hour < CURRENT_TIME THEN
        RAISE EXCEPTION 'This meeting has already started.';
    END IF;

    WHILE session_hour < end_hour LOOP
        IF is_approved_session(floor_number, room_number, meeting_date, session_hour) THEN
            RAISE EXCEPTION 'None of the sessions in the meeting must already be approved.';
        END IF;
        session_hour := session_hour + INTERVAL '1 hour';
    END LOOP;

    -- Do nothing if not originally joining the meeting (a contiguous series of sessions), as per the requirements.
    session_hour := start_hour;
    WHILE session_hour < end_hour AND NOT is_joining_some_session LOOP
        IF is_joining_session(floor_number, room_number, meeting_date, session_hour, employee_id) THEN
            is_joining_some_session := TRUE;
        END IF;
        session_hour := session_hour + INTERVAL '1 hour';
    END LOOP;
    IF NOT is_joining_some_session THEN
        RETURN;
    END IF;

    IF NOT is_joining_entire_duration(floor_number, room_number, meeting_date, start_hour, end_hour, employee_id) THEN
        RAISE EXCEPTION 'If the employee was originally joining some session within the duration,'
                || 'then they must have been originally joining all the sessions within the duration '
                || 'to leave them all.';
    END IF;

    session_hour := start_hour;
    WHILE session_hour < end_hour AND NOT is_booker_of_some_session LOOP
        IF is_booker_of_session(floor_number, room_number, meeting_date, session_hour, employee_id) THEN
            is_booker_of_some_session := TRUE;
        END IF;
        session_hour := session_hour + INTERVAL '1 hour';
    END LOOP;
    IF is_booker_of_some_session
            AND NOT is_booker_of_entire_duration(floor_number, room_number, meeting_date, start_hour, end_hour,
                    employee_id) THEN
        RAISE EXCEPTION 'If the employee is the booker of some session within the duration,'
                || 'then they must be the booker of all the sessions within the duration '
                || 'to leave them all.';
    END IF;

    IF is_booker_of_some_session THEN
        unbook_room(floor_number, room_number, meeting_date, start_hour, end_hour, employee_id);
    ELSE
        DELETE FROM
            joins j
        WHERE
            j.eid = employee_id
            AND j.building_floor = floor_number
            AND j.room = room_number
            AND j.session_date = meeting_date
            AND j.session_time >= start_hour
            AND j.session_time < end_hour;
    END IF;

END;
$$ LANGUAGE plpgsql;

/**
 * Causes the given employee to approve the given meeting.
 */
CREATE OR REPLACE FUNCTION approve_meeting(
    floor_number INT,
    room_number INT,
    meeting_date DATE,
    start_hour TIME,
    end_hour TIME,
    employee_id INT
)
RETURNS VOID AS $$
DECLARE
    session_hour TIME := start_hour;
BEGIN

    IF NOT is_existing_employee(employee_id) THEN
        RAISE EXCEPTION 'This employee does not exist.';
    END IF;

    IF is_retired_employee(employee_id) THEN
        RAISE EXCEPTION 'This employee is already retired.';
    END IF;

    IF NOT is_existing_manager(employee_id) THEN
        RAISE EXCEPTION 'This employee is not a manager; only managers can approve a meeting.';
    END IF;

    IF NOT is_employee_of_same_department_as_room(floor_number, room_number, employee_id) THEN
        RAISE EXCEPTION 'The manager approving the meeting must be from the same department that the meeting room belongs to.';
    END IF;

    IF NOT is_existing_meeting(floor_number, room_number, meeting_date, start_hour, end_hour) THEN
        RAISE EXCEPTION 'This meeting does not exist.';
    END IF;

    IF meeting_date < CURRENT_DATE || (meeting_date = CURRENT_DATE AND end_hour < CURRENT_TIME) THEN
        RAISE EXCEPTION 'This meeting would have already been over.';
    END IF;

    IF meeting_date = CURRENT_DATE AND start_hour < CURRENT_TIME THEN
        RAISE EXCEPTION 'This meeting would have already started.';
    END IF;

    WHILE session_hour < end_hour LOOP
        IF is_approved_session(floor_number, room_number, meeting_date, session_hour) THEN
            RAISE EXCEPTION 'None of the sessions in the meeting must already be approved.';
        END IF;
        session_hour := session_hour + INTERVAL '1 hour';
    END LOOP;

    UPDATE
        meeting_sessions s
    SET
        s.endorser_id = employee_id
    WHERE
        s.building_floor = floor_number
        AND s.room = room_number
        AND s.session_date = meeting_date
        AND s.session_time >= start_hour
        AND s.session_time < end_hour;

END;
$$ LANGUAGE plpgsql;



/***************************************
 * HEALTH
 **************************************/

CREATE OR REPLACE PROCEDURE declare_health (
    IN employee_id INTEGER,
    IN declaration_date DATE,
    IN temperature NUMERIC) 
AS $$
BEGIN 
    IF NOT (is_existing_employee(employee_id)) THEN 
        RAISE EXCEPTION 'Employee does not exist';
    END IF;

    IF temperature < 34 OR temperature > 43 THEN 
        RAISE EXCEPTION 'Please Enter a valid temperature range (between 34C to 43C)';
    END IF;

    IF declaration_date > CURRENT_DATE THEN
        RAISE EXCEPTION 'Please enter the current date or an earlier date';
    END IF;

    INSERT INTO health_declaration VALUES (employee_id,declaration_date,temperature);
END;
$$ LANGUAGE plpgsql;


-- CREATE OR REPLACE FUNCTION contact_tracing



/***************************************
 * ADMIN
 **************************************/

CREATE OR REPLACE FUNCTION non_compliance_helper (
    IN begin_date DATE,
    IN end_date DATE)
RETURNS TABLE(eid INTEGER, num_of_days INTEGER) 
AS $$
DECLARE 
    table_cursor CURSOR FOR (SELECT e.eid FROM employees e);
    temp_date DATE := begin_date;
    table_record RECORD;
    day_counter INTEGER := 0;
BEGIN 
    
    OPEN table_cursor;

    LOOP
        FETCH table_cursor INTO table_record;
        EXIT WHEN NOT FOUND;

        --This loop is the nested loop
        WHILE temp_date <= end_date LOOP
            IF NOT EXISTS(SELECT 1 FROM health_declaration hd WHERE hd.eid = table_record.eid AND hd.declaration_date = temp_date) THEN
                day_counter := day_counter + 1; 
            END IF;
            temp_date := temp_date + interval '1 day';
        END LOOP;

        IF day_counter != 0 THEN
            eid := table_record.eid;
            num_of_days := day_counter;
            RETURN NEXT;
            day_counter := 0; 
        END IF;
        
        temp_date := begin_date;

    END LOOP;
    CLOSE table_cursor;

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION non_compliance (
    IN begin_date DATE,
    IN end_date DATE)
RETURNS TABLE(eid INTEGER, num_of_days INTEGER)
AS $$
BEGIN 
    IF begin_date > end_date OR begin_date > CURRENT_DATE OR end_date > CURRENT_DATE THEN 
        RAISE EXCEPTION 'Please enter a valid start date and valid end date';
    END IF;

    RETURN QUERY
    SELECT * FROM non_compliance_helper(begin_date,end_date) nch ORDER BY nch.num_of_days DESC; 
END;
$$ LANGUAGE plpgsql;

-- CREATE OR REPLACE FUNCTION view_booking_report

-- CREATE OR REPLACE FUNCTION view_future_meeting

-- CREATE OR REPLACE FUNCTION view_manager_report
