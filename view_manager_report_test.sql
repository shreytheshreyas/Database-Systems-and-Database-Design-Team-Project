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
-- Inserting data meeting rooms table 
-- DELETE FROM meeting_rooms;

SELECT add_room(1,1,'one',20,1);
SELECT add_room(1,2,'two',35,1);
SELECT add_room(1,3,'three',50,1);
SELECT add_room(1,4,'four',25,1);

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
SELECT add_room(4,3,'three',10,1);
SELECT add_room(4,4,'four',10,1);

--Inserting data to meeting_sessions
INSERT INTO meeting_sessions VALUES (4,3,'2021-10-27','13:00:00',1,NULL);
INSERT INTO meeting_sessions VALUES (1,1,'2021-10-27','14:00:00',1,NULL);
INSERT INTO meeting_sessions VALUES (4,1, '2021-10-27','13:00:00',1,NULL);
INSERT INTO meeting_sessions VALUES (4,1, '2021-10-27','14:00:00',1,NULL);
INSERT INTO meeting_sessions VALUES (4,1, '2021-10-27','15:00:00',1,NULL);


-- serach room_functionality
SELECT view_manager_report('2021-10-27', 1);
SELECT view_manager_report('2021-10-27', 2);