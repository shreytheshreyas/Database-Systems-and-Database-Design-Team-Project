-- RUN data.sql first

-- add_department, new department
SELECT add_department(10, 'Research');
-- add_department, duplicate department ID
SELECT add_department(10, 'Research');
-- add_department, duplicate department name
SELECT add_department(11, 'Research');


-- remove_department, remove existing department
SELECT remove_department(10);
-- remove_department, remove department that does not exist
SELECT remove_department(12);

-- add_room, add a new room
SELECT add_room(5, 5, 'Room Five', 10, 1);
-- add_room, adding a duplicate room
SELECT add_room(1, 1, 'Room One', 10, 1);
-- add_room, add a new room name with same floor and same room number
SELECT add_room(5, 5, 'Room Five Again', 10, 1);

-- change_capacity
SELECT change_capacity(5, 5, 22, '27-10-2021', 1);

-- add_employee, add a new employee
CALL add_employee('Micheal Kane', 'junior', 1, 192832473, 29229292, 1111111);
-- add_employee, add a new employee with the same name
CALL add_employee('Micheal Kane', 'junior', 1, 192832473, 29229292, 1111111);

-- remove_employee, removing Micheal Kane
CALL remove_employee(66, '6/11/2021'::DATE); 