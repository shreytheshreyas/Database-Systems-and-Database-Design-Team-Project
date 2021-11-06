-- declare_health, ERROR: employee that does not exist
CALL declare_health (100, '6/11/2021'::DATE, 36.4); 

-- declare_health, ERROR: temperature out of range
CALL declare_health (60, '6/11/2021'::DATE, 44);
CALL declare_health (60, '6/11/2021'::DATE, 20);  

-- declare_health, ERROR: date is in the future
CALL declare_health (60, '6/11/2022'::DATE, 36.4);

-- declare_health, works
CALL declare_health (61, '6/11/2021'::DATE, 36.4); 

-- contact_tracing, employee that is well
-- employee did attend meetings in the past w three other employees and is sick
-- all 4 employees join meeting room: 3 floor: 2  date: 2021-01-11 

CALL join_meeting (3, 2, '1/11/2021'::DATE, '11:00'::TIME, '12:00'::TIME, 1);
CALL join_meeting (3, 2, '1/11/2021'::DATE, '11:00'::TIME, '12:00'::TIME, 2);
CALL join_meeting (3, 2, '1/11/2021'::DATE, '11:00'::TIME, '12:00'::TIME, 3);
CALL join_meeting (3, 2, '1/11/2021'::DATE, '11:00'::TIME, '12:00'::TIME, 4);

-- make one employee sick
CALL declare_health (1, '6/11/2021'::DATE, 40); 
-- run contact_tracing
CALL contact_tracing (1)
