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
        (e.resigned_date IS NOT NULL)
    FROM
        employees e
    WHERE
        e.eid = employee_id;

$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION is_existing_junior(
    employee_id INT
)
RETURNS BOOLEAN AS $$

    SELECT EXISTS(
        SELECT
            1
        FROM
            junior j
        WHERE
            j.eid = employee_id
    );

$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION is_existing_senior(
    employee_id INT
)
RETURNS BOOLEAN AS $$

    SELECT EXISTS(
        SELECT
            1
        FROM
            senior s
        WHERE
            s.eid = employee_id
    );

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

CREATE OR REPLACE FUNCTION is_existing_booker(
    employee_id INT
)
RETURNS BOOLEAN AS $$

    SELECT EXISTS(
        SELECT
            1
        FROM
            booker b
        WHERE
            b.eid = employee_id
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

CREATE OR REPLACE FUNCTION is_existing_room(
    room_number INT,
    floor_number INT
)
RETURNS BOOLEAN AS $$

    SELECT EXISTS(
        SELECT
            1
        FROM
            meeting_rooms r
        WHERE
            r.room = room_number
        AND
            r.building_floor = floor_number
    );

$$ LANGUAGE sql;

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

CREATE OR REPLACE FUNCTION is_on_the_hour(
    time_to_check TIME
)
RETURNS BOOLEAN AS $$

    SELECT
        date_trunc('hour', t.timestamp_to_check) = t.timestamp_to_check
    FROM
        (SELECT
            CURRENT_DATE + time_to_check AS timestamp_to_check) t;

$$ LANGUAGE sql;

/**
 * returns True when meeting room is already at
 * maximum capacity
 */

DROP FUNCTION IF EXISTS is_meeting_session_full;
CREATE OR REPLACE FUNCTION is_meeting_session_full(
    floor_number INT,
    room_number INT,
    meeting_session_date DATE,
    start_hour TIME
)
RETURNS BOOLEAN AS $$ 
DECLARE
    capacity INTEGER := (
        SELECT updated_new_cap
        FROM meeting_rooms r
        WHERE floor_number = r.building_floor
        AND room_number = r.room
    ); --if storing old record, just sieve out latest date
    
    current_attendance INTEGER := (
        SELECT COUNT(*)
        FROM joins j
        WHERE j.room = room_number
        AND j.building_floor = floor_number
        AND j.session_date = meeting_session_date
        AND j.session_time = start_hour
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
            ctr := ctr + 1;
        END IF;
        session_hour := session_hour + INTERVAL '1 hour';
    END LOOP;       
    RETURN ctr;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION remove_employee_meeting(
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

    IF NOT (is_on_the_hour(start_hour) AND is_on_the_hour(end_hour)) THEN
        RAISE EXCEPTION 'All hours must be exactly on the hour.';
    END IF;

    IF NOT is_existing_meeting(floor_number, room_number, meeting_date, start_hour, end_hour) THEN
        RAISE EXCEPTION 'This meeting does not exist.';
    END IF;

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
                'then they must have been originally joining all the sessions within the duration '
                'to leave them all.';
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
                'then they must be the booker of all the sessions within the duration '
                'to leave them all.';
    END IF;

    IF is_booker_of_some_session THEN
        SELECT unbook_room(floor_number, room_number, meeting_date, start_hour, end_hour, employee_id);
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
-- CREATE OR REPLACE { FUNCTION | PROCEDURE } <routine name>



/***************************************
 * TRIGGERS
 **************************************/

/**
 * Constraint 12(i)
 * "Each employee must be one and only one of the three kinds of employees: junior, senior or manager."
 * Handling inserts into junior if already senior or manager here.
 */
CREATE OR REPLACE FUNCTION check_extra_employee_kind_junior()
RETURNS TRIGGER AS $$
BEGIN

    IF is_existing_senior(NEW.eid) THEN
        RAISE EXCEPTION 'This employee cannot also be both a junior and a senior.';
    END IF;
    IF is_existing_manager(NEW.eid) THEN
        RAISE EXCEPTION 'This employee cannot also be both a junior and a manager.';
    END IF;
    RETURN NEW;

END;
$$ LANGUAGE plpgsql;
DROP TRIGGER IF EXISTS extra_employee_kind_junior ON junior;
CREATE CONSTRAINT TRIGGER extra_employee_kind_junior
AFTER INSERT ON junior
DEFERRABLE INITIALLY IMMEDIATE
FOR EACH ROW
EXECUTE FUNCTION check_extra_employee_kind_junior();

/**
 * Constraint 12(ii)
 * "Each employee must be one and only one of the three kinds of employees: junior, senior or manager."
 * Handling inserts into senior if already junior or manager here.
 */
CREATE OR REPLACE FUNCTION check_extra_employee_kind_senior()
RETURNS TRIGGER AS $$
BEGIN

    IF is_existing_junior(NEW.eid) THEN
        RAISE EXCEPTION 'This employee cannot also be both a senior and a junior.';
    END IF;
    IF is_existing_manager(NEW.eid) THEN
        RAISE EXCEPTION 'This employee cannot also be both a senior and a manager.';
    END IF;
    RETURN NEW;

END;
$$ LANGUAGE plpgsql;
DROP TRIGGER IF EXISTS extra_employee_kind_senior ON senior;
CREATE CONSTRAINT TRIGGER extra_employee_kind_senior
AFTER INSERT ON senior
DEFERRABLE INITIALLY IMMEDIATE
FOR EACH ROW
EXECUTE FUNCTION check_extra_employee_kind_senior();

/**
 * Constraint 12(iii)
 * "Each employee must be one and only one of the three kinds of employees: junior, senior or manager."
 * Handling inserts into manager if already junior or senior here.
 */
CREATE OR REPLACE FUNCTION check_extra_employee_kind_manager()
RETURNS TRIGGER AS $$
BEGIN

    IF is_existing_junior(NEW.eid) THEN
        RAISE EXCEPTION 'This employee cannot also be both a manager and a junior.';
    END IF;
    IF is_existing_senior(NEW.eid) THEN
        RAISE EXCEPTION 'This employee cannot also be both a manager and a senior.';
    END IF;
    RETURN NEW;

END;
$$ LANGUAGE plpgsql;
DROP TRIGGER IF EXISTS extra_employee_kind_manager ON manager;
CREATE CONSTRAINT TRIGGER extra_employee_kind_manager
AFTER INSERT ON manager
DEFERRABLE INITIALLY IMMEDIATE
FOR EACH ROW
EXECUTE FUNCTION check_extra_employee_kind_manager();

/**
 * Constraint 12(iv)
 * "Each employee must be one and only one of the three kinds of employees: junior, senior or manager."
 * Handling deletions from junior if not already also senior or manager here.
 */
CREATE OR REPLACE FUNCTION check_no_employee_kind_junior()
RETURNS TRIGGER AS $$
BEGIN

    IF NOT (is_existing_senior(OLD.eid) OR is_existing_manager(OLD.eid)) THEN
        RAISE EXCEPTION 'This employee cannot stop being a junior if they are not also already a senior or a manager.';
    END IF;
    RETURN OLD;

END;
$$ LANGUAGE plpgsql;
DROP TRIGGER IF EXISTS no_employee_kind_junior ON junior;
CREATE CONSTRAINT TRIGGER no_employee_kind_junior
AFTER DELETE ON junior
DEFERRABLE INITIALLY IMMEDIATE
FOR EACH ROW
EXECUTE FUNCTION check_no_employee_kind_junior();

/**
 * Constraint 12(v)
 * "Each employee must be one and only one of the three kinds of employees: junior, senior or manager."
 * Handling deletions from senior if not already also junior or manager here.
 */
CREATE OR REPLACE FUNCTION check_no_employee_kind_senior()
RETURNS TRIGGER AS $$
BEGIN

    IF NOT (is_existing_junior(OLD.eid) OR is_existing_manager(OLD.eid)) THEN
        RAISE EXCEPTION 'This employee cannot stop being a senior if they are not also already a junior or a manager.';
    END IF;
    RETURN OLD;

END;
$$ LANGUAGE plpgsql;
DROP TRIGGER IF EXISTS no_employee_kind_senior ON senior;
CREATE CONSTRAINT TRIGGER no_employee_kind_senior
AFTER DELETE ON senior
DEFERRABLE INITIALLY IMMEDIATE
FOR EACH ROW
EXECUTE FUNCTION check_no_employee_kind_senior();

/**
 * Constraint 12(vi)
 * "Each employee must be one and only one of the three kinds of employees: junior, senior or manager."
 * Handling deletions from manager if not already also junior or senior here.
 */
CREATE OR REPLACE FUNCTION check_no_employee_kind_manager()
RETURNS TRIGGER AS $$
BEGIN

    IF NOT (is_existing_junior(OLD.eid) OR is_existing_senior(OLD.eid)) THEN
        RAISE EXCEPTION 'This employee cannot stop being a manager if they are not also already a junior or a senior.';
    END IF;
    RETURN OLD;

END;
$$ LANGUAGE plpgsql;
DROP TRIGGER IF EXISTS no_employee_kind_manager ON manager;
CREATE CONSTRAINT TRIGGER no_employee_kind_manager
AFTER DELETE ON manager
DEFERRABLE INITIALLY IMMEDIATE
FOR EACH ROW
EXECUTE FUNCTION check_no_employee_kind_manager();

/**
 * Constraint 19
 * "If an employee is having a fever, they cannot join a booked meeting.""
 */
CREATE OR REPLACE FUNCTION block_fever_employee_joining()
RETURNS TRIGGER AS $$
BEGIN
    IF (has_fever_employee(NEW.eid)) THEN
        RAISE EXCEPTION 'Employee % has a fever, unable to join meeting.', NEW.eid;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS block_fever_employee ON joins;
CREATE TRIGGER block_fever_employee
BEFORE INSERT ON joins
FOR EACH ROW
EXECUTE FUNCTION block_fever_employee_joining();

/**
 * Constraint 26
 * "An employee can only join future meetings."
 */
CREATE OR REPLACE FUNCTION check_block_past_joins()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT (NEW.session_date > CURRENT_DATE OR (NEW.session_date = CURRENT_DATE AND NEW.session_time > CURRENT_TIME)) THEN 
        RAISE EXCEPTION 'Meeting is currently/has already occurred.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS block_past_joins ON joins;
CREATE TRIGGER block_past_joins
BEFORE INSERT ON joins
FOR EACH ROW
EXECUTE FUNCTION check_block_past_joins();

/**
 * Ensure new attendees joining do not exceed room capacity
 */
CREATE OR REPLACE FUNCTION block_over_exceed_joins()
RETURNS TRIGGER AS $$
BEGIN
    IF (is_meeting_session_full(NEW.building_floor, NEW.room, NEW.session_date, NEW.session_time)) THEN
        RAISE EXCEPTION 'The meeting room is already full.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS over_exceed_joins ON joins;
CREATE TRIGGER over_exceed_joins
BEFORE INSERT ON joins
FOR EACH ROW
EXECUTE FUNCTION block_over_exceed_joins();

/**
 * Constraint 33
 * "When an employee resigns, all past records are kept"
 */
CREATE OR REPLACE FUNCTION block_delete_employees()
RETURNS TRIGGER AS $$
BEGIN

    RAISE EXCEPTION 'No employee record can be deleted; this is to facilitate contact tracing.';
    RETURN NULL;

END;
$$ LANGUAGE plpgsql;
DROP TRIGGER IF EXISTS employee_deletion ON employees;
CREATE TRIGGER employee_deletion
BEFORE DELETE ON employees
FOR EACH STATEMENT
EXECUTE FUNCTION block_delete_employees();

/**
 * An employee that has resigned cannot do a health declaration.
 */
CREATE OR REPLACE FUNCTION check_not_resigned_health_declaration()
RETURNS TRIGGER AS $$
BEGIN

    IF is_retired_employee(NEW.eid) THEN
        RAISE EXCEPTION 'An employee that has resigned cannot do a health declaration.';
    END IF;
    RETURN NEW;

END;
$$ LANGUAGE plpgsql;
DROP TRIGGER IF EXISTS not_resigned_health_declaration ON health_declaration;
CREATE TRIGGER not_resigned_health_declaration
BEFORE INSERT ON health_declaration
FOR EACH ROW
EXECUTE FUNCTION check_not_resigned_health_declaration();

/**
 * Constraint 34(a)
 * "When an employee resigns, they are no longer allowed to book ... any meetings"
 */
CREATE OR REPLACE FUNCTION check_not_resigned_session_booker()
RETURNS TRIGGER AS $$
BEGIN

    IF is_retired_employee(NEW.booker_id) THEN
        RAISE EXCEPTION 'An employee that has resigned cannot book a meeting session.';
    END IF;
    RETURN NEW;

END;
$$ LANGUAGE plpgsql;
DROP TRIGGER IF EXISTS not_resigned_session_booker ON meeting_sessions;
CREATE TRIGGER not_resigned_session_booker
BEFORE INSERT ON meeting_sessions
FOR EACH ROW
EXECUTE FUNCTION check_not_resigned_session_booker();

/**
 * Constraint 34(b)
 * "When an employee resigns, they are no longer allowed to ... approve any meetings"
 */
CREATE OR REPLACE FUNCTION check_not_resigned_session_endorser()
RETURNS TRIGGER AS $$
BEGIN

    IF is_retired_employee(NEW.endorser_id) THEN
        RAISE EXCEPTION 'An employee that has resigned cannot approve a meeting session.';
    END IF;
    RETURN NEW;

END;
$$ LANGUAGE plpgsql;
DROP TRIGGER IF EXISTS not_resigned_session_endorser ON meeting_sessions;
CREATE TRIGGER not_resigned_session_endorser
BEFORE INSERT OR UPDATE OF endorser_id ON meeting_sessions
FOR EACH ROW
EXECUTE FUNCTION check_not_resigned_session_endorser();

/**
 * An employee that has resigned cannot join a meeting session.
 */
CREATE OR REPLACE FUNCTION check_not_resigned_session_participant()
RETURNS TRIGGER AS $$
BEGIN

    IF is_retired_employee(NEW.eid) THEN
        RAISE EXCEPTION 'An employee that has resigned cannot join a meeting session.';
    END IF;
    RETURN NEW;

END;

$$ LANGUAGE plpgsql;
DROP TRIGGER IF EXISTS not_resigned_session_participant ON joins;
CREATE TRIGGER not_resigned_session_participant
BEFORE INSERT ON joins
FOR EACH ROW
EXECUTE FUNCTION check_not_resigned_session_participant();

/**
 * Constraint 23
 * "Once approved, there should be no more changes in the participants and the participants will definitely come to the
 * meeting on the stipulated day"
 * Note that increases in participants is not enforced by this trigger, only decreases.
 */
CREATE OR REPLACE FUNCTION check_unapproved_meeting_session_exit()
RETURNS TRIGGER AS $$
BEGIN

    IF is_approved_session(OLD.building_floor, OLD.room, OLD.session_date, OLD.session_time) THEN
        RAISE EXCEPTION 'An employee cannot leave a meeting session that has already been approved.';
    END IF;
    RETURN NEW;

END;
$$ LANGUAGE plpgsql;
-- DROP TRIGGER IF EXISTS unapproved_meeting_session_exit ON joins;
-- CREATE TRIGGER unapproved_meeting_session_exit
-- BEFORE DELETE ON joins
-- FOR EACH ROW
-- EXECUTE FUNCTION check_unapproved_meeting_session_exit();

/**
 * Constraint 22
 * "A booked meeting is approved at most once"
 */
CREATE OR REPLACE FUNCTION check_unapproved_meeting_session_approval()
RETURNS TRIGGER AS $$
BEGIN

    IF OLD.endorser_id IS NOT NULL THEN
        RAISE EXCEPTION 'The endorser cannot be changed.';
    END IF;
    RETURN NEW;

END;
$$ LANGUAGE plpgsql;
DROP TRIGGER IF EXISTS unapproved_meeting_session_approval ON meeting_sessions;
CREATE TRIGGER unapproved_meeting_session_approval
BEFORE UPDATE OF endorser_id ON meeting_sessions
FOR EACH ROW
EXECUTE FUNCTION check_unapproved_meeting_session_approval();

/**
 * The only updates that can occur on a meeting session record is an approval.
 */
CREATE OR REPLACE FUNCTION check_meeting_session_update()
RETURNS TRIGGER AS $$
BEGIN

    RAISE EXCEPTION 'The location, date, time, or booker cannot be changed.';
    RETURN NULL;

END;
$$ LANGUAGE plpgsql;
DROP TRIGGER IF EXISTS meeting_session_update ON meeting_sessions;
CREATE TRIGGER meeting_session_update
BEFORE UPDATE OF building_floor, room, session_date, session_time, booker_id ON meeting_sessions
FOR EACH STATEMENT
EXECUTE FUNCTION check_meeting_session_update();

/**
 * Constraint 21
 * "A manager can only approve a booked meeting in the same department as the manager"
 * This is for updates (i.e., the session already exists)
 */
CREATE OR REPLACE FUNCTION check_meeting_session_update_approval_department()
RETURNS TRIGGER AS $$
BEGIN

    IF NOT is_employee_of_same_department_as_room(OLD.building_floor, OLD.room, NEW.endorser_id) THEN
        RAISE EXCEPTION 'The endorser must be a manager of the same department as the room.';
    END IF;
    RETURN NEW;

END;
$$ LANGUAGE plpgsql;
DROP TRIGGER IF EXISTS meeting_session_update_approval_department ON meeting_sessions;
CREATE TRIGGER meeting_session_update_approval_department
BEFORE UPDATE OF endorser_id ON meeting_sessions
FOR EACH ROW
EXECUTE FUNCTION check_meeting_session_update_approval_department();

/**
 * Constraint 21
 * "A manager can only approve a booked meeting in the same department as the manager"
 * This is for inserts (i.e., the approval is carried out at the same time as the booking, like when a manager books)
 */
CREATE OR REPLACE FUNCTION check_meeting_session_insert_approval_department()
RETURNS TRIGGER AS $$
BEGIN

    IF NEW.endorser_id IS NOT NULL
            AND NOT is_employee_of_same_department_as_room(NEW.building_floor, NEW.room, NEW.endorser_id) THEN
        RAISE EXCEPTION 'The endorser must be a manager of the same department as the room.';
    END IF;
    RETURN NEW;

END;
$$ LANGUAGE plpgsql;
DROP TRIGGER IF EXISTS meeting_session_insert_approval_department ON meeting_sessions;
CREATE TRIGGER meeting_session_insert_approval_department
BEFORE INSERT ON meeting_sessions
FOR EACH ROW
EXECUTE FUNCTION check_meeting_session_insert_approval_department();

/**
 * Constraint 27
 * "An approval can only be made on future meetings"
 */
CREATE OR REPLACE FUNCTION check_meeting_session_not_started()
RETURNS TRIGGER AS $$
BEGIN

    IF (OLD.session_date + OLD.session_time) <= CURRENT_TIMESTAMP THEN
        RAISE EXCEPTION 'This meeting session would have now already started or possibly even finished.';
    END IF;
    RETURN NEW;

END;
$$ LANGUAGE plpgsql;
DROP TRIGGER IF EXISTS meeting_session_not_started ON meeting_sessions;
CREATE TRIGGER meeting_session_not_started
BEFORE UPDATE OF endorser_id ON meeting_sessions
FOR EACH ROW
EXECUTE FUNCTION check_meeting_session_not_started();



-- automatically calls contact tracing
CREATE OR REPLACE FUNCTION contact_tracing_procedure()
RETURNS TRIGGER AS $$
-- DECLARE 
--     tracing_data RECORD; 
BEGIN
    PERFORM contact_tracing(NEW.eid);
    RETURN NEW; --change by shreyas
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS employee_has_fever ON health_declaration;
CREATE TRIGGER employee_has_fever
AFTER INSERT ON health_declaration
FOR EACH ROW
WHEN (NEW.fever = TRUE)
EXECUTE FUNCTION contact_tracing_procedure();

CREATE OR REPLACE FUNCTION check_update_capacity()
RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM meeting_sessions m
    WHERE NEW.room = m.room
    AND NEW.building_floor = m.building_floor
    AND OLD.update_new_cap > NEW.update_new_cap
    AND m.session_date > NEW.updated_date;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS update_capacity ON meeting_rooms;
CREATE TRIGGER update_capacity
AFTER UPDATE OF updated_new_cap ON meeting_rooms
FOR EACH ROW
EXECUTE FUNCTION check_update_capacity();

/***************************************
 * BASIC
 **************************************/

/**
 * Adds a new department with given parameters
 * only if did is unique.
 */ 
--passed 
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
 --passed
CREATE OR REPLACE FUNCTION remove_department(
    IN department_id INT
)
RETURNS VOID AS $$

	DELETE FROM Departments WHERE Departments.did = department_id;
    -- need ON DELETE for FK constraints in schema to execute assumptions

$$ Language sql;

/**
 * Adds a meeting room with the given parameters.
 * The parameters are self-explanatory.
 */
 --passed
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

CREATE OR REPLACE PROCEDURE change_capacity
	(IN floor_number INT, IN room_number INT, IN capacity INT, IN change_date DATE, IN employee_id INT)
AS $$
    BEGIN 
        IF NOT is_existing_manager(employee_id) THEN
            RAISE EXCEPTION 'Only managers are allowed to change room capacities';
        END IF;

        IF NOT is_existing_room(room_number, floor_number) THEN
            RAISE EXCEPTION 'Meeting room does not exist.';
        END IF;

        IF NOT is_employee_of_same_department_as_room(floor_number, room_number, employee_id) THEN
            RAISE EXCEPTION 'Only managers of the same department as the room are authorised to change room capacity.';
        END IF;
        
        UPDATE meeting_rooms 
        SET updated_new_cap = capacity, updated_date = change_date
        WHERE building_floor = floor_number AND room = room_number;
    END;
$$ LANGUAGE plpgsql;

-- add_employee
--passed
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
-- passed
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

CREATE OR REPLACE FUNCTION cancel_resign_emp_meeting_fn()
RETURNS TRIGGER AS $$
    BEGIN
        IF EXISTS (SELECT 1 FROM meeting_sessions m WHERE m.endorser_id = NEW.eid) THEN
            UPDATE meeting_sessions m SET m.endoser_id = NULL WHERE m.endorser_id = NEW.eid;
        END IF; 
        IF EXISTS (SELECT 1 FROM meeting_sessions m WHERE m.booker_id = NEW.eid) THEN 
            DELETE FROM meeting_sessions m WHERE m.booker_id = NEW.eid;
        END IF;

        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS cancel_resign_emp_meeting ON employees;
CREATE TRIGGER cancel_resign_emp_meeting 
    BEFORE UPDATE ON employees 
    FOR EACH ROW EXECUTE FUNCTION 
    cancel_resign_emp_meeting_fn();

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

        IF NOT (is_on_the_hour(start_hour) AND is_on_the_hour(end_hour)) THEN
            RAISE EXCEPTION 'All hours must be exactly on the hour.';
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
    IN room_number INT,
    IN booking_date DATE,
    IN start_hour TIME,
    IN end_hour TIME,
    IN employee_id INT
    )
RETURNS VOID AS $$
DECLARE 
    temp_hour TIME := start_hour;
BEGIN 

    -- IF NOT (is_on_the_hour(start_hour) AND is_on_the_hour(end_hour)) THEN
    --     RAISE EXCEPTION 'All hours must be exactly on the hour.';
    -- END IF;

    --cannot use trigger to check clashing because need access to end hour
    WHILE temp_hour < end_hour LOOP

        IF EXISTS(SELECT 1 FROM joins j WHERE j.session_date = booking_date AND 
        j.session_time = temp_hour AND j.eid = employee_id) THEN 
            RAISE EXCEPTION 'the booker cannot participate in the meeting, please choose another timing';
        END IF;
        temp_hour := temp_hour + interval '1 hour';
    END LOOP;
    
    --Dealing with the case when a sub set of the time interval has already been booked
    temp_hour := start_hour;
    WHILE temp_hour < end_hour LOOP

        IF EXISTS(SELECT 1 FROM meeting_sessions m WHERE m.session_date = booking_date AND 
        m.session_time = temp_hour AND m.building_floor = floor_number AND m.room = room_number) THEN 
            RAISE EXCEPTION 'this booking time slot is already occupied, please select another timing';
        END IF;
        temp_hour := temp_hour + interval '1 hour';
    END LOOP;

    temp_hour := start_hour;
    WHILE temp_hour < end_hour  LOOP
        INSERT INTO 
            meeting_sessions(
                room,
                building_floor,
                session_date,
                session_time,
                booker_id
            )
            VALUES (
                room_number,
                floor_number,
                booking_date,
                temp_hour,
                employee_id
            );

        temp_hour := temp_hour + interval '1 hour';
    END LOOP;

    --cannot use trigger with this because then we will not have access to end_hour parameter when using NEW.
    temp_hour := start_hour;
    WHILE temp_hour < end_hour LOOP
        INSERT INTO joins 
        VALUES (
            employee_id,
            room_number,
            floor_number,
            booking_date,
            temp_hour
        );

        temp_hour := temp_hour + interval '1 hour';
    END LOOP;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION has_fever_recently()
    RETURNS TRIGGER AS $$
    DECLARE 
    employee_id INTEGER;
    dec_date DATE;
    isFever BOOLEAN;
    temp_date DATE;
    recent_declare_date DATE;
    myCounter INTEGER := 1;
    BEGIN 

    IF NOT EXISTS(SELECT 1 FROM health_declaration WHERE eid = NEW.booker_id)  THEN 
        RAISE EXCEPTION 'Employee has never declared their temperature, temperature needs to be declared before room booking can be done';
    END IF;
    
    dec_date := (SELECT declaration_date FROM health_declaration WHERE eid = NEW.booker_id
                AND fever = TRUE ORDER BY declaration_date DESC LIMIT 1);

    IF NEW.session_date <= dec_date + integer '7' THEN
        RAISE EXCEPTION 'The employee cannot make a booking because he has a fever and cannot participate within 7 days from when he has the fever'; 
    END IF;

    RETURN NEW; --insertion occurs
    END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS check_has_fever_recently ON meeting_sessions;
CREATE TRIGGER check_has_fever_recently
    BEFORE INSERT ON meeting_sessions
    FOR EACH ROW EXECUTE FUNCTION 
    has_fever_recently();

CREATE OR REPLACE FUNCTION booker_is_resign_emp_fn() 
    RETURNS TRIGGER AS $$
    BEGIN 

    IF is_retired_employee(NEW.booker_id) THEN
        RAISE EXCEPTION 'resigned employee cannot make a booking';
    END IF; 

    RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS booker_is_resign_emp ON meeting_sessions;
CREATE TRIGGER booker_is_resign_emp
    BEFORE INSERT ON meeting_sessions
    FOR EACH ROW EXECUTE FUNCTION 
    booker_is_resign_emp_fn();


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
    IN room_num INT,
    IN booking_date DATE,
    IN start_hour TIME,
    IN end_hour TIME,
    IN employee_id INT
    )
RETURNS VOID AS $$
    DECLARE 
        flag INTEGER:= 1;
        temp_hour TIME := start_hour;
    BEGIN 

    WHILE temp_hour < end_hour LOOP
        IF NOT EXISTS(SELECT 1 FROM meeting_sessions m WHERE 
                m.room = room_num 
                AND m.building_floor = floor_number 
                AND m.session_date = booking_date 
                AND m.session_time = temp_hour 
                AND m.booker_id = employee_id
            ) THEN 
            flag = 0;
            EXIT;
        END IF;

        temp_hour := temp_hour + interval '1 hour';

    END LOOP;

    IF  flag = 1 THEN

        DELETE FROM meeting_sessions m
        WHERE 
            m.room = room_num 
            AND m.building_floor = floor_number
            AND m.session_date = booking_date
            AND m.session_time >= start_hour
            AND m.session_time < end_hour
            AND m.booker_id = employee_id;

    ELSE 
        RAISE EXCEPTION 'Booking does not exist';
    END IF;

    END;

$$ LANGUAGE plpgsql;


DROP FUNCTION IF EXISTS join_meeting;
CREATE OR REPLACE FUNCTION join_meeting (
    IN building_floor INT,
    IN room INT,
    IN session_date_ DATE,
    IN start_hour TIME,
    IN end_hour TIME,
    IN employee_id INT
    )
RETURNS VOID AS $$

DECLARE 
    temp_time TIME := start_hour;
    temp_time2 TIME := start_hour;
BEGIN

    IF NOT (is_existing_meeting(building_floor, room, session_date_, start_hour, end_hour)) THEN
        RAISE EXCEPTION 'Meeting session does not exist.';
    END IF;

    IF (is_approved_session(building_floor, room, session_date_, start_hour)) THEN
        RAISE EXCEPTION 'Meeting has been approved, employee disallowed to join.';
    END IF;

    IF (is_retired_employee(employee_id)) THEN
        RAISE EXCEPTION 'Retired employees are not allowed to join meetings.';
    END IF;

    IF NOT (is_on_the_hour(start_hour) AND is_on_the_hour(end_hour)) THEN
        RAISE EXCEPTION 'All hours must be exactly on the hour.';
    END IF;

    IF (has_fever_employee(employee_id)) THEN
        RAISE EXCEPTION 'Employee % has a fever, unable to join meeting.', eid; -- eid was causing an error need to find out if it actually works, otherwise remove it 
    END IF;

    IF NOT (session_date_ > CURRENT_DATE OR (session_date_ = CURRENT_DATE AND start_hour > CURRENT_TIME)) THEN 
        RAISE EXCEPTION 'Meeting is currently/has already occurred.';
    END IF;

    IF (is_meeting_session_full(building_floor, room, session_date_, start_hour)) THEN
        RAISE EXCEPTION 'The meeting room is already full.';
    END IF;

    -- check clashing 
    WHILE temp_time2 < end_hour LOOP
        IF EXISTS (
            SELECT 1 
            FROM joins j
            WHERE employee_id = j.eid
            AND session_date_ = j.session_date
            AND (
                temp_time2 = j.session_time
                OR end_hour = j.session_time
            )) THEN
            RAISE EXCEPTION 'Employee is already attending a meeting at the same timing';
        ELSE
            temp_time2 := temp_time2 + INTERVAL '1 hour';
        END IF;
    END LOOP;

     -- if not clashing, assumes employee will attend until the stated hours if start AND end hour is within the session.
    WHILE temp_time < end_hour LOOP
        INSERT INTO joins(eid, room, building_floor, session_date, session_time) VALUES (employee_id, room, building_floor, session_date_, temp_time);
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

    IF NOT (is_on_the_hour(start_hour) AND is_on_the_hour(end_hour)) THEN
        RAISE EXCEPTION 'All hours must be exactly on the hour.';
    END IF;

    IF NOT is_existing_meeting(floor_number, room_number, meeting_date, start_hour, end_hour) THEN
        RAISE EXCEPTION 'This meeting does not exist.';
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
        RAISE EXCEPTION 'If the employee was originally joining some session within the duration, '
                'then they must have been originally joining all the sessions within the duration '
                'to leave them all.';
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
                'then they must be the booker of all the sessions within the duration '
                'to leave them all.';
    END IF;

    IF is_booker_of_some_session THEN
        PERFORM unbook_room(floor_number, room_number, meeting_date, start_hour, end_hour, employee_id);
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

    IF NOT (is_on_the_hour(start_hour) AND is_on_the_hour(end_hour)) THEN
        RAISE EXCEPTION 'All hours must be exactly on the hour.';
    END IF;

    IF NOT is_existing_meeting(floor_number, room_number, meeting_date, start_hour, end_hour) THEN
        RAISE EXCEPTION 'This meeting does not exist.';
    END IF;

    IF (meeting_date + start_hour) <= CURRENT_TIMESTAMP THEN
        RAISE EXCEPTION 'This meeting would have already started or possibly even finished.';
    END IF;

    WHILE session_hour < end_hour LOOP
        IF is_approved_session(floor_number, room_number, meeting_date, session_hour) THEN
            RAISE EXCEPTION 'None of the sessions in the meeting must already be approved.';
        END IF;
        session_hour := session_hour + INTERVAL '1 hour';
    END LOOP;

    UPDATE
        meeting_sessions
    SET
        endorser_id = employee_id
    WHERE
        building_floor = floor_number
        AND room = room_number
        AND session_date = meeting_date
        AND session_time >= start_hour
        AND session_time < end_hour;

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


CREATE OR REPLACE FUNCTION contact_tracing_helper (
    employee_id INT
    )
RETURNS TABLE (
    eid INT
    ) AS $$
BEGIN
    RETURN QUERY 
        SELECT DISTINCT j1.eid
        FROM joins j1,
            (SELECT DISTINCT j.room, j.building_floor, j.session_date, j.session_time -- all meeting sessions that infected employee attends
            FROM meeting_sessions m, joins j
            WHERE j.eid = employee_id
            AND j.room = m.room
            AND j.building_floor = m.building_floor
            AND j.session_date = m.session_date
            AND j.session_time = m.session_time
            AND m.endorser_id IS NOT NULL -- alr approved meetings
            AND m.session_date >= (CURRENT_DATE - interval '3 days') 
            AND m.session_date <= CURRENT_DATE
            ) t1
        WHERE j1.room = t1.room
        AND j1.building_floor = t1.building_floor
        AND j1.session_date = t1.session_date
        AND j1.session_time = t1.session_time
        AND j1.eid <> employee_id; 
END;
$$ LANGUAGE plpgsql;


DROP FUNCTION IF EXISTS contact_tracing;
CREATE OR REPLACE FUNCTION contact_tracing (
    employee_id INT
    -- tracing_date DATE
)
RETURNS TABLE (
    eid INT
) AS $$
DECLARE
    cancelled_bookings RECORD;
    cancelled_future_meeting RECORD;
    quarantine_future_meeting RECORD;
    -- quarantine_employees RECORD;
    temp_bookings RECORD;
    cur REFCURSOR;
    temp RECORD;
    duration INT;
BEGIN
    CREATE TEMP TABLE IF NOT EXISTS quarantine_employees AS
        SELECT DISTINCT j1.eid
            FROM joins j1,
                (SELECT DISTINCT j.room, j.building_floor, j.session_date, j.session_time -- all meeting sessions that infected employee attends
                FROM meeting_sessions m, joins j
                WHERE j.eid = employee_id
                AND j.room = m.room
                AND j.building_floor = m.building_floor
                AND j.session_date = m.session_date
                AND j.session_time = m.session_time
                AND m.endorser_id IS NOT NULL -- alr approved meetings
                AND m.session_date >= (CURRENT_DATE - interval '3 days') 
                AND m.session_date <= CURRENT_DATE
                ) t1
            WHERE j1.room = t1.room
            AND j1.building_floor = t1.building_floor
            AND j1.session_date = t1.session_date
            AND j1.session_time = t1.session_time
            AND j1.eid <> employee_id; 

    --return empty table if employee doesnt have fever
    IF NOT (has_fever_employee(employee_id)) THEN
        RETURN QUERY
        SELECT e.eid
        FROM employees e WHERE 1=0;
    END IF;

    -- potential error in %. at most just remove the second % and just:
    RAISE INFO 'Employee % has fever. Close contacts are as follows:', employee_id;


    FOR quarantine_future_meeting IN
        SELECT *
        FROM joins j, quarantine_employees q
        WHERE j.eid = q.eid
        AND (j.session_date >= CURRENT_DATE AND j.session_date <= (CURRENT_DATE + interval '7 days'))
    LOOP
        PERFORM remove_employee_meeting(
            quarantine_future_meeting.building_floor,
            quarantine_future_meeting.room,
            quarantine_future_meeting.session_date,
            quarantine_future_meeting.session_time,
            (quarantine_future_meeting.session_time + interval '1 hour'),
            quarantine_future_meeting.eid
        );
    END LOOP;

    -- If the employee is the one booking the room, the booking is cancelled, approved or not.
    -- HANDLED BY block_fever_employee_joining(), but implemented in case health dclaration happens after booking meeting
    FOR cancelled_bookings IN
        (SELECT *
        -- INTO temp_bookings
        FROM meeting_sessions m
        WHERE (m.session_date > CURRENT_DATE OR (m.session_date = CURRENT_DATE AND m.session_time > CURRENT_TIME))
        AND booker_id = employee_id)
    LOOP
        -- IF EXISTS (SELECT 1 FROM temp_bookings) THEN
        -- IF EXISTS (SELECT 1 FROM cancelled_bookings) THEN 
            PERFORM unbook_room (
                cancelled_bookings.building_floor,
                cancelled_bookings.room,
                cancelled_bookings.session_date,
                cancelled_bookings.session_time,
                (cancelled_bookings.session_time + interval '1 hour'),
                employee_id
            );
        -- END IF;
    END LOOP;
    
    -- The employee with feveris removed from all future meeting room booking, approved or not. (not booker)
    FOR cancelled_future_meeting IN
        SELECT *
        FROM joins j
        WHERE (j.session_date > CURRENT_DATE OR (j.session_date = CURRENT_DATE AND j.session_time > CURRENT_TIME)) 
        AND j.eid = employee_id
    LOOP
        PERFORM remove_employee_meeting (
            cancelled_future_meeting.building_floor,
            cancelled_future_meeting.room,
            cancelled_future_meeting.session_date,
            cancelled_future_meeting.session_time,
            (cancelled_future_meeting.session_time + interval '1 hour'),
            cancelled_future_meeting.eid
        );
    END LOOP;

    -- return table
    RETURN QUERY
        SELECT * FROM quarantine_employees;

END
$$ LANGUAGE plpgsql;

-- CALL declare_health (2, '2021-11-05', 38); 

/***************************************
 * ADMIN
 **************************************/

CREATE OR REPLACE FUNCTION non_compliance_helper (
    IN begin_date DATE,
    IN end_date DATE)
RETURNS TABLE(eid INTEGER, num_of_days INTEGER) 
AS $$
DECLARE 
    table_cursor CURSOR FOR (SELECT e.eid, e.resigned_date FROM employees e);
    temp_date DATE := begin_date;
    table_record RECORD;
    day_counter INTEGER := 0;
BEGIN 
    
    OPEN table_cursor;

    LOOP
        FETCH table_cursor INTO table_record;
        EXIT WHEN NOT FOUND;
        
        CONTINUE WHEN table_record.resigned_date IS NOT NULL;
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


-- -- CREATE OR REPLACE FUNCTION view_future_meeting
CREATE OR REPLACE FUNCTION view_future_meeting (
    session_date_ DATE,
    employee_id INT
)
RETURNS TABLE (
    floor_number INT,
    room_number INT,
    session_date DATE,
    start_hour TIME
    )
AS $$
    SELECT j.building_floor, j.room, j.session_date, j.session_time
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
$$ LANGUAGE sql;


-- CREATE OR REPLACE FUNCTION view_manager_report
-- view_manager_report: This routine is to be used by manager to find all meeting rooms that require approval. The
-- inputs to the routine should minimally include:
    -- Start date
    -- Employee ID
-- If the employee ID does not belong to a manager, the routine returns an empty table. Otherwise, the routine
-- returns a table containing all meeting that are booked but not yet approved from the given start date onwards.
-- Note that the routine should only return all meeting in the room with the same department as the manager.
-- The table returned should minimally include the following columns:
    -- Floor number
    -- Room number
    -- Date
    -- Start hour
    -- Employee ID
-- The table should be sorted in ascending order of date and start hour.
CREATE OR REPLACE FUNCTION view_manager_report(
    start_date_ DATE, -- named with a trailing underscore because start_date seems like a postgresql keyword
    employee_id INT
)
RETURNS TABLE(
    floor_number INT,
    room_number INT,
    session_date DATE,
    start_hour TIME,
    booker_id INT
) AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM manager m WHERE m.eid = employee_id) THEN
        RETURN QUERY
        SELECT
            m.building_floor AS floor_number,
            m.room AS room_number,
            m.session_date AS session_date,
            m.session_time AS start_hour,
            m.booker_id AS booker_id
        FROM meeting_sessions m WHERE 1=0;
        -- RAISE EXCEPTION 'This employee is not a manager';
    ELSE
        RETURN QUERY
        SELECT
            s.building_floor AS floor_number,
            s.room AS room_number,
            s.session_date AS session_date,
            s.session_time AS start_hour,
            s.booker_id AS booker_id
        FROM
            (meeting_sessions NATURAL JOIN meeting_rooms) s
        WHERE
            s.session_date >= start_date_ -- returns a table containing all meeting that are booked but not yet approved from the given start date onwards.
            AND s.endorser_id IS NULL
            AND EXISTS (SELECT eid FROM (manager NATURAL JOIN employees) m WHERE s.did = m.did AND m.eid = employee_id) -- Note that the routine should only return all meeting in the room with the same department as the manager.
                
        -- The table should be sorted in ascending order of date and start hour.
        ORDER BY
            s.session_date ASC,
            s.session_time ASC;
    END IF;
END;
$$ LANGUAGE plpgsql;
