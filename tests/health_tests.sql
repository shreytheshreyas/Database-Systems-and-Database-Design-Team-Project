-- declare_health, ERROR: employee that does not exist
CALL declare_health (100, '6/11/2021'::DATE, 36.4); 

-- declare_health, ERROR: temperature out of range
CALL declare_health (59, '9/11/2021'::DATE, 44);
CALL declare_health (59, '9/11/2021'::DATE, 20);  

-- declare_health, ERROR: date is in the future
CALL declare_health (59, '9/11/2022'::DATE, 36.4);

-- declare_health, works
CALL declare_health (1, '5/11/2021'::DATE, 36.4); 

-- contact_tracing, employee that is well
-- employee did attend meetings in the past w three other employees and is sick
-- all 4 employees from same department join meeting room: 3 floor: 2  date: 2021-01-11 
-- room 3, 2, from department 6

-- SELECT join_meeting (3, 2, '1/11/2021'::DATE, '11:00'::TIME, '12:00'::TIME, 7);
-- SELECT join_meeting (3, 2, '1/11/2021'::DATE, '11:00'::TIME, '12:00'::TIME, 17);
-- SELECT join_meeting (3, 2, '1/11/2021'::DATE, '11:00'::TIME, '12:00'::TIME, 27);
-- SELECT join_meeting (3, 2, '1/11/2021'::DATE, '11:00'::TIME, '12:00'::TIME, 37);

-- current error i am getting w the above code:
-- psql:./Documents/code/cs2102-group-project/tests/health_tests.sql:19: ERROR:  Meeting has been approved, employee disallowed to join.
-- CONTEXT:  PL/pgSQL function join_meeting(integer,integer,date,time without time zone,time without time zone,integer) line 13 at RAISE

-- -- meeting that has not been approved yet
SELECT join_meeting (3, 4, '2021-12-11', '16:00'::TIME, '17:00'::TIME, 2);
SELECT join_meeting (3, 4, '2021-12-11', '16:00'::TIME, '17:00'::TIME, 12);
SELECT join_meeting (3, 4, '2021-12-11', '16:00'::TIME, '17:00'::TIME, 22);
SELECT join_meeting (3, 4, '2021-12-11', '16:00'::TIME, '17:00'::TIME, 32);

-- approve_meeting
SELECT approve_meeting(3, 4, '2021-12-11', '16:00'::TIME, '17:00'::TIME, 2);

-- future_meeting for employee 2
SELECT book_room (3, 4, '2021-12-13', '16:00'::TIME, '17:00'::TIME, 2);
-- SELECT join_meeting (3, 4, '2021-12-13', '16:00'::TIME, '17:00'::TIME, 2);
SELECT approve_meeting (3, 4, '2021-12-13', '16:00'::TIME, '17:00'::TIME, 2);

-- make one employee sick
CALL declare_health (2, '2021-12-11', 38); 
-- -- -- run contact_tracing
SELECT contact_tracing (2);
