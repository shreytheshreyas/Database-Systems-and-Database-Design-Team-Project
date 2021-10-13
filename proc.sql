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

-- CREATE OR REPLACE FUNCTION add_department

-- CREATE OR REPLACE FUNCTION remove_department

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
