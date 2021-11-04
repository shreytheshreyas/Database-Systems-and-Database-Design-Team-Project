-- Inserting data meeting rooms table 
DELETE FROM meeting_rooms;

SELECT add_room(1,1,'one',20,0);
SELECT add_room(1,2,'two',35,0);
SELECT add_room(1,3,'three',50,0);
SELECT add_room(1,4,'four',25,0);

SELECT add_room(2,1,'one',15,0);
SELECT add_room(2,2,'two',30,0);
SELECT add_room(2,3,'three',50,0);
SELECT add_room(2,4,'four',40,0);

SELECT add_room(3,1,'one',10,0);
SELECT add_room(3,2,'two',15,0);
SELECT add_room(3,3,'three',10,0);
SELECT add_room(3,4,'four',20,0);

SELECT add_room(4,1,'one',10,0);
SELECT add_room(4,2,'two',10,0);
SELECT add_room(4,3,'three',10,0);
SELECT add_room(4,4,'four',10,0);

-- serach room_functionality
SELECT search_room(20,'2021-10-27','11:00:00','12:00:00');