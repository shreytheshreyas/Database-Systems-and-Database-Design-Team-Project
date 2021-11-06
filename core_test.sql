-- search_room test cases
SELECT * FROM search_room (22,'2021-11-20', '1400', '1600'); -- normal case 
SELECT * FROM search_room (30,'2021-11-15', '1100', '1600'); --normal case
SELECT * FROM search_room (10,'2021-11-17', '1600','1800'); -- exception case

-- book_room test cases
SELECT book_room(2,3,'2021-11-20','1400','1600',11); -- booking takes place
SELECT book_room(3,3,'2021-11-15','1400','1600',14); -- booking takes place
SELECT book_room(3,3,'2021-11-20','1400','1600',11); -- booking never takes place because of a clash
SELECT book_room(2,3,'2021-11-21','1100','1600',12); -- takes place
SELECT book_room(3,3,'2021-11-21','0900','1200',60); -- employee with this id is resigned

--unbook_room test cases
SELECT  unbook_room (2,3, '2021-11-20', '1400', '1600', 11); --unbooking an existing meeting_session_room
SELECT unbook_room(3,1,'2021-11-15','1400','1600',14); -- unbooking a non - existent meeting_session_room

-- join_meeting test cases
SELECT join_meeting (2, 3, '2021-11-21', '1100', '1600', 21); -- joining an existant unapproved meeting
SELECT join_meeting (2, 4,  '2021-11-22', '1100', '1600', 21); -- joining a non-existant meeting
SELECT join_meeting (3, 3,  '2021-11-21', '0900', '1200', 21); -- meeting is never booked the employee eid at line 11 has resigned from the company
SELECT join_meeting (3, 3, '2021-11-15', '1400', '1600',3); --shouldn't be able to join because of the employee is taking part in another meeting 
-- 