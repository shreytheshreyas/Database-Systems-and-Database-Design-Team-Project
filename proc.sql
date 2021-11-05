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


/**
 * returns True when meeting room is already at
 * maximum capacity
 */

DROP FUNCTION IF EXISTS is_meeting_session_full;
CREATE OR REPLACE FUNCTION is_meeting_session_full(
    floor_number_ INT,
    room_number_ INT,
    session_date_ DATE,
    start_hour_ TIME
)
RETURNS BOOLEAN AS $$ 
DECLARE
    capacity INTEGER := (
        SELECT updated_new_cap
        FROM meeting_rooms r
        WHERE floor_number_ = r.building_floor
        AND room_number_ = r.room
    ); --if storing old record, just sieve out latest date
    
    current_attendance INTEGER := (
        SELECT COUNT(*)
        FROM joins j
        WHERE j.room = room_number_
        AND j.building_floor = floor_number_
        AND j.session_date = session_date_
        AND j.session_time = start_hour_
    );

BEGIN
    IF (current_attendance = capacity) THEN
        RETURN TRUE;
    END IF;    
    RETURN FALSE;
END;
$$ LANGUAGE plpgsql;

/*
 * Returns true when selected employee has a fever
 */
CREATE OR REPLACE FUNCTION has_fever_employee (
	employee_id INT
)
RETURNS BOOLEAN AS $$

    SELECT EXISTS (
        SELECT 1
        FROM health_declaration h
        WHERE h.eid = employee_id
        AND fever = true
    );
$$ LANGUAGE sql;

/**
 * Get duration (hours) of a selected meeting
 */
CREATE OR REPLACE FUNCTION get_entire_meeting_duration (
    floor_number INT,
    room_number INT,
    session_date DATE,
    start_hour TIME,
    employee_id INT
)
RETURNS INT AS $$ 
DECLARE
    session_hour TIME := start_hour;
    ctr INT := 0;
BEGIN
    WHILE session_hour < end_hour LOOP
        IF is_existing_session(floor_number, room_number, meeting_date, start_hour) THEN
            ctr := ctr + 1
        END IF;
        session_hour := session_hour + INTERVAL '1 hour';
    END LOOP;       
    RETURN ctr;
END;
$$ LANGUAGE sql;

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
--  This routine is used to book a given room. The inputs to the routine should minimally include:
-- Floor number
-- Room number
-- Date
-- Start hour
-- End hour
-- Employee ID
-- The employee ID is the ID of the employee that is booking the room. If the booking is allowed (see the conditions
-- necessary for this in Application), the routine will process the booking for people to join and for approval.
CREATE OR REPLACE FUNCTION book_room (
    IN floor_number INT,
    IN room INT,
    IN booking_date DATE,
    IN start_hour TIME,
    IN end_hour TIME,
    IN employee_id INT,
    )

    INSERT INTO meeting_sessions VALUES (
        room,
        floor_number,
        booking_date,
        booking_date,
        employee_id,
        NULL, 
    );

$$ LANGUAGE plpgsql 

-- unbook_room: This routine is used to remove booking of a given room. The inputs to the routine should minimally
-- include:
-- Floor number
-- Room number
-- Date
-- Start hour
-- End hour
-- Employee ID
-- The employee ID is the ID of the employee that is asking to remove the booking. If this is not the employee doing
-- the booking, the employee is not allowed to remove booking (the no sabotage rule). If the booking is already
-- approved, also remove the approval. If there are already employees joining the meeting, also remove them from
-- the respective tables
-- CREATE OR REPLACE FUNCTION unbook_room
CREATE OR REPLACE FUNCTION unbook_room (
    IN floor_number INT,
    IN room INT,
    IN booking_date DATE,
    IN start_hour TIME,
    IN end_hour TIME,
    IN employee_id INT,
    )

    BEGIN 
    IF  EXISTS 
        (SELECT 1 FROM meeting_sessions WHERE 
            (
                room = room 
                AND building_floor = floor_number 
                AND session_date = booking_date 
                AND session_time = start_hour 
                AND booker_id = employee_id
            )
        ) THEN 

        DELETE FROM meeting_sessions
        WHERE (
            room = room 
            AND building_floor = floor_number
            AND session_date = booking_date
            AND session_time = start_hour
            AND booker_id = employee_id
        )

    ELSE 
        RAISE EXCEPTION 'Booking does not exist';
    END IF;

    END;

$$ LANGUAGE plpgsql


DROP FUNCTION IF EXISTS join_meeting;
CREATE OR REPLACE FUNCTION join_meeting (
    IN room_number_ INT,
    IN floor_number_ INT,
    IN session_date_ DATE,
    IN start_hour_ TIME,
    IN end_hour_ TIME,
    IN eid_ INT
    )
RETURNS VOID AS $$

DECLARE 
    temp_time TIME := start_hour_;
    temp_time2 TIME := start_hour_;
BEGIN

    IF NOT (is_existing_meeting(floor_number_, room_number_, session_date_, start_hour_, end_hour_)) THEN
        RAISE EXCEPTION 'Meeting session does not exist.';
    END IF;

    IF (is_approved_session(floor_number_, room_number_, session_date_, start_hour_)) THEN
        RAISE EXCEPTION 'Meeting has been approved, employee disallowed to join.';
    END IF;

    IF (is_retired_employee(eid_)) THEN
        RAISE EXCEPTION 'Retired employees are not allowed to join meetings.';
    END IF;

    IF (has_fever_employee(eid_)) THEN
        RAISE EXCEPTION 'Employee % has a fever, unable to join meeting.', eid;
    END IF;

    IF NOT (session_date_ > CURRENT_DATE OR (session_date_ = CURRENT_DATE AND start_hour_ > CURRENT_TIME)) THEN 
        RAISE EXCEPTION 'Meeting is currently/has already occurred.';
    END IF;

    IF (is_meeting_session_full(floor_number_, room_number_, session_date_, start_hour_)) THEN
        RAISE EXCEPTION 'The meeting room is already full.';
    END IF;

    -- need some adv: this will result in multiple rows for each empl at each hour per meeting.
    -- alot of duplicates sharing similar info like room no, building no. for the same entry. would it be considered a functional dependency?
    -- would aggregation help (2.4 in ER pdf)

    -- check clashing 
    WHILE temp_time2 < end_hour_ LOOP
        IF EXISTS (
            SELECT 1 
            FROM joins j
            WHERE eid_ = j.eid
            AND session_date_ = j.session_date
            AND (
                temp_time2 = j.session_time
                OR end_hour_ = j.session_time
            )) THEN
            RAISE EXCEPTION 'Employee is already attending a meeting at the same timing';
        ELSE
            temp_time2 := temp_time2 + INTERVAL '1 hour';
        END IF;
    END LOOP;

     -- if not clashing, assumes employee will attend until the stated hours if start AND end hour is within the session.
    WHILE temp_time < end_hour_ LOOP
        INSERT INTO joins(eid, room, building_floor, session_date, session_time) VALUES (eid_, room_number_, floor_number_, session_date_, temp_time);
        temp_time := temp_time + INTERVAL '1 hour';
    END LOOP;

END;
$$ LANGUAGE plpgsql;


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


CREATE OR REPLACE FUNCTION contact_tracing (
    employee_id INT
    )
RETURNS TABLE (
    eid INT
    ) AS $$
BEGIN
    RETURN QUERY 
        SELECT DISTINCT j1.eid
        FROM joins j1,
            (SELECT DISTINCT j.room, j.building_floor, j.session_date, j.session_time
            FROM meeting_sessions m, joins j
            WHERE j.eid = employee_id
            AND j.room = m.room
            AND j.building_floor = m.building_floor
            AND j.session_date = m.session_date
            AND j.session_time = m.session_time
            AND m.endorser_id IS NOT NULL
            AND m.session_date BETWEEN (CURRENT_DATE - interval '3 days') AND CURRENT_DATE
            ) t1
        WHERE j1.room = t1.room
        AND j1.building_floor = t1.building_floor
        AND j1.session_date = t1.session_date
        AND j1.session_time = t1.session_time
        AND j1.eid <> employee_id;
END;
$$ LANGUAGE plpgsql

CREATE OR REPLACE FUNCTION contact_tracing_procedure()
RETURNS TRIGGER AS $$
BEGIN

    -- close contacts removed from D to D+7 meetings
    DELETE FROM joins j
    WHERE j.eid IN (SELECT contact_tracing(NEW.eid))
    AND (j.sessions_date BETWEEN CURRENT_DATE AND (CURRENT_DATE + interval '7 days'));

    -- infected emp removed from all future meetings
    DELETE FROM joins j
    WHERE j.eid = NEW.eid
    AND (j.session_date > CURRENT_DATE OR (j.session_date = CURRENT_DATE AND j.session_time > CURRENT_TIME));

    -- If the employee is the one booking the room, the booking is cancelled, approved or not.
    DELETE FROM meeting_sessions m
    WHERE NEW.eid = meeting_sessions.booker_id;

END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS employee_has_fever ON health_declaration;
CREATE TRIGGER employee_has_fever
AFTER INSERT ON health_declaration
FOR EACH ROW
WHEN (NEW.fever = true)
EXECUTE FUNCTION contact_tracing_procedure();

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

/**
 * Finds all the meeting rooms that are booked by the given employee from the given start date onwards.
 * Particularly, it finds the meeting sessions the employee has booked from the given date onwards and the meeting rooms
 * that they occur in. The approval status is returned as well. The rows are sorted in ascending order by date, and then
 * in ascending order by time.
 */
CREATE OR REPLACE FUNCTION view_booking_report(
    start_date_ DATE, -- named with a trailing underscore because start_date seems like a postgresql keyword
    employee_id INT
)
RETURNS TABLE(
    floor_number INT,
    room_number INT,
    session_date DATE,
    start_hour TIME,
    is_approved BOOLEAN
) AS $$

    SELECT
        s.building_floor AS floor_number,
        s.room AS room_number,
        s.session_date AS session_date,
        s.session_time AS start_hour,
        (s.endorser_id IS NOT NULL) AS is_approved
    FROM
        meeting_sessions s
    WHERE
        s.session_date >= start_date_
        AND s.booker_id = employee_id
    ORDER BY
        s.session_date ASC,
        s.session_time ASC;

$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION view_future_meeting (
    session_date_ DATE,
    employee_id INT
)
RETURNS TABLE (floor_number INT, room_number INT, session_date DATE, start_hour TIME)
AS $$
    BEGIN
        SELECT j.floor_number, j.room_number, j.session_date, j.session_time
        FROM meeting_sessions m, joins j
        WHERE j.eid = employee_id
        AND j.room = m.room
        AND j.building_floor = m.building_floor
        AND j.session_date = m.session_date
        AND j.session_time = m.session_time
        AND j.session_date >= session_date_ -- not inclusive of given session date
        AND endorser_id IS NOT NULL
        ORDER BY j.session_date, j.session_time
        ;

    END;
$$ LANGUAGE plpgsql

-- CREATE OR REPLACE FUNCTION view_manager_report
