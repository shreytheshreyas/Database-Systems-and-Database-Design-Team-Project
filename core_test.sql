-- search_room test cases
SELECT * FROM search_room (22,'2021-11-20', '1400', '1600'); -- normal case 
SELECT * FROM search_room (30,'2021-11-15', '1100', '1600'); --normal case
SELECT * FROM search_room (10,'2021-11-17', '1600','1800'); -- exception case

-- book_room test cases
SELECT book_room(2,4,'2021-11-20','1400','1600',11);
SELECT book_room(3,4,'2021-11-15','1400','1600',14);
SELECT book_room(3,4,'2021-11-20','1400','1600',11);
SELECT book_room(2,4,'2021-11-21','1100','1600',12);
SELECT book_room(3,4,'2021-11-21','0900','1200',11);

--unbook_room test cases
SELECT  unbook_room (2,4, '2021-11-20', '1400', '1600', 11); --unbooking an existing meeting_session_room
SELECT unbook_room(3,4,'2021-11-15','1400','1600',14); -- unbooking a non - existent meeting_session_room

-- join_meeting test cases
SELECT join_meeting (2, 4, '2021-11-21', '1100', '1600', 21); -- joining an existant unapproved meeting
-- SELECT join_meeting (2, 4,  '2021-11-22', '1100', '1600', 21); -- joining a non-existant meeting
-- SELECT join_meeting (2, 4,  '2021-11-21', '0900', '1200', 21); -- joining a meeting whose timing clashes with another meeting  

-- 