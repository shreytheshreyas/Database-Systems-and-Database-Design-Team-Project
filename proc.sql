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
    floor_number BIGINT,
    room_number BIGINT,
    room_name TEXT,
    room_capacity BIGINT,
    department_id BIGINT -- extra parameter; needed for given ER model
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
