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
            Employees e
        WHERE
            e.eid = employee_id
    );

$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION is_existing_session(
    floor_number INT,
    room_number INT,
    session_date_ INT, -- named with a trailing underscore to avoid naming clash
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
    session_date INT,
    start_hour TIME,
    end_hour TIME
)
RETURNS BOOLEAN AS $$
DECLARE
    session_hour TIME := start_hour;
BEGIN

    WHILE session_hour < end_hour LOOP
        IF NOT is_existing_session(floor_number, room_number, session_date, session_hour)
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
    session_date_ INT, -- named with a trailing underscore to avoid naming clash
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
    session_date_ INT, -- named with a trailing underscore to avoid naming clash
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
    session_date INT,
    start_hour TIME,
    end_hour TIME,
    employee_id INT
)
RETURNS BOOLEAN AS $$
DECLARE
    session_hour TIME := start_hour;
BEGIN

    WHILE session_hour < end_hour LOOP
        IF NOT is_joining_session(floor_number, room_number, session_date, session_hour, employee_id)
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
    session_date_ INT, -- named with a trailing underscore to avoid naming clash
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
    session_date INT,
    start_hour TIME,
    end_hour TIME,
    employee_id INT
)
RETURNS BOOLEAN AS $$
DECLARE
    session_hour TIME := start_hour;
BEGIN

    WHILE session_hour < end_hour LOOP
        IF NOT is_booker_of_session(floor_number, room_number, session_date, session_hour, employee_id)
            RETURN FALSE;
        END IF;
        session_hour := session_hour + INTERVAL '1 hour';
    END LOOP;
    RETURN TRUE;

END;
$$ LANGUAGE plpgsql;

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
