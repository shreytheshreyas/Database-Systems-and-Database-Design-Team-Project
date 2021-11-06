--Inserting Data into the Departments Table
SELECT add_department(0,'HR');
SELECT add_department(1,'Technology');
SELECT add_department(2,'Marketing');
SELECT add_department(3,'Finance');
SELECT add_department(4,'Operations');

--Inserting Data into Employees Table 
CALL add_employee('shreyas','manager',1,91836081,65731233,65241333);
CALL add_employee('krabs','senior',3,91836081,65731233,65241333);
CALL add_employee('squidward','senior',2,91836081,65731233,65241333);
CALL add_employee('spongebob','junior',4,91836081,65731233,65241333);
CALL add_employee('patrick','junior',4,91836081,65731233,65241333); 

--Check for resigned Employees
CALL remove_employee(1, CURRENT_DATE); -- eid = 1

-- Inserting Data for meeting_rooms
SELECT add_room(1,1,'one',20,0);
SELECT add_room(1,2,'two',35,0);
SELECT add_room(1,3,'three',50,0);
SELECT add_room(1,4,'four',25,0);

SELECT add_room(2,1,'one',15,1);
SELECT add_room(2,2,'two',30,1);
SELECT add_room(2,3,'three',50,1);
SELECT add_room(2,4,'four',40,1);

SELECT add_room(3,1,'one',10,2);
SELECT add_room(3,2,'two',15,2);
SELECT add_room(3,3,'three',10,2);
SELECT add_room(3,4,'four',20,2);

SELECT add_room(4,1,'one',10,3);
SELECT add_room(4,2,'two',10,3);
SELECT add_room(4,3,'three',10,3);
SELECT add_room(4,4,'four',10,3);

--Inserting data to meeting_sessions
INSERT INTO meeting_sessions VALUES (4,3,'2021-11-27','13:00:00',1,NULL);
INSERT INTO meeting_sessions VALUES (1,1,'2021-10-27','14:00:00',1,NULL);
INSERT INTO meeting_sessions VALUES (4,1, '2021-11-27','13:00:00',1,NULL);
INSERT INTO meeting_sessions VALUES (4,1, '2021-11-27','14:00:00',1,NULL);
INSERT INTO meeting_sessions VALUES (4,1, '2021-11-27','15:00:00',1,NULL);

-- check 1H meetings
SELECT join_meeting(4,3, '2021-11-27','13:00:00', '14:00:00', 3);

-- check >1H meetings
SELECT join_meeting(4,1, '2021-11-27','13:00:00', '15:00:00', 2); -- can join 2/3 the meeting; need not attend in full
SELECT join_meeting(4,1, '2021-11-27','13:00:00', '16:00:00', 2); -- cannot change meeting attendance timing
SELECT join_meeting(4,1, '2021-11-27','13:00:00', '16:00:00', 4); 
SELECT join_meeting(4,1, '2021-11-27','13:00:00', '17:00:00', 5); -- cannot exceed session timing -> will return session does not exist*


-- check approved 
-- check fever 

-- check future date
SELECT join_meeting(1,1, '2021-10-27','14:00:00', '15:00:00', 3);

-- check resigned employees *****
    SELECT join_meeting(4,1, '2021-11-27','13:00:00', '15:00:00', 1);

