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
CREATE OR REPLACE PROCEDURE ChangeCapacity
	(IN floor_number INT, IN room_number INT, IN capacity INT, IN date DATE)
AS $$
	UPDATE meeting_rooms
	SET updated_new_cap = capacity, updated_date = date
	WHERE building_floor = floor_number AND room = room_number;
$$ LANGUAGE sql;


-- CREATE OR REPLACE FUNCTION add_employee

-- CREATE OR REPLACE FUNCTION remove_employee



/***************************************
 * CORE
 **************************************/

-- CREATE OR REPLACE FUNCTION search_room

-- CREATE OR REPLACE FUNCTION book_room

-- CREATE OR REPLACE FUNCTION unbook_room

CREATE OR REPLACE FUNCTION join_meeting (
    IN room_number INT,
    IN floor_number INT,
    IN session_date DATE,
    IN start_hour TIME,
    IN end_hour TIME,
    IN eid INT
    )
RETURNS VOID AS $$

DECLARE 
    temp_time TIME := start_hour;
    
BEGIN

    IF NOT (is_existing_meeting(floor_number, room_number, session_date, start_hour, end_hour)) THEN
        RAISE EXCEPTION 'Meeting session does not exist.';
    END IF;

    IF (is_approved_session(floor_number, room_number, session_date, start_hour)) THEN
        RAISE EXCEPTION 'Meeting has been approved, employee disallowed to join.';
    END IF;

    IF (is_retired_employee(eid)) THEN
        RAISE EXCEPTION 'Retired employees are not allowed to join meetings.';
    END IF;

    IF (has_fever_employee(eid)) THEN
        RAISE EXCEPTION 'Employee % has a fever, unable to join meeting.', eid;
    END IF;

    IF NOT (session_date > CURRENT_DATE OR (session_date = CURRENT_DATE AND start_hour > CURRENT_TIME)) THEN 
        RAISE EXCEPTION 'Meeting is currently/has already occurred.';
    END IF;

    -- need some adv: this will result in multiple rows for each empl at each hour per meeting.
    -- alot of duplicates sharing similar info like room no, building no. for the same entry. would it be considered a functional dependency?
    -- would aggregation help (2.4 in ER pdf)
    WHILE temp_time < end_hour LOOP
        INSERT INTO joins(eid, room, building_floor, session_date, session_time) VALUES (eid, room_number, floor_number, session_date, temp_time);
        temp_time := temp_time + INTERVAL '1 hour';
    END LOOP;
END;
$$ LANGUAGE plpgsql;



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
