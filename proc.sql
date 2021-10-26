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

    IF NOT is_existing_meeting(floor_number, room_number, meeting_date, start_hour, end_hour) THEN
        RAISE EXCEPTION 'This meeting does not exist.';
    END IF;

    WHILE session_hour < end_hour LOOP
        IF is_approved_session(floor_number, room_number, meeting_date, session_hour) THEN
            RAISE EXCEPTION 'None of the sessions must be approved.';
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
        RAISE EXCEPTION 'If the employee was originally joining some session within the duration, '
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
        RAISE EXCEPTION 'If the employee is the booker of some session within the duration, '
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
