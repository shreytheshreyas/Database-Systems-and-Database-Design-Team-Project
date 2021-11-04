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
INSERT INTO manager (eid) VALUES (1);
INSERT INTO manager (eid) VALUES (2);
INSERT INTO manager (eid) VALUES (3);
INSERT INTO manager (eid) VALUES (4);
INSERT INTO manager (eid) VALUES (5);
INSERT INTO manager (eid) VALUES (6);
INSERT INTO manager (eid) VALUES (7);
INSERT INTO manager (eid) VALUES (8);
INSERT INTO manager (eid) VALUES (9);
INSERT INTO manager (eid) VALUES (10);
INSERT INTO manager (eid) VALUES (31);
INSERT INTO manager (eid) VALUES (32);
INSERT INTO manager (eid) VALUES (33);
INSERT INTO manager (eid) VALUES (34);
INSERT INTO manager (eid) VALUES (35);
INSERT INTO manager (eid) VALUES (36);
INSERT INTO manager (eid) VALUES (37);
INSERT INTO manager (eid) VALUES (38);
INSERT INTO manager (eid) VALUES (39);
INSERT INTO manager (eid) VALUES (40);

-- senior
INSERT INTO senior (eid) VALUES (11);
INSERT INTO senior (eid) VALUES (12);
INSERT INTO senior (eid) VALUES (13);
INSERT INTO senior (eid) VALUES (14);
INSERT INTO senior (eid) VALUES (15);
INSERT INTO senior (eid) VALUES (16);
INSERT INTO senior (eid) VALUES (17);
INSERT INTO senior (eid) VALUES (18);
INSERT INTO senior (eid) VALUES (19);
INSERT INTO senior (eid) VALUES (20);
INSERT INTO senior (eid) VALUES (41);
INSERT INTO senior (eid) VALUES (42);
INSERT INTO senior (eid) VALUES (43);
INSERT INTO senior (eid) VALUES (44);
INSERT INTO senior (eid) VALUES (45);
INSERT INTO senior (eid) VALUES (46);
INSERT INTO senior (eid) VALUES (47);
INSERT INTO senior (eid) VALUES (48);
INSERT INTO senior (eid) VALUES (49);
INSERT INTO senior (eid) VALUES (50);

-- junior
INSERT INTO junior (eid) VALUES (21);
INSERT INTO junior (eid) VALUES (22);
INSERT INTO junior (eid) VALUES (23);
INSERT INTO junior (eid) VALUES (24);
INSERT INTO junior (eid) VALUES (25);
INSERT INTO junior (eid) VALUES (26);
INSERT INTO junior (eid) VALUES (27);
INSERT INTO junior (eid) VALUES (28);
INSERT INTO junior (eid) VALUES (29);
INSERT INTO junior (eid) VALUES (30);
INSERT INTO junior (eid) VALUES (51);
INSERT INTO junior (eid) VALUES (52);
INSERT INTO junior (eid) VALUES (53);
INSERT INTO junior (eid) VALUES (54);
INSERT INTO junior (eid) VALUES (55);
INSERT INTO junior (eid) VALUES (56);
INSERT INTO junior (eid) VALUES (57);
INSERT INTO junior (eid) VALUES (58);
INSERT INTO junior (eid) VALUES (59);
INSERT INTO junior (eid) VALUES (60);

-- meeting_rooms
INSERT INTO meeting_rooms (building_floor, room, rname, did, updated_new_cap, updated_date) VALUES (1, 1, 'ornare', 0, 10, null);
INSERT INTO meeting_rooms (building_floor, room, rname, did, updated_new_cap, updated_date) VALUES (1, 2, 'vestibulum', 1, 8, '28/10/2021');
INSERT INTO meeting_rooms (building_floor, room, rname, did, updated_new_cap, updated_date) VALUES (1, 3, 'donec ut', 2, 8, null);
INSERT INTO meeting_rooms (building_floor, room, rname, did, updated_new_cap, updated_date) VALUES (1, 4, 'platea', 3, 2, '1/11/2021');
INSERT INTO meeting_rooms (building_floor, room, rname, did, updated_new_cap, updated_date) VALUES (2, 1, 'ultrices posuere', 4, 50, null);
INSERT INTO meeting_rooms (building_floor, room, rname, did, updated_new_cap, updated_date) VALUES (2, 2, 'magna at nunc', 5, 2, null);
INSERT INTO meeting_rooms (building_floor, room, rname, did, updated_new_cap, updated_date) VALUES (2, 3, 'curabitur', 6, 5, null);
INSERT INTO meeting_rooms (building_floor, room, rname, did, updated_new_cap, updated_date) VALUES (2, 4, 'ante nulla justo', 7, 50, '31/10/2021');
INSERT INTO meeting_rooms (building_floor, room, rname, did, updated_new_cap, updated_date) VALUES (3, 1, 'sit amet diam', 8, 2, null);
INSERT INTO meeting_rooms (building_floor, room, rname, did, updated_new_cap, updated_date) VALUES (3, 2, 'ac diam', 9, 5, '28/10/2021');
INSERT INTO meeting_rooms (building_floor, room, rname, did, updated_new_cap, updated_date) VALUES (3, 3, 'sociis natoque', 0, 5, '31/10/2021');
INSERT INTO meeting_rooms (building_floor, room, rname, did, updated_new_cap, updated_date) VALUES (3, 4, 'ullamcorper purus sit', 1, 50, null);

-- meeting sessions
-- past meeting sessions
INSERT INTO meeting_sessions (building_floor, room, session_date, session_time, booker_id, endorser_id) VALUES (2, 3, '1/11/2021'::DATE, '11:00'::TIME, 10, 7); -- 5
INSERT INTO meeting_sessions (building_floor, room, session_date, session_time, booker_id, endorser_id) VALUES (2, 1, '3/11/2021'::DATE, '11:00'::TIME, 3, 5); -- 50
INSERT INTO meeting_sessions (building_floor, room, session_date, session_time, booker_id, endorser_id) VALUES (3, 1, '2/11/2021'::DATE, '10:00'::TIME, 2, 39); -- 2
INSERT INTO meeting_sessions (building_floor, room, session_date, session_time, booker_id, endorser_id) VALUES (3, 3, '3/11/2021'::DATE, '17:00'::TIME, 16, 1); -- 5
INSERT INTO meeting_sessions (building_floor, room, session_date, session_time, booker_id, endorser_id) VALUES (1, 3, '7/11/2021'::DATE, '15:00'::TIME, 46, 3); -- 8
INSERT INTO meeting_sessions (building_floor, room, session_date, session_time, booker_id, endorser_id) VALUES (3, 3, '4/11/2021'::DATE, '17:00'::TIME, 39, 31); -- 5
INSERT INTO meeting_sessions (building_floor, room, session_date, session_time, booker_id, endorser_id) VALUES (2, 1, '3/11/2021'::DATE, '12:00'::TIME, 39, 35); -- 50
INSERT INTO meeting_sessions (building_floor, room, session_date, session_time, booker_id, endorser_id) VALUES (2, 1, '8/11/2021'::DATE, '9:00'::TIME, 14, 5); -- 50
INSERT INTO meeting_sessions (building_floor, room, session_date, session_time, booker_id, endorser_id) VALUES (2, 1, '2/11/2021'::DATE, '17:00'::TIME, 41, 35); -- 50
INSERT INTO meeting_sessions (building_floor, room, session_date, session_time, booker_id, endorser_id) VALUES (3, 1, '4/11/2021'::DATE, '18:00'::TIME, 5, 9); -- 2
-- future meeting sessions
INSERT INTO meeting_sessions (building_floor, room, session_date, session_time, booker_id, endorser_id) VALUES (1, 1, '15/11/2021'::DATE, '15:00'::TIME, 46, null); -- 10
INSERT INTO meeting_sessions (building_floor, room, session_date, session_time, booker_id, endorser_id) VALUES (1, 1, '19/11/2021'::DATE, '13:00'::TIME, 12, 31); -- 10
INSERT INTO meeting_sessions (building_floor, room, session_date, session_time, booker_id, endorser_id) VALUES (2, 3, '17/11/2021'::DATE, '12:00'::TIME, 6, 7); -- 5
INSERT INTO meeting_sessions (building_floor, room, session_date, session_time, booker_id, endorser_id) VALUES (3, 1, '23/11/2021'::DATE, '12:00'::TIME, 10, null); -- 2
INSERT INTO meeting_sessions (building_floor, room, session_date, session_time, booker_id, endorser_id) VALUES (3, 4, '13/11/2021'::DATE, '14:00'::TIME, 7, 32); -- 50
INSERT INTO meeting_sessions (building_floor, room, session_date, session_time, booker_id, endorser_id) VALUES (3, 4, '12/11/2021'::DATE, '16:00'::TIME, 14, null); -- 50
INSERT INTO meeting_sessions (building_floor, room, session_date, session_time, booker_id, endorser_id) VALUES (3, 4, '17/11/2021'::DATE, '16:00'::TIME, 2, 2); -- 50
INSERT INTO meeting_sessions (building_floor, room, session_date, session_time, booker_id, endorser_id) VALUES (1, 1, '16/11/2021'::DATE, '12:00'::TIME, 45, null); -- 10
INSERT INTO meeting_sessions (building_floor, room, session_date, session_time, booker_id, endorser_id) VALUES (2, 4, '11/11/2021'::DATE, '12:00'::TIME, 17, null); -- 50
INSERT INTO meeting_sessions (building_floor, room, session_date, session_time, booker_id, endorser_id) VALUES (3, 1, '13/11/2021'::DATE, '8:00'::TIME, 12, 39); -- 2

-- joins
-- past joins
INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (10, 2, 3, '1/11/2021'::DATE, '11:00'::TIME);
INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (29, 2, 3, '1/11/2021'::DATE, '11:00'::TIME);
INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (22, 2, 3, '1/11/2021'::DATE, '11:00'::TIME);
INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (38, 2, 3, '1/11/2021'::DATE, '11:00'::TIME);

INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (3, 2, 1, '3/11/2021'::DATE, '11:00'::TIME);
INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (4, 2, 1, '3/11/2021'::DATE, '11:00'::TIME);
INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (49, 2, 1, '3/11/2021'::DATE, '11:00'::TIME);

INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (2, 3, 1, '2/11/2021'::DATE, '10:00'::TIME);
INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (32, 3, 1, '2/11/2021'::DATE, '10:00'::TIME);

INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (16, 3, 3, '3/11/2021'::DATE, '17:00'::TIME);
INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (60, 3, 3, '3/11/2021'::DATE, '17:00'::TIME);
INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (40, 3, 3, '3/11/2021'::DATE, '17:00'::TIME);
INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (51, 3, 3, '3/11/2021'::DATE, '17:00'::TIME);
INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (26, 3, 3, '3/11/2021'::DATE, '17:00'::TIME);

INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (46, 1, 3, '7/11/2021'::DATE, '15:00'::TIME);
INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (53, 1, 3, '7/11/2021'::DATE, '15:00'::TIME);
INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (54, 1, 3, '7/11/2021'::DATE, '15:00'::TIME);
INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (6, 1, 3, '7/11/2021'::DATE, '15:00'::TIME);
INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (16, 1, 3, '7/11/2021'::DATE, '15:00'::TIME);
INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (58, 1, 3, '7/11/2021'::DATE, '15:00'::TIME);

INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (39, 3, 3, '4/11/2021'::DATE, '17:00'::TIME);
INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (2, 3, 3, '4/11/2021'::DATE, '17:00'::TIME);
INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (36, 3, 3, '4/11/2021'::DATE, '17:00'::TIME);
INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (55, 3, 3, '4/11/2021'::DATE, '17:00'::TIME);

INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (39, 2, 1, '3/11/2021'::DATE, '12:00'::TIME);
INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (18, 2, 1, '3/11/2021'::DATE, '12:00'::TIME);
INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (49, 2, 1, '3/11/2021'::DATE, '12:00'::TIME);

INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (14, 2, 1, '8/11/2021'::DATE, '9:00'::TIME);
INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (20, 2, 1, '8/11/2021'::DATE, '9:00'::TIME);
INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (39, 2, 1, '8/11/2021'::DATE, '9:00'::TIME);
INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (43, 2, 1, '8/11/2021'::DATE, '9:00'::TIME);
INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (3, 2, 1, '8/11/2021'::DATE, '9:00'::TIME);

INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (41, 2, 1, '2/11/2021'::DATE, '17:00'::TIME);
INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (10, 2, 1, '2/11/2021'::DATE, '17:00'::TIME);
INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (32, 2, 1, '2/11/2021'::DATE, '17:00'::TIME);
INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (16, 2, 1, '2/11/2021'::DATE, '17:00'::TIME);
INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (49, 2, 1, '2/11/2021'::DATE, '17:00'::TIME);
INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (36, 2, 1, '2/11/2021'::DATE, '17:00'::TIME);

INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (5, 3, 1, '4/11/2021'::DATE, '18:00'::TIME);
INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (46, 3, 1, '4/11/2021'::DATE, '18:00'::TIME);

-- future joins
INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (46, 1, 1, '15/11/2021'::DATE, '15:00'::TIME);
INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (3, 1, 1, '15/11/2021'::DATE, '15:00'::TIME);

INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (12, 2, 3, '17/11/2021'::DATE, '12:00'::TIME);

INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (6, 3, 1, '28/10/2021'::DATE, '10:00'::TIME);

INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (10, 3, 1, '23/11/2021'::DATE, '12:00'::TIME);
INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (39, 3, 1, '23/11/2021'::DATE, '12:00'::TIME);

INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (7, 3, 4, '13/11/2021'::DATE, '14:00'::TIME);
INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (52, 3, 4, '13/11/2021'::DATE, '14:00'::TIME);
INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (29, 3, 4, '13/11/2021'::DATE, '14:00'::TIME);
INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (3, 3, 4, '13/11/2021'::DATE, '14:00'::TIME);
INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (4, 3, 4, '13/11/2021'::DATE, '14:00'::TIME);
INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (59, 3, 4, '13/11/2021'::DATE, '14:00'::TIME);

INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (14, 3, 4, '12/11/2021'::DATE, '16:00'::TIME);

INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (2, 3, 4, '17/11/2021'::DATE, '16:00'::TIME);

INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (45, 1, 1, '16/11/2021'::DATE, '12:00'::TIME);

INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (17, 2, 4, '11/11/2021'::DATE, '12:00'::TIME);
INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (40, 2, 4, '11/11/2021'::DATE, '12:00'::TIME);

INSERT INTO joins (eid, building_floor, room, session_date, session_time) VALUES (12, 3, 1, '13/11/2021'::DATE, '8:00'::TIME);

-- health declarations
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (1, '6/11/2021'::DATE, 37.1);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (1, '7/11/2021'::DATE, 37.1);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (1, '8/11/2021'::DATE, 37.2);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (2, '6/11/2021'::DATE, 36.3);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (2, '7/11/2021'::DATE, 36.8);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (2, '8/11/2021'::DATE, 37.1);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (3, '6/11/2021'::DATE, 37.3);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (3, '7/11/2021'::DATE, 36.9);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (3, '8/11/2021'::DATE, 37.2);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (4, '6/11/2021'::DATE, 36.5);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (4, '7/11/2021'::DATE, 36.7);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (4, '8/11/2021'::DATE, 37.1);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (5, '6/11/2021'::DATE, 35.5);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (5, '7/11/2021'::DATE, 36.9);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (5, '8/11/2021'::DATE, 36.5);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (6, '6/11/2021'::DATE, 37.2);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (6, '7/11/2021'::DATE, 36.5);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (6, '8/11/2021'::DATE, 36.7);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (7, '6/11/2021'::DATE, 36.3);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (7, '7/11/2021'::DATE, 36.9);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (7, '8/11/2021'::DATE, 37.1);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (8, '6/11/2021'::DATE, 37.2);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (8, '7/11/2021'::DATE, 36.2);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (8, '8/11/2021'::DATE, 37.0);
-- INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (9, '6/11/2021'::DATE, 36.7); -- 9 resigned on 3/11/2021
-- INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (9, '7/11/2021'::DATE, 37.0);
-- INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (9, '8/11/2021'::DATE, 36.6);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (10, '6/11/2021'::DATE, 36.5);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (10, '7/11/2021'::DATE, 36.2);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (10, '8/11/2021'::DATE, 37.4);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (11, '6/11/2021'::DATE, 36.4);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (11, '7/11/2021'::DATE, 36.3);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (11, '8/11/2021'::DATE, 36.5);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (12, '6/11/2021'::DATE, 37.1);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (12, '7/11/2021'::DATE, 36.4);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (12, '8/11/2021'::DATE, 36.4);
-- INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (13, '6/11/2021'::DATE, 36.9); -- 13 resigned on 4/11/2021
-- INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (13, '7/11/2021'::DATE, 36.6);
-- INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (13, '8/11/2021'::DATE, 36.8);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (14, '6/11/2021'::DATE, 36.4);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (14, '7/11/2021'::DATE, 36.9);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (14, '8/11/2021'::DATE, 36.6);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (15, '6/11/2021'::DATE, 36.4);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (15, '7/11/2021'::DATE, 37.6); -- fever
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (15, '8/11/2021'::DATE, 36.7);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (16, '6/11/2021'::DATE, 36.7);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (16, '7/11/2021'::DATE, 36.9);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (16, '8/11/2021'::DATE, 37.0);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (17, '6/11/2021'::DATE, 36.8);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (17, '7/11/2021'::DATE, 37.6); -- fever
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (17, '8/11/2021'::DATE, 36.2);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (18, '6/11/2021'::DATE, 36.8);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (18, '7/11/2021'::DATE, 36.8);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (18, '8/11/2021'::DATE, 36.7);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (19, '6/11/2021'::DATE, 36.1);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (19, '7/11/2021'::DATE, 36.1);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (19, '8/11/2021'::DATE, 37.4);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (20, '6/11/2021'::DATE, 36.1);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (20, '7/11/2021'::DATE, 37.1);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (20, '8/11/2021'::DATE, 36.6);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (21, '6/11/2021'::DATE, 36.7);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (21, '7/11/2021'::DATE, 36.2);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (21, '8/11/2021'::DATE, 37.1);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (22, '6/11/2021'::DATE, 37.1);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (22, '7/11/2021'::DATE, 37.2);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (22, '8/11/2021'::DATE, 36.7);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (23, '6/11/2021'::DATE, 37.1);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (23, '7/11/2021'::DATE, 35.7);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (23, '8/11/2021'::DATE, 36.4);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (24, '6/11/2021'::DATE, 36.9);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (24, '7/11/2021'::DATE, 36.4);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (24, '8/11/2021'::DATE, 36.5);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (25, '6/11/2021'::DATE, 36.9);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (25, '7/11/2021'::DATE, 37.1);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (25, '8/11/2021'::DATE, 35.7);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (26, '6/11/2021'::DATE, 37.3);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (26, '7/11/2021'::DATE, 37.6); -- fever
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (26, '8/11/2021'::DATE, 36.6);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (27, '6/11/2021'::DATE, 36.4);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (27, '7/11/2021'::DATE, 36.4);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (27, '8/11/2021'::DATE, 36.6);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (28, '6/11/2021'::DATE, 36.7);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (28, '7/11/2021'::DATE, 37.0);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (28, '8/11/2021'::DATE, 36.5);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (29, '6/11/2021'::DATE, 36.9);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (29, '7/11/2021'::DATE, 36.1);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (29, '8/11/2021'::DATE, 36.8);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (30, '6/11/2021'::DATE, 36.0);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (30, '7/11/2021'::DATE, 36.5);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (30, '8/11/2021'::DATE, 37.5);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (31, '6/11/2021'::DATE, 37.5);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (31, '7/11/2021'::DATE, 36.9);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (31, '8/11/2021'::DATE, 36.5);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (32, '6/11/2021'::DATE, 35.9);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (32, '7/11/2021'::DATE, 37.4);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (32, '8/11/2021'::DATE, 36.7);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (33, '6/11/2021'::DATE, 36.6);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (33, '7/11/2021'::DATE, 36.8);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (33, '8/11/2021'::DATE, 35.9);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (34, '6/11/2021'::DATE, 37.4);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (34, '7/11/2021'::DATE, 36.9);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (34, '8/11/2021'::DATE, 36.1);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (35, '6/11/2021'::DATE, 36.8);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (35, '7/11/2021'::DATE, 37.0);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (35, '8/11/2021'::DATE, 37.1);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (36, '6/11/2021'::DATE, 36.8);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (36, '7/11/2021'::DATE, 36.6);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (36, '8/11/2021'::DATE, 37.0);
-- INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (37, '6/11/2021'::DATE, 36.0); -- 37 resigned on 2/11/2021
-- INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (37, '7/11/2021'::DATE, 36.9);
-- INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (37, '8/11/2021'::DATE, 37.4);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (38, '6/11/2021'::DATE, 37.3);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (38, '7/11/2021'::DATE, 36.4);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (38, '8/11/2021'::DATE, 37.1);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (39, '6/11/2021'::DATE, 36.7);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (39, '7/11/2021'::DATE, 36.6);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (39, '8/11/2021'::DATE, 37.1);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (40, '6/11/2021'::DATE, 36.4);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (40, '7/11/2021'::DATE, 37.1);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (40, '8/11/2021'::DATE, 36.8);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (41, '6/11/2021'::DATE, 36.7);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (41, '7/11/2021'::DATE, 36.9);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (41, '8/11/2021'::DATE, 36.9);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (42, '6/11/2021'::DATE, 37.4);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (42, '7/11/2021'::DATE, 36.9);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (42, '8/11/2021'::DATE, 36.7);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (43, '6/11/2021'::DATE, 36.1);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (43, '7/11/2021'::DATE, 36.8);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (43, '8/11/2021'::DATE, 36.3);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (44, '6/11/2021'::DATE, 36.8);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (44, '7/11/2021'::DATE, 36.6);
-- INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (44, '8/11/2021'::DATE, 37.1); -- 44 resigned on 8/11/2021
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (45, '6/11/2021'::DATE, 37.4);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (45, '7/11/2021'::DATE, 36.7);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (45, '8/11/2021'::DATE, 36.6);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (46, '6/11/2021'::DATE, 36.8);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (46, '7/11/2021'::DATE, 36.8);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (46, '8/11/2021'::DATE, 36.8);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (47, '6/11/2021'::DATE, 36.5);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (47, '7/11/2021'::DATE, 36.6);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (47, '8/11/2021'::DATE, 36.7);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (48, '6/11/2021'::DATE, 36.5);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (48, '7/11/2021'::DATE, 37.1);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (48, '8/11/2021'::DATE, 36.8);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (49, '6/11/2021'::DATE, 37.1);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (49, '7/11/2021'::DATE, 36.6);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (49, '8/11/2021'::DATE, 37.2);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (50, '6/11/2021'::DATE, 37.7); -- fever
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (50, '7/11/2021'::DATE, 37.3);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (50, '8/11/2021'::DATE, 37.1);
-- INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (51, '6/11/2021'::DATE, 36.9); -- 51 resigned on 6/11/2021
-- INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (51, '7/11/2021'::DATE, 36.9);
-- INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (51, '8/11/2021'::DATE, 36.5);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (52, '6/11/2021'::DATE, 36.5);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (52, '7/11/2021'::DATE, 36.5);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (52, '8/11/2021'::DATE, 37.0);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (53, '6/11/2021'::DATE, 36.2);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (53, '7/11/2021'::DATE, 37.0);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (53, '8/11/2021'::DATE, 37.0);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (54, '6/11/2021'::DATE, 36.9);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (54, '7/11/2021'::DATE, 36.4);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (54, '8/11/2021'::DATE, 37.1);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (55, '6/11/2021'::DATE, 36.4);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (55, '7/11/2021'::DATE, 36.9);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (55, '8/11/2021'::DATE, 37.4);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (56, '6/11/2021'::DATE, 36.7);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (56, '7/11/2021'::DATE, 37.2);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (56, '8/11/2021'::DATE, 36.9);
-- INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (57, '6/11/2021'::DATE, 36.4); -- 57 resigned on 3/11/2021
-- INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (57, '7/11/2021'::DATE, 35.9);
-- INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (57, '8/11/2021'::DATE, 37.5);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (58, '6/11/2021'::DATE, 36.9);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (58, '7/11/2021'::DATE, 37.3);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (58, '8/11/2021'::DATE, 36.9);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (59, '6/11/2021'::DATE, 37.1);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (59, '7/11/2021'::DATE, 36.7);
INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (59, '8/11/2021'::DATE, 37.3);
-- INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (60, '6/11/2021'::DATE, 36.4); -- 60 resigned on 2/11/2021
-- INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (60, '7/11/2021'::DATE, 36.9);
-- INSERT INTO health_declaration (eid, declaration_date, temperature) VALUES (60, '8/11/2021'::DATE, 37.8); -- fever
