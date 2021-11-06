-- search_room test cases
SELECT * FROM search_room (22,'2021-11-20', '1400', '1600'); -- normal case 
SELECT * FROM search_room (30,'2021-11-15', '1100', '1600'); --normal case
SELECT * FROM search_room (10,'2021-11-17', '1600','1800'); -- exception case

-- book_room test cases
SELECT book_room(2,4,'2021-11-20','1400','1600',11);
SELECT book_room(3,4,'2021-11-15','1400','1600',14);
SELECT book_room(2,4,'2021-11-20','1400','1600',12);
