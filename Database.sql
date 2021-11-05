    DROP TABLE IF EXISTS employees, junior, booker, senior, manager, health_declaration,
departments, meeting_rooms, meeting_sessions, joins CASCADE;

--Employees
--Constraints 1,2,33 are enforced
CREATE TABLE employees(
    eid SERIAL CONSTRAINT employees_pk PRIMARY KEY,
    ename TEXT,
    email TEXT GENERATED ALWAYS AS ('xyz' || CAST (eid AS TEXT) || '@company.com') STORED,-- UNIQUE constraint is implicit because of GENERATED ALWAYS 
    ekind TEXT,
    did INTEGER NOT NULL DEFAULT 0,
    resigned_date DATE DEFAULT NULL,
    mobile_contact INTEGER,
    home_contact INTEGER,
    office_contact INTEGER
);

CREATE TABLE junior(
    eid INTEGER CONSTRAINT junior_pk PRIMARY KEY,
    CONSTRAINT junior_emp_fk_constraint FOREIGN KEY (eid) REFERENCES employees(eid)
);

--Constraints 13,14 is enforced
CREATE TABLE booker(
    eid INTEGER CONSTRAINT booker_pk PRIMARY KEY,
    CONSTRAINT booker_emp_fk_constraint FOREIGN KEY (eid) REFERENCES employees(eid) 
);

CREATE TABLE senior(
    eid INTEGER CONSTRAINT senior_pk PRIMARY KEY,
    CONSTRAINT senior_booker_fk_constraint FOREIGN KEY (eid) REFERENCES booker(eid) 
);

CREATE TABLE manager(
    eid INTEGER CONSTRAINT manager_pk PRIMARY KEY,
    CONSTRAINT manager_booker_fk_constraint FOREIGN KEY (eid) REFERENCES booker(eid)
);

--Health Declaration
--Constraint 29,30,31 enforced
CREATE TABLE health_declaration(
    eid INTEGER,
    declaration_date DATE,
    temperature NUMERIC CHECK (temperature >= 34 AND temperature <= 43) NOT NULL, 
    fever BOOLEAN GENERATED ALWAYS AS (temperature > 37.5) STORED, 
    CONSTRAINT health_declaration_pk PRIMARY KEY(eid,declaration_date),
    CONSTRAINT health_declaration_emp_fk_constraint FOREIGN KEY (eid) REFERENCES employees(eid)
);

--DEPARTMENTS INFORMATION 
CREATE TABLE departments(
    did INTEGER CONSTRAINT departments_pk PRIMARY KEY,
    dname TEXT NOT NULL
);

--Adding department foreign key constraint to employees. Constraint 8 is enforces
ALTER TABLE employees ADD CONSTRAINT employee_dept_fk_constraint FOREIGN KEY (did) REFERENCES departments(did) ON DELETE SET DEFAULT; 

-- ALTER TABLE employees ALTER COLUMN did SET DEFAULT 'HR'; 

--Meeting_room_entity, Located_In_entity and Updates_entity 
--Ask Prof adi if updates should be a seperate table to keep past capacities for each room. 
--Problem if we keep a seperate table is because total participation is not fully enforced which contradicts the ER.
CREATE TABLE meeting_rooms(
    room INTEGER,
    building_floor INTEGER,
    rname TEXT,
    did INTEGER NOT NULL DEFAULT 0, --constraint 10 is enforced.
    updated_new_cap INTEGER NOT NULL,
    updated_date DATE,
    CONSTRAINT meeting_rooms_pk PRIMARY KEY(room,building_floor),
    CONSTRAINT meeting_room_dept_fk_constraint FOREIGN KEY (did) REFERENCES departments(did) ON DELETE SET DEFAULT
);

--Sessions Enity, Books Entity, Approves Entity - Need Group's opinion
--Enforces Constraints 15,20 
--Help Session: AskProf Adi for Constriants 25,27
--Does check constraint check all the tuples continously or only during insertion?
--Problem can bve rectified if we only include the booked sessions?
--worst case scenario -- include booked sessions only and during insertion use a trigger to check if that date,time and room is taken, if it is make the insertion, if its not reject it.
CREATE TABLE meeting_sessions(
    room INTEGER,
    building_floor INTEGER,
    session_date DATE,
    session_time TIME,
    booker_id INTEGER DEFAULT NULL,
    endorser_id INTEGER DEFAULT NULL, 
    CONSTRAINT meeting_sessions_pk PRIMARY KEY(room,building_floor,session_date,session_time),
    CONSTRAINT session_meeting_room_fk_constraint FOREIGN KEY (room,building_floor) REFERENCES meeting_rooms(room,building_floor) ON DELETE CASCADE,
    CONSTRAINT session_booker_fk_constraint FOREIGN KEY (booker_id) REFERENCES booker(eid),
    CONSTRAINT endorser_id_fk_constraint FOREIGN KEY (endorser_id) REFERENCES manager(eid)
);

--Joins entity (potential viloation of total participation constraint)
--Constraint 17 enforced
--Constraint 26 enforced
CREATE TABLE joins(
    eid INTEGER,
    room INTEGER,
    building_floor INTEGER,
    session_date DATE,
    session_time TIME,
    CONSTRAINT joins_pk PRIMARY KEY(eid,room,building_floor,session_date,session_time),
    CONSTRAINT joins_employee_fk_constraint FOREIGN KEY (eid) REFERENCES employees(eid),
    CONSTRAINT joins_meeting_sessions_fk_constraint FOREIGN KEY (room,building_floor,session_date,session_time) REFERENCES meeting_sessions(room,building_floor,session_date,session_time)  ON DELETE CASCADE,
    CONSTRAINT valid_meeting_entry CHECK(session_date > CURRENT_DATE OR (session_date = CURRENT_DATE AND session_time > CURRENT_TIME))
);

--Other Constraints 
--Constraint 16 - Can be enforced in the designated sql function I think
--Constraint 18 - Can be enforced in the function or trigger
--Constraint 19 - Condition check in designated function required
--Constraint 21 - Condition check in the designated function required
--Constraint 22 - Condition check in the designated function required
--Constraint 23 - Trigger required for this constraint
--Constraint 24 - Condition check in the designated function required
--Constraint 25 - Condition check in the designated function required
--Constraint 27 - Trigger required for this constraint
--Constraint 28 - Dont think it is enforced, but does it need to be?
--Constraint 34 -- Condition check in the designated function required
--Need to check contact tracing constraint E.g All those in close contact with an employee with fever cannot book a room and are removed from future meetings