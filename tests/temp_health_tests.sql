-- declare_health, ERROR: employee that does not exist
CALL declare_health (100, '6/11/2021'::DATE, 36.4); 

-- declare_health, ERROR: temperature out of range
CALL declare_health (59, '9/11/2021'::DATE, 44);
CALL declare_health (59, '9/11/2021'::DATE, 20);  

-- declare_health, ERROR: date is in the future
CALL declare_health (59, '9/11/2022'::DATE, 36.4);

-- declare_health, works
CALL declare_health (1, '5/11/2021'::DATE, 36.4); 


-- future_meeting for employee 2
SELECT book_room (3, 4, '2021-12-13', '16:00'::TIME, '17:00'::TIME, 2);
-- SELECT join_meeting (3, 4, '2021-12-13', '16:00'::TIME, '17:00'::TIME, 2);
SELECT approve_meeting (3, 4, '2021-12-13', '16:00'::TIME, '17:00'::TIME, 2);



--booking new session
SELECT book_room (3, 4, '2021-11-15', '16:00'::TIME, '17:00'::TIME, 12);

--joining newly booked_session
SELECT join_meeting (3, 4, '2021-11-15', '16:00'::TIME, '17:00'::TIME, 2);

SELECT approve_meeting(3, 4, '2021-11-15', '16:00'::TIME, '17:00'::TIME, 2);


-- make one employee sick
CALL declare_health (2, '2021-11-05', 38); 
-- run contact_tracing
SELECT contact_tracing (2);

