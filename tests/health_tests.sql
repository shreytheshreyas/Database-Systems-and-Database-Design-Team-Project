-- declare_health, ERROR: employee that does not exist
CALL declare_health (100, '6/11/2021'::DATE, 36.4); 

-- declare_health, ERROR: temperature out of range
CALL declare_health (60, '6/11/2021'::DATE, 44);
CALL declare_health (60, '6/11/2021'::DATE, 20);  

-- declare_health, ERROR: date is in the future
CALL declare_health (60, '6/11/2022'::DATE, 36.4);

-- declare_health, works
CALL declare_health (1, '6/11/2021'::DATE, 36.4); 

-- contact_tracing, employee that is well
-- employee did attend meetings in the past w three other employees and is sick
-- all 4 employees from same department join meeting room: 3 floor: 2  date: 2021-01-11 

SELECT join_meeting (3, 2, '1/11/2021'::DATE, '11:00'::TIME, '12:00'::TIME, 2);
SELECT join_meeting (3, 2, '1/11/2021'::DATE, '11:00'::TIME, '12:00'::TIME, 12);
SELECT join_meeting (3, 2, '1/11/2021'::DATE, '11:00'::TIME, '12:00'::TIME, 22);
SELECT join_meeting (3, 2, '1/11/2021'::DATE, '11:00'::TIME, '12:00'::TIME, 32);

-- -- meeting that has not been approved yet
-- SELECT join_meeting (4, 3, '12/11/2021'::DATE, '16:00'::TIME, '17:00'::TIME, 3);
-- SELECT join_meeting (4, 3, '12/11/2021'::DATE, '16:00'::TIME, '17:00'::TIME, 9);
-- SELECT join_meeting (4, 3, '12/11/2021'::DATE, '16:00'::TIME, '17:00'::TIME, 19);
-- SELECT join_meeting (4, 3, '12/11/2021'::DATE, '16:00'::TIME, '17:00'::TIME, 29);

-- make one employee sick
CALL declare_health (3, '5/11/2021'::DATE, 38); 
-- run contact_tracing
SELECT contact_tracing (1);
