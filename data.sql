-- departments
INSERT INTO departments (did, dname) VALUES (0, 'Human Resources');
INSERT INTO departments (did, dname) VALUES (1, 'Product Management');
INSERT INTO departments (did, dname) VALUES (2, 'Research and Development');
INSERT INTO departments (did, dname) VALUES (3, 'Sales');
INSERT INTO departments (did, dname) VALUES (4, 'Support');
INSERT INTO departments (did, dname) VALUES (5, 'Legal');
INSERT INTO departments (did, dname) VALUES (6, 'Engineering');
INSERT INTO departments (did, dname) VALUES (7, 'Training');
INSERT INTO departments (did, dname) VALUES (8, 'Marketing');
INSERT INTO departments (did, dname) VALUES (9, 'Accounting');

-- employees
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Coop Mullinger', 'manager', 0, NULL, '649-200-2371', '206-421-8576', '596-935-1407');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Etheline Breache', 'manager', 1, NULL, NULL, NULL, NULL);
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Barbie Fallow', 'manager', 2, NULL, '627-482-4418', '940-693-7116', '944-937-6447');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Hermy Arnowitz', 'manager', 3, NULL, '806-636-1065', '980-619-5748', '359-890-9272');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Guenna Tremathick', 'manager', 4, NULL, '985-978-4479', '350-667-3121', '785-804-8192');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Joelly Ghiraldi', 'manager', 5, NULL, '150-904-1669', '305-467-7113', '727-476-6916');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Analise Cromblehome', 'manager', 6, NULL, '327-627-6127', '646-877-1184', '576-896-9601');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Bay Asplin', 'manager', 7, NULL, '334-532-9756', '560-696-1385', '866-640-5138');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Jerri Spring', 'manager', 8, '3/11/2021'::DATE, '847-655-4702', '584-679-9575', '190-593-2875');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Edan Jerrom', 'manager', 9, NULL, '511-890-8079', '328-698-6860', '604-721-9726');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Ivor Calderhead', 'senior', 0, NULL, '949-450-4347', '252-112-0040', '845-815-6728');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Adham Polet', 'senior', 1, NULL, '474-578-9169', '986-252-5122', '905-573-7669');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Farand Sheryne', 'senior', 2, '4/11/2021'::DATE, '229-805-3209', '112-621-8482', '316-833-8237');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Glenn Gartshore', 'senior', 3, NULL, '402-636-2038', '105-680-6849', '414-264-4627');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Calhoun Minchinton', 'senior', 4, NULL, '648-514-1771', '196-616-0896', '536-291-8111');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Ramona Destouche', 'senior', 5, NULL, '405-122-9314', '288-136-4989', '974-106-3040');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Lishe Gorick', 'senior', 6, NULL, '601-331-0585', '717-409-2572', '984-329-4488');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Vasilis Tole', 'senior', 7, NULL, NULL, NULL, NULL);
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Efrem Stockoe', 'senior', 8, NULL, '636-923-9146', '425-381-2501', '310-995-0238');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Wally Pourveer', 'senior', 9, NULL, '519-859-4662', '684-132-7912', '614-793-0192');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Lindi Prenty', 'junior', 0, NULL, '578-520-0268', '423-357-5779', '926-857-0855');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Mattheus Obray', 'junior', 1, NULL, NULL, NULL, NULL);
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Krista Breadon', 'junior', 2, NULL, '323-652-2307', '610-422-9534', '220-510-0244');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Iormina Sample', 'junior', 3, NULL, '824-555-2273', '432-793-0030', '366-878-6751');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Brannon Catanheira', 'junior', 4, NULL, NULL, NULL, NULL);
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Charissa Krug', 'junior', 5, NULL, '625-333-6739', '934-852-8492', '207-271-0525');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Laurent Coughlan', 'junior', 6, NULL, NULL, NULL, NULL);
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Giacopo Gutman', 'junior', 7, NULL, '338-224-5680', '330-368-4078', '187-402-9135');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Humfried Gouinlock', 'junior', 8, NULL, '117-794-0278', '873-471-5982', '422-473-5287');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Dara Palmby', 'junior', 9, NULL, '797-112-6497', '636-866-4237', '865-815-8509');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Wynn Martellini', 'manager', 0, NULL, '894-251-3326', '498-523-2052', '475-435-8934');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Lothario Greenstead', 'manager', 1, NULL, '443-552-9803', '368-472-0460', '721-179-6222');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Delores Kohlerman', 'manager', 2, NULL, '872-194-4593', '454-605-0910', '119-904-2489');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Forest Gatfield', 'manager', 3, NULL, '646-240-1646', '402-201-4225', '822-262-4522');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Karalynn Badger', 'manager', 4, NULL, '978-734-3297', '133-651-8095', '278-275-6113');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Bess Barczewski', 'manager', 5, NULL, '733-783-9158', '836-694-9298', '297-320-6793');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Ethel Dominik', 'manager', 6, '2/11/2021'::DATE, '983-820-0751', '587-548-4084', '209-353-1198');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Husain Engledow', 'manager', 7, NULL, '470-615-9840', '895-745-8340', '984-538-7949');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Xylina Passfield', 'manager', 8, NULL, '301-782-5459', '656-573-9378', '191-778-4763');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Miranda Siemon', 'manager', 9, NULL, '473-907-8398', '483-166-7592', '709-367-0533');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Alexei Langtree', 'senior', 0, NULL, NULL, NULL, NULL);
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Donna Bice', 'senior', 1, NULL, '286-134-6343', '591-713-9952', '761-338-0468');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Margret Spinas', 'senior', 2, NULL, '954-177-1540', '563-174-3328', '858-632-5932');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Jimmy Finby', 'senior', 3, '8/11/2021'::DATE, '134-859-7753', '350-235-5069', '776-285-4872');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Janis Finder', 'senior', 4, NULL, '646-763-9400', '725-448-8661', '712-168-2693');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Nani Vickar', 'senior', 5, NULL, '605-275-4927', '490-287-4691', '876-806-2906');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Cyndi Gaspard', 'senior', 6, NULL, '888-103-4385', '180-331-5737', '734-895-4518');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Sebastien Spyvye', 'senior', 7, NULL, '412-791-6379', '456-463-8647', '109-749-0816');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Wye Puzey', 'senior', 8, NULL, '735-635-3001', '611-224-9911', '444-886-2143');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Dane Garraway', 'senior', 9, NULL, '139-148-5800', '332-460-0512', '171-206-9420');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Tedman Rawcliffe', 'junior', 0, '6/11/2021'::DATE, '409-217-4507', '436-394-0417', '951-836-1479');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Jacki Livezey', 'junior', 1, NULL, NULL, NULL, NULL);
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Nate Griffitt', 'junior', 2, NULL, NULL, NULL, NULL);
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Egbert Pitbladdo', 'junior', 3, NULL, '161-124-9613', '181-510-1976', '363-248-9773');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Ramsay Faloon', 'junior', 4, NULL, '977-926-5932', '683-320-8721', '737-557-7271');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Calla Dormon', 'junior', 5, NULL, NULL, NULL, NULL);
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Boonie Sloey', 'junior', 6, '3/11/2021'::DATE, '174-748-1987', '951-697-7726', '630-126-3012');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Tally Roalfe', 'junior', 7, NULL, '938-816-2544', '530-942-2453', '236-338-3206');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Demetria Kohrt', 'junior', 8, NULL, '352-436-7869', '401-767-7721', '300-457-0830');
INSERT INTO employees (ename, ekind, did, resigned_date, mobile_contact, home_contact, office_contact) VALUES ('Brandi Graine', 'junior', 9, '2/11/2021'::DATE, '108-430-9796', '378-719-2061', '714-208-2226');

-- booker
INSERT INTO booker (eid) VALUES (1);
INSERT INTO booker (eid) VALUES (2);
INSERT INTO booker (eid) VALUES (3);
INSERT INTO booker (eid) VALUES (4);
INSERT INTO booker (eid) VALUES (5);
INSERT INTO booker (eid) VALUES (6);
INSERT INTO booker (eid) VALUES (7);
INSERT INTO booker (eid) VALUES (8);
INSERT INTO booker (eid) VALUES (9);
INSERT INTO booker (eid) VALUES (10);
INSERT INTO booker (eid) VALUES (11);
INSERT INTO booker (eid) VALUES (12);
INSERT INTO booker (eid) VALUES (13);
INSERT INTO booker (eid) VALUES (14);
INSERT INTO booker (eid) VALUES (15);
INSERT INTO booker (eid) VALUES (16);
INSERT INTO booker (eid) VALUES (17);
INSERT INTO booker (eid) VALUES (18);
INSERT INTO booker (eid) VALUES (19);
INSERT INTO booker (eid) VALUES (20);
INSERT INTO booker (eid) VALUES (31);
INSERT INTO booker (eid) VALUES (32);
INSERT INTO booker (eid) VALUES (33);
INSERT INTO booker (eid) VALUES (34);
INSERT INTO booker (eid) VALUES (35);
INSERT INTO booker (eid) VALUES (36);
INSERT INTO booker (eid) VALUES (37);
INSERT INTO booker (eid) VALUES (38);
INSERT INTO booker (eid) VALUES (39);
INSERT INTO booker (eid) VALUES (40);
INSERT INTO booker (eid) VALUES (41);
INSERT INTO booker (eid) VALUES (42);
INSERT INTO booker (eid) VALUES (43);
INSERT INTO booker (eid) VALUES (44);
INSERT INTO booker (eid) VALUES (45);
INSERT INTO booker (eid) VALUES (46);
INSERT INTO booker (eid) VALUES (47);
INSERT INTO booker (eid) VALUES (48);
INSERT INTO booker (eid) VALUES (49);
INSERT INTO booker (eid) VALUES (50);

-- manager
insert into manager (eid) values (1);
insert into manager (eid) values (2);
insert into manager (eid) values (3);
insert into manager (eid) values (4);
insert into manager (eid) values (5);
insert into manager (eid) values (6);
insert into manager (eid) values (7);
insert into manager (eid) values (8);
insert into manager (eid) values (9);
insert into manager (eid) values (10);
insert into manager (eid) values (31);
insert into manager (eid) values (32);
insert into manager (eid) values (33);
insert into manager (eid) values (34);
insert into manager (eid) values (35);
insert into manager (eid) values (36);
insert into manager (eid) values (37);
insert into manager (eid) values (38);
insert into manager (eid) values (39);
insert into manager (eid) values (40);

-- senior
insert into senior (eid) values (11);
insert into senior (eid) values (12);
insert into senior (eid) values (13);
insert into senior (eid) values (14);
insert into senior (eid) values (15);
insert into senior (eid) values (16);
insert into senior (eid) values (17);
insert into senior (eid) values (18);
insert into senior (eid) values (19);
insert into senior (eid) values (20);
insert into senior (eid) values (41);
insert into senior (eid) values (42);
insert into senior (eid) values (43);
insert into senior (eid) values (44);
insert into senior (eid) values (45);
insert into senior (eid) values (46);
insert into senior (eid) values (47);
insert into senior (eid) values (48);
insert into senior (eid) values (49);
insert into senior (eid) values (50);

-- junior
insert into junior (eid) values (21);
insert into junior (eid) values (22);
insert into junior (eid) values (23);
insert into junior (eid) values (24);
insert into junior (eid) values (25);
insert into junior (eid) values (26);
insert into junior (eid) values (27);
insert into junior (eid) values (28);
insert into junior (eid) values (29);
insert into junior (eid) values (30);
insert into junior (eid) values (51);
insert into junior (eid) values (52);
insert into junior (eid) values (53);
insert into junior (eid) values (54);
insert into junior (eid) values (55);
insert into junior (eid) values (56);
insert into junior (eid) values (57);
insert into junior (eid) values (58);
insert into junior (eid) values (59);
insert into junior (eid) values (60);

-- meeting_rooms
insert into meeting_rooms (building_floor, room, rname, did, updated_new_cap, updated_date) values (1, 1, 'ornare', 0, 10, null);
insert into meeting_rooms (building_floor, room, rname, did, updated_new_cap, updated_date) values (1, 2, 'vestibulum', 1, 8, '28/10/2021');
insert into meeting_rooms (building_floor, room, rname, did, updated_new_cap, updated_date) values (1, 3, 'donec ut', 2, 8, null);
insert into meeting_rooms (building_floor, room, rname, did, updated_new_cap, updated_date) values (1, 4, 'platea', 3, 2, '1/11/2021');
insert into meeting_rooms (building_floor, room, rname, did, updated_new_cap, updated_date) values (2, 1, 'ultrices posuere', 4, 50, null);
insert into meeting_rooms (building_floor, room, rname, did, updated_new_cap, updated_date) values (2, 2, 'magna at nunc', 5, 2, null);
insert into meeting_rooms (building_floor, room, rname, did, updated_new_cap, updated_date) values (2, 3, 'curabitur', 6, 5, null);
insert into meeting_rooms (building_floor, room, rname, did, updated_new_cap, updated_date) values (2, 4, 'ante nulla justo', 7, 50, '31/10/2021');
insert into meeting_rooms (building_floor, room, rname, did, updated_new_cap, updated_date) values (3, 1, 'sit amet diam', 8, 2, null);
insert into meeting_rooms (building_floor, room, rname, did, updated_new_cap, updated_date) values (3, 2, 'ac diam', 9, 5, '28/10/2021');
insert into meeting_rooms (building_floor, room, rname, did, updated_new_cap, updated_date) values (3, 3, 'sociis natoque', 0, 5, '31/10/2021');
insert into meeting_rooms (building_floor, room, rname, did, updated_new_cap, updated_date) values (3, 4, 'ullamcorper purus sit', 1, 50, null);

-- meeting sessions
-- past meeting sessions
insert into meeting_sessions (building_floor, room, session_date, session_time, booker_id, endorser_id) values (2, 3, '1/11/2021'::DATE, '11:00'::TIME, 10, 7); -- 5
insert into meeting_sessions (building_floor, room, session_date, session_time, booker_id, endorser_id) values (2, 1, '3/11/2021'::DATE, '11:00'::TIME, 3, 5); -- 50
insert into meeting_sessions (building_floor, room, session_date, session_time, booker_id, endorser_id) values (3, 1, '2/11/2021'::DATE, '10:00'::TIME, 2, 39); -- 2
insert into meeting_sessions (building_floor, room, session_date, session_time, booker_id, endorser_id) values (3, 3, '3/11/2021'::DATE, '17:00'::TIME, 16, 1); -- 5
insert into meeting_sessions (building_floor, room, session_date, session_time, booker_id, endorser_id) values (1, 3, '7/11/2021'::DATE, '15:00'::TIME, 46, 3); -- 8
insert into meeting_sessions (building_floor, room, session_date, session_time, booker_id, endorser_id) values (3, 3, '4/11/2021'::DATE, '17:00'::TIME, 39, 31); -- 5
insert into meeting_sessions (building_floor, room, session_date, session_time, booker_id, endorser_id) values (2, 1, '3/11/2021'::DATE, '12:00'::TIME, 39, 35); -- 50
insert into meeting_sessions (building_floor, room, session_date, session_time, booker_id, endorser_id) values (2, 1, '8/11/2021'::DATE, '9:00'::TIME, 14, 5); -- 50
insert into meeting_sessions (building_floor, room, session_date, session_time, booker_id, endorser_id) values (2, 1, '2/11/2021'::DATE, '17:00'::TIME, 41, 35); -- 50
insert into meeting_sessions (building_floor, room, session_date, session_time, booker_id, endorser_id) values (3, 1, '4/11/2021'::DATE, '18:00'::TIME, 5, 9); -- 2
-- future meeting sessions
insert into meeting_sessions (building_floor, room, session_date, session_time, booker_id, endorser_id) values (1, 1, '15/11/2021'::DATE, '15:00'::TIME, 46, null); -- 10
insert into meeting_sessions (building_floor, room, session_date, session_time, booker_id, endorser_id) values (1, 1, '19/11/2021'::DATE, '13:00'::TIME, 12, 31); -- 10
insert into meeting_sessions (building_floor, room, session_date, session_time, booker_id, endorser_id) values (2, 3, '17/11/2021'::DATE, '12:00'::TIME, 6, 7); -- 5
insert into meeting_sessions (building_floor, room, session_date, session_time, booker_id, endorser_id) values (3, 1, '23/11/2021'::DATE, '12:00'::TIME, 10, null); -- 2
insert into meeting_sessions (building_floor, room, session_date, session_time, booker_id, endorser_id) values (3, 4, '13/11/2021'::DATE, '14:00'::TIME, 7, 32); -- 50
insert into meeting_sessions (building_floor, room, session_date, session_time, booker_id, endorser_id) values (3, 4, '12/11/2021'::DATE, '16:00'::TIME, 14, null); -- 50
insert into meeting_sessions (building_floor, room, session_date, session_time, booker_id, endorser_id) values (3, 4, '17/11/2021'::DATE, '16:00'::TIME, 2, 2); -- 50
insert into meeting_sessions (building_floor, room, session_date, session_time, booker_id, endorser_id) values (1, 1, '16/11/2021'::DATE, '12:00'::TIME, 45, null); -- 10
insert into meeting_sessions (building_floor, room, session_date, session_time, booker_id, endorser_id) values (2, 4, '11/11/2021'::DATE, '12:00'::TIME, 17, null); -- 50
insert into meeting_sessions (building_floor, room, session_date, session_time, booker_id, endorser_id) values (3, 1, '13/11/2021'::DATE, '8:00'::TIME, 12, 39); -- 2

-- joins
-- past joins
insert into joins (eid, building_floor, room, session_date, session_time) values (10, 2, 3, '1/11/2021'::DATE, '11:00'::TIME);
insert into joins (eid, building_floor, room, session_date, session_time) values (29, 2, 3, '1/11/2021'::DATE, '11:00'::TIME);
insert into joins (eid, building_floor, room, session_date, session_time) values (22, 2, 3, '1/11/2021'::DATE, '11:00'::TIME);
insert into joins (eid, building_floor, room, session_date, session_time) values (38, 2, 3, '1/11/2021'::DATE, '11:00'::TIME);

insert into joins (eid, building_floor, room, session_date, session_time) values (3, 2, 1, '3/11/2021'::DATE, '11:00'::TIME);
insert into joins (eid, building_floor, room, session_date, session_time) values (4, 2, 1, '3/11/2021'::DATE, '11:00'::TIME);
insert into joins (eid, building_floor, room, session_date, session_time) values (49, 2, 1, '3/11/2021'::DATE, '11:00'::TIME);

insert into joins (eid, building_floor, room, session_date, session_time) values (2, 3, 1, '2/11/2021'::DATE, '10:00'::TIME);
insert into joins (eid, building_floor, room, session_date, session_time) values (32, 3, 1, '2/11/2021'::DATE, '10:00'::TIME);

insert into joins (eid, building_floor, room, session_date, session_time) values (16, 3, 3, '3/11/2021'::DATE, '17:00'::TIME);
insert into joins (eid, building_floor, room, session_date, session_time) values (60, 3, 3, '3/11/2021'::DATE, '17:00'::TIME);
insert into joins (eid, building_floor, room, session_date, session_time) values (40, 3, 3, '3/11/2021'::DATE, '17:00'::TIME);
insert into joins (eid, building_floor, room, session_date, session_time) values (51, 3, 3, '3/11/2021'::DATE, '17:00'::TIME);
insert into joins (eid, building_floor, room, session_date, session_time) values (26, 3, 3, '3/11/2021'::DATE, '17:00'::TIME);

insert into joins (eid, building_floor, room, session_date, session_time) values (46, 1, 3, '7/11/2021'::DATE, '15:00'::TIME);
insert into joins (eid, building_floor, room, session_date, session_time) values (53, 1, 3, '7/11/2021'::DATE, '15:00'::TIME);
insert into joins (eid, building_floor, room, session_date, session_time) values (54, 1, 3, '7/11/2021'::DATE, '15:00'::TIME);
insert into joins (eid, building_floor, room, session_date, session_time) values (6, 1, 3, '7/11/2021'::DATE, '15:00'::TIME);
insert into joins (eid, building_floor, room, session_date, session_time) values (16, 1, 3, '7/11/2021'::DATE, '15:00'::TIME);
insert into joins (eid, building_floor, room, session_date, session_time) values (58, 1, 3, '7/11/2021'::DATE, '15:00'::TIME);

insert into joins (eid, building_floor, room, session_date, session_time) values (39, 3, 3, '4/11/2021'::DATE, '17:00'::TIME);
insert into joins (eid, building_floor, room, session_date, session_time) values (2, 3, 3, '4/11/2021'::DATE, '17:00'::TIME);
insert into joins (eid, building_floor, room, session_date, session_time) values (36, 3, 3, '4/11/2021'::DATE, '17:00'::TIME);
insert into joins (eid, building_floor, room, session_date, session_time) values (55, 3, 3, '4/11/2021'::DATE, '17:00'::TIME);

insert into joins (eid, building_floor, room, session_date, session_time) values (39, 2, 1, '3/11/2021'::DATE, '12:00'::TIME);
insert into joins (eid, building_floor, room, session_date, session_time) values (18, 2, 1, '3/11/2021'::DATE, '12:00'::TIME);
insert into joins (eid, building_floor, room, session_date, session_time) values (49, 2, 1, '3/11/2021'::DATE, '12:00'::TIME);

insert into joins (eid, building_floor, room, session_date, session_time) values (14, 2, 1, '8/11/2021'::DATE, '9:00'::TIME);
insert into joins (eid, building_floor, room, session_date, session_time) values (20, 2, 1, '8/11/2021'::DATE, '9:00'::TIME);
insert into joins (eid, building_floor, room, session_date, session_time) values (39, 2, 1, '8/11/2021'::DATE, '9:00'::TIME);
insert into joins (eid, building_floor, room, session_date, session_time) values (43, 2, 1, '8/11/2021'::DATE, '9:00'::TIME);
insert into joins (eid, building_floor, room, session_date, session_time) values (3, 2, 1, '8/11/2021'::DATE, '9:00'::TIME);

insert into joins (eid, building_floor, room, session_date, session_time) values (41, 2, 1, '2/11/2021'::DATE, '17:00'::TIME);
insert into joins (eid, building_floor, room, session_date, session_time) values (10, 2, 1, '2/11/2021'::DATE, '17:00'::TIME);
insert into joins (eid, building_floor, room, session_date, session_time) values (32, 2, 1, '2/11/2021'::DATE, '17:00'::TIME);
insert into joins (eid, building_floor, room, session_date, session_time) values (16, 2, 1, '2/11/2021'::DATE, '17:00'::TIME);
insert into joins (eid, building_floor, room, session_date, session_time) values (49, 2, 1, '2/11/2021'::DATE, '17:00'::TIME);
insert into joins (eid, building_floor, room, session_date, session_time) values (36, 2, 1, '2/11/2021'::DATE, '17:00'::TIME);

insert into joins (eid, building_floor, room, session_date, session_time) values (5, 3, 1, '4/11/2021'::DATE, '18:00'::TIME);
insert into joins (eid, building_floor, room, session_date, session_time) values (46, 3, 1, '4/11/2021'::DATE, '18:00'::TIME);

-- future joins
insert into joins (eid, building_floor, room, session_date, session_time) values (46, 1, 1, '15/11/2021'::DATE, '15:00'::TIME);
insert into joins (eid, building_floor, room, session_date, session_time) values (3, 1, 1, '15/11/2021'::DATE, '15:00'::TIME);

insert into joins (eid, building_floor, room, session_date, session_time) values (12, 2, 3, '17/11/2021'::DATE, '12:00'::TIME);

insert into joins (eid, building_floor, room, session_date, session_time) values (6, 3, 1, '28/10/2021'::DATE, '10:00'::TIME);

insert into joins (eid, building_floor, room, session_date, session_time) values (10, 3, 1, '23/11/2021'::DATE, '12:00'::TIME);
insert into joins (eid, building_floor, room, session_date, session_time) values (39, 3, 1, '23/11/2021'::DATE, '12:00'::TIME);

insert into joins (eid, building_floor, room, session_date, session_time) values (7, 3, 4, '13/11/2021'::DATE, '14:00'::TIME);
insert into joins (eid, building_floor, room, session_date, session_time) values (52, 3, 4, '13/11/2021'::DATE, '14:00'::TIME);
insert into joins (eid, building_floor, room, session_date, session_time) values (29, 3, 4, '13/11/2021'::DATE, '14:00'::TIME);
insert into joins (eid, building_floor, room, session_date, session_time) values (3, 3, 4, '13/11/2021'::DATE, '14:00'::TIME);
insert into joins (eid, building_floor, room, session_date, session_time) values (4, 3, 4, '13/11/2021'::DATE, '14:00'::TIME);
insert into joins (eid, building_floor, room, session_date, session_time) values (59, 3, 4, '13/11/2021'::DATE, '14:00'::TIME);

insert into joins (eid, building_floor, room, session_date, session_time) values (14, 3, 4, '12/11/2021'::DATE, '16:00'::TIME);

insert into joins (eid, building_floor, room, session_date, session_time) values (2, 3, 4, '17/11/2021'::DATE, '16:00'::TIME);

insert into joins (eid, building_floor, room, session_date, session_time) values (45, 1, 1, '16/11/2021'::DATE, '12:00'::TIME);

insert into joins (eid, building_floor, room, session_date, session_time) values (17, 2, 4, '11/11/2021'::DATE, '12:00'::TIME);
insert into joins (eid, building_floor, room, session_date, session_time) values (40, 2, 4, '11/11/2021'::DATE, '12:00'::TIME);

insert into joins (eid, building_floor, room, session_date, session_time) values (12, 3, 1, '13/11/2021'::DATE, '8:00'::TIME);

-- health declarations
insert into health_declaration (eid, declaration_date, temperature) values (1, '6/11/2021'::DATE, 37.1);
insert into health_declaration (eid, declaration_date, temperature) values (1, '7/11/2021'::DATE, 37.1);
insert into health_declaration (eid, declaration_date, temperature) values (1, '8/11/2021'::DATE, 37.2);
insert into health_declaration (eid, declaration_date, temperature) values (2, '6/11/2021'::DATE, 36.3);
insert into health_declaration (eid, declaration_date, temperature) values (2, '7/11/2021'::DATE, 36.8);
insert into health_declaration (eid, declaration_date, temperature) values (2, '8/11/2021'::DATE, 37.1);
insert into health_declaration (eid, declaration_date, temperature) values (3, '6/11/2021'::DATE, 37.3);
insert into health_declaration (eid, declaration_date, temperature) values (3, '7/11/2021'::DATE, 36.9);
insert into health_declaration (eid, declaration_date, temperature) values (3, '8/11/2021'::DATE, 37.2);
insert into health_declaration (eid, declaration_date, temperature) values (4, '6/11/2021'::DATE, 36.5);
insert into health_declaration (eid, declaration_date, temperature) values (4, '7/11/2021'::DATE, 36.7);
insert into health_declaration (eid, declaration_date, temperature) values (4, '8/11/2021'::DATE, 37.1);
insert into health_declaration (eid, declaration_date, temperature) values (5, '6/11/2021'::DATE, 35.5);
insert into health_declaration (eid, declaration_date, temperature) values (5, '7/11/2021'::DATE, 36.9);
insert into health_declaration (eid, declaration_date, temperature) values (5, '8/11/2021'::DATE, 36.5);
insert into health_declaration (eid, declaration_date, temperature) values (6, '6/11/2021'::DATE, 37.2);
insert into health_declaration (eid, declaration_date, temperature) values (6, '7/11/2021'::DATE, 36.5);
insert into health_declaration (eid, declaration_date, temperature) values (6, '8/11/2021'::DATE, 36.7);
insert into health_declaration (eid, declaration_date, temperature) values (7, '6/11/2021'::DATE, 36.3);
insert into health_declaration (eid, declaration_date, temperature) values (7, '7/11/2021'::DATE, 36.9);
insert into health_declaration (eid, declaration_date, temperature) values (7, '8/11/2021'::DATE, 37.1);
insert into health_declaration (eid, declaration_date, temperature) values (8, '6/11/2021'::DATE, 37.2);
insert into health_declaration (eid, declaration_date, temperature) values (8, '7/11/2021'::DATE, 36.2);
insert into health_declaration (eid, declaration_date, temperature) values (8, '8/11/2021'::DATE, 37.0);
-- insert into health_declaration (eid, declaration_date, temperature) values (9, '6/11/2021'::DATE, 36.7); -- 9 resigned on 3/11/2021
-- insert into health_declaration (eid, declaration_date, temperature) values (9, '7/11/2021'::DATE, 37.0);
-- insert into health_declaration (eid, declaration_date, temperature) values (9, '8/11/2021'::DATE, 36.6);
insert into health_declaration (eid, declaration_date, temperature) values (10, '6/11/2021'::DATE, 36.5);
insert into health_declaration (eid, declaration_date, temperature) values (10, '7/11/2021'::DATE, 36.2);
insert into health_declaration (eid, declaration_date, temperature) values (10, '8/11/2021'::DATE, 37.4);
insert into health_declaration (eid, declaration_date, temperature) values (11, '6/11/2021'::DATE, 36.4);
insert into health_declaration (eid, declaration_date, temperature) values (11, '7/11/2021'::DATE, 36.3);
insert into health_declaration (eid, declaration_date, temperature) values (11, '8/11/2021'::DATE, 36.5);
insert into health_declaration (eid, declaration_date, temperature) values (12, '6/11/2021'::DATE, 37.1);
insert into health_declaration (eid, declaration_date, temperature) values (12, '7/11/2021'::DATE, 36.4);
insert into health_declaration (eid, declaration_date, temperature) values (12, '8/11/2021'::DATE, 36.4);
-- 13 resigned
-- insert into health_declaration (eid, declaration_date, temperature) values (13, '6/11/2021'::DATE, 36.9); -- 13 resigned on 4/11/2021
-- insert into health_declaration (eid, declaration_date, temperature) values (13, '7/11/2021'::DATE, 36.6);
-- insert into health_declaration (eid, declaration_date, temperature) values (13, '8/11/2021'::DATE, 36.8);
insert into health_declaration (eid, declaration_date, temperature) values (14, '6/11/2021'::DATE, 36.4);
insert into health_declaration (eid, declaration_date, temperature) values (14, '7/11/2021'::DATE, 36.9);
insert into health_declaration (eid, declaration_date, temperature) values (14, '8/11/2021'::DATE, 36.6);
insert into health_declaration (eid, declaration_date, temperature) values (15, '6/11/2021'::DATE, 36.4);
insert into health_declaration (eid, declaration_date, temperature) values (15, '7/11/2021'::DATE, 37.6); -- fever
insert into health_declaration (eid, declaration_date, temperature) values (15, '8/11/2021'::DATE, 36.7);
insert into health_declaration (eid, declaration_date, temperature) values (16, '6/11/2021'::DATE, 36.7);
insert into health_declaration (eid, declaration_date, temperature) values (16, '7/11/2021'::DATE, 36.9);
insert into health_declaration (eid, declaration_date, temperature) values (16, '8/11/2021'::DATE, 37.0);
insert into health_declaration (eid, declaration_date, temperature) values (17, '6/11/2021'::DATE, 36.8);
insert into health_declaration (eid, declaration_date, temperature) values (17, '7/11/2021'::DATE, 37.6); -- fever
insert into health_declaration (eid, declaration_date, temperature) values (17, '8/11/2021'::DATE, 36.2);
insert into health_declaration (eid, declaration_date, temperature) values (18, '6/11/2021'::DATE, 36.8);
insert into health_declaration (eid, declaration_date, temperature) values (18, '7/11/2021'::DATE, 36.8);
insert into health_declaration (eid, declaration_date, temperature) values (18, '8/11/2021'::DATE, 36.7);
insert into health_declaration (eid, declaration_date, temperature) values (19, '6/11/2021'::DATE, 36.1);
insert into health_declaration (eid, declaration_date, temperature) values (19, '7/11/2021'::DATE, 36.1);
insert into health_declaration (eid, declaration_date, temperature) values (19, '8/11/2021'::DATE, 37.4);
insert into health_declaration (eid, declaration_date, temperature) values (20, '6/11/2021'::DATE, 36.1);
insert into health_declaration (eid, declaration_date, temperature) values (20, '7/11/2021'::DATE, 37.1);
insert into health_declaration (eid, declaration_date, temperature) values (20, '8/11/2021'::DATE, 36.6);
insert into health_declaration (eid, declaration_date, temperature) values (21, '6/11/2021'::DATE, 36.7);
insert into health_declaration (eid, declaration_date, temperature) values (21, '7/11/2021'::DATE, 36.2);
insert into health_declaration (eid, declaration_date, temperature) values (21, '8/11/2021'::DATE, 37.1);
insert into health_declaration (eid, declaration_date, temperature) values (22, '6/11/2021'::DATE, 37.1);
insert into health_declaration (eid, declaration_date, temperature) values (22, '7/11/2021'::DATE, 37.2);
insert into health_declaration (eid, declaration_date, temperature) values (22, '8/11/2021'::DATE, 36.7);
insert into health_declaration (eid, declaration_date, temperature) values (23, '6/11/2021'::DATE, 37.1);
insert into health_declaration (eid, declaration_date, temperature) values (23, '7/11/2021'::DATE, 35.7);
insert into health_declaration (eid, declaration_date, temperature) values (23, '8/11/2021'::DATE, 36.4);
insert into health_declaration (eid, declaration_date, temperature) values (24, '6/11/2021'::DATE, 36.9);
insert into health_declaration (eid, declaration_date, temperature) values (24, '7/11/2021'::DATE, 36.4);
insert into health_declaration (eid, declaration_date, temperature) values (24, '8/11/2021'::DATE, 36.5);
insert into health_declaration (eid, declaration_date, temperature) values (25, '6/11/2021'::DATE, 36.9);
insert into health_declaration (eid, declaration_date, temperature) values (25, '7/11/2021'::DATE, 37.1);
insert into health_declaration (eid, declaration_date, temperature) values (25, '8/11/2021'::DATE, 35.7);
insert into health_declaration (eid, declaration_date, temperature) values (26, '6/11/2021'::DATE, 37.3);
insert into health_declaration (eid, declaration_date, temperature) values (26, '7/11/2021'::DATE, 37.6); -- fever
insert into health_declaration (eid, declaration_date, temperature) values (26, '8/11/2021'::DATE, 36.6);
insert into health_declaration (eid, declaration_date, temperature) values (27, '6/11/2021'::DATE, 36.4);
insert into health_declaration (eid, declaration_date, temperature) values (27, '7/11/2021'::DATE, 36.4);
insert into health_declaration (eid, declaration_date, temperature) values (27, '8/11/2021'::DATE, 36.6);
insert into health_declaration (eid, declaration_date, temperature) values (28, '6/11/2021'::DATE, 36.7);
insert into health_declaration (eid, declaration_date, temperature) values (28, '7/11/2021'::DATE, 37.0);
insert into health_declaration (eid, declaration_date, temperature) values (28, '8/11/2021'::DATE, 36.5);
insert into health_declaration (eid, declaration_date, temperature) values (29, '6/11/2021'::DATE, 36.9);
insert into health_declaration (eid, declaration_date, temperature) values (29, '7/11/2021'::DATE, 36.1);
insert into health_declaration (eid, declaration_date, temperature) values (29, '8/11/2021'::DATE, 36.8);
insert into health_declaration (eid, declaration_date, temperature) values (30, '6/11/2021'::DATE, 36.0);
insert into health_declaration (eid, declaration_date, temperature) values (30, '7/11/2021'::DATE, 36.5);
insert into health_declaration (eid, declaration_date, temperature) values (30, '8/11/2021'::DATE, 37.5);
insert into health_declaration (eid, declaration_date, temperature) values (31, '6/11/2021'::DATE, 37.5);
insert into health_declaration (eid, declaration_date, temperature) values (31, '7/11/2021'::DATE, 36.9);
insert into health_declaration (eid, declaration_date, temperature) values (31, '8/11/2021'::DATE, 36.5);
insert into health_declaration (eid, declaration_date, temperature) values (32, '6/11/2021'::DATE, 35.9);
insert into health_declaration (eid, declaration_date, temperature) values (32, '7/11/2021'::DATE, 37.4);
insert into health_declaration (eid, declaration_date, temperature) values (32, '8/11/2021'::DATE, 36.7);
insert into health_declaration (eid, declaration_date, temperature) values (33, '6/11/2021'::DATE, 36.6);
insert into health_declaration (eid, declaration_date, temperature) values (33, '7/11/2021'::DATE, 36.8);
insert into health_declaration (eid, declaration_date, temperature) values (33, '8/11/2021'::DATE, 35.9);
insert into health_declaration (eid, declaration_date, temperature) values (34, '6/11/2021'::DATE, 37.4);
insert into health_declaration (eid, declaration_date, temperature) values (34, '7/11/2021'::DATE, 36.9);
insert into health_declaration (eid, declaration_date, temperature) values (34, '8/11/2021'::DATE, 36.1);
insert into health_declaration (eid, declaration_date, temperature) values (35, '6/11/2021'::DATE, 36.8);
insert into health_declaration (eid, declaration_date, temperature) values (35, '7/11/2021'::DATE, 37.0);
insert into health_declaration (eid, declaration_date, temperature) values (35, '8/11/2021'::DATE, 37.1);
insert into health_declaration (eid, declaration_date, temperature) values (36, '6/11/2021'::DATE, 36.8);
insert into health_declaration (eid, declaration_date, temperature) values (36, '7/11/2021'::DATE, 36.6);
insert into health_declaration (eid, declaration_date, temperature) values (36, '8/11/2021'::DATE, 37.0);
-- insert into health_declaration (eid, declaration_date, temperature) values (37, '6/11/2021'::DATE, 36.0); -- 37 resigned on 2/11/2021
-- insert into health_declaration (eid, declaration_date, temperature) values (37, '7/11/2021'::DATE, 36.9);
-- insert into health_declaration (eid, declaration_date, temperature) values (37, '8/11/2021'::DATE, 37.4);
insert into health_declaration (eid, declaration_date, temperature) values (38, '6/11/2021'::DATE, 37.3);
insert into health_declaration (eid, declaration_date, temperature) values (38, '7/11/2021'::DATE, 36.4);
insert into health_declaration (eid, declaration_date, temperature) values (38, '8/11/2021'::DATE, 37.1);
insert into health_declaration (eid, declaration_date, temperature) values (39, '6/11/2021'::DATE, 36.7);
insert into health_declaration (eid, declaration_date, temperature) values (39, '7/11/2021'::DATE, 36.6);
insert into health_declaration (eid, declaration_date, temperature) values (39, '8/11/2021'::DATE, 37.1);
insert into health_declaration (eid, declaration_date, temperature) values (40, '6/11/2021'::DATE, 36.4);
insert into health_declaration (eid, declaration_date, temperature) values (40, '7/11/2021'::DATE, 37.1);
insert into health_declaration (eid, declaration_date, temperature) values (40, '8/11/2021'::DATE, 36.8);
insert into health_declaration (eid, declaration_date, temperature) values (41, '6/11/2021'::DATE, 36.7);
insert into health_declaration (eid, declaration_date, temperature) values (41, '7/11/2021'::DATE, 36.9);
insert into health_declaration (eid, declaration_date, temperature) values (41, '8/11/2021'::DATE, 36.9);
insert into health_declaration (eid, declaration_date, temperature) values (42, '6/11/2021'::DATE, 37.4);
insert into health_declaration (eid, declaration_date, temperature) values (42, '7/11/2021'::DATE, 36.9);
insert into health_declaration (eid, declaration_date, temperature) values (42, '8/11/2021'::DATE, 36.7);
insert into health_declaration (eid, declaration_date, temperature) values (43, '6/11/2021'::DATE, 36.1);
insert into health_declaration (eid, declaration_date, temperature) values (43, '7/11/2021'::DATE, 36.8);
insert into health_declaration (eid, declaration_date, temperature) values (43, '8/11/2021'::DATE, 36.3);
insert into health_declaration (eid, declaration_date, temperature) values (44, '6/11/2021'::DATE, 36.8);
insert into health_declaration (eid, declaration_date, temperature) values (44, '7/11/2021'::DATE, 36.6);
-- insert into health_declaration (eid, declaration_date, temperature) values (44, '8/11/2021'::DATE, 37.1); -- 44 resigned on 8/11/2021
insert into health_declaration (eid, declaration_date, temperature) values (45, '6/11/2021'::DATE, 37.4);
insert into health_declaration (eid, declaration_date, temperature) values (45, '7/11/2021'::DATE, 36.7);
insert into health_declaration (eid, declaration_date, temperature) values (45, '8/11/2021'::DATE, 36.6);
insert into health_declaration (eid, declaration_date, temperature) values (46, '6/11/2021'::DATE, 36.8);
insert into health_declaration (eid, declaration_date, temperature) values (46, '7/11/2021'::DATE, 36.8);
insert into health_declaration (eid, declaration_date, temperature) values (46, '8/11/2021'::DATE, 36.8);
insert into health_declaration (eid, declaration_date, temperature) values (47, '6/11/2021'::DATE, 36.5);
insert into health_declaration (eid, declaration_date, temperature) values (47, '7/11/2021'::DATE, 36.6);
insert into health_declaration (eid, declaration_date, temperature) values (47, '8/11/2021'::DATE, 36.7);
insert into health_declaration (eid, declaration_date, temperature) values (48, '6/11/2021'::DATE, 36.5);
insert into health_declaration (eid, declaration_date, temperature) values (48, '7/11/2021'::DATE, 37.1);
insert into health_declaration (eid, declaration_date, temperature) values (48, '8/11/2021'::DATE, 36.8);
insert into health_declaration (eid, declaration_date, temperature) values (49, '6/11/2021'::DATE, 37.1);
insert into health_declaration (eid, declaration_date, temperature) values (49, '7/11/2021'::DATE, 36.6);
insert into health_declaration (eid, declaration_date, temperature) values (49, '8/11/2021'::DATE, 37.2);
insert into health_declaration (eid, declaration_date, temperature) values (50, '6/11/2021'::DATE, 37.7); -- fever
insert into health_declaration (eid, declaration_date, temperature) values (50, '7/11/2021'::DATE, 37.3);
insert into health_declaration (eid, declaration_date, temperature) values (50, '8/11/2021'::DATE, 37.1);
-- insert into health_declaration (eid, declaration_date, temperature) values (51, '6/11/2021'::DATE, 36.9); -- 51 resigned on 6/11/2021
-- insert into health_declaration (eid, declaration_date, temperature) values (51, '7/11/2021'::DATE, 36.9);
-- insert into health_declaration (eid, declaration_date, temperature) values (51, '8/11/2021'::DATE, 36.5);
insert into health_declaration (eid, declaration_date, temperature) values (52, '6/11/2021'::DATE, 36.5);
insert into health_declaration (eid, declaration_date, temperature) values (52, '7/11/2021'::DATE, 36.5);
insert into health_declaration (eid, declaration_date, temperature) values (52, '8/11/2021'::DATE, 37.0);
insert into health_declaration (eid, declaration_date, temperature) values (53, '6/11/2021'::DATE, 36.2);
insert into health_declaration (eid, declaration_date, temperature) values (53, '7/11/2021'::DATE, 37.0);
insert into health_declaration (eid, declaration_date, temperature) values (53, '8/11/2021'::DATE, 37.0);
insert into health_declaration (eid, declaration_date, temperature) values (54, '6/11/2021'::DATE, 36.9);
insert into health_declaration (eid, declaration_date, temperature) values (54, '7/11/2021'::DATE, 36.4);
insert into health_declaration (eid, declaration_date, temperature) values (54, '8/11/2021'::DATE, 37.1);
insert into health_declaration (eid, declaration_date, temperature) values (55, '6/11/2021'::DATE, 36.4);
insert into health_declaration (eid, declaration_date, temperature) values (55, '7/11/2021'::DATE, 36.9);
insert into health_declaration (eid, declaration_date, temperature) values (55, '8/11/2021'::DATE, 37.4);
insert into health_declaration (eid, declaration_date, temperature) values (56, '6/11/2021'::DATE, 36.7);
insert into health_declaration (eid, declaration_date, temperature) values (56, '7/11/2021'::DATE, 37.2);
insert into health_declaration (eid, declaration_date, temperature) values (56, '8/11/2021'::DATE, 36.9);
-- insert into health_declaration (eid, declaration_date, temperature) values (57, '6/11/2021'::DATE, 36.4); -- 57 resigned on 3/11/2021
-- insert into health_declaration (eid, declaration_date, temperature) values (57, '7/11/2021'::DATE, 35.9);
-- insert into health_declaration (eid, declaration_date, temperature) values (57, '8/11/2021'::DATE, 37.5);
insert into health_declaration (eid, declaration_date, temperature) values (58, '6/11/2021'::DATE, 36.9);
insert into health_declaration (eid, declaration_date, temperature) values (58, '7/11/2021'::DATE, 37.3);
insert into health_declaration (eid, declaration_date, temperature) values (58, '8/11/2021'::DATE, 36.9);
insert into health_declaration (eid, declaration_date, temperature) values (59, '6/11/2021'::DATE, 37.1);
insert into health_declaration (eid, declaration_date, temperature) values (59, '7/11/2021'::DATE, 36.7);
insert into health_declaration (eid, declaration_date, temperature) values (59, '8/11/2021'::DATE, 37.3);
-- insert into health_declaration (eid, declaration_date, temperature) values (60, '6/11/2021'::DATE, 36.4); -- 60 resigned on 2/11/2021
-- insert into health_declaration (eid, declaration_date, temperature) values (60, '7/11/2021'::DATE, 36.9);
-- insert into health_declaration (eid, declaration_date, temperature) values (60, '8/11/2021'::DATE, 37.8); -- fever
