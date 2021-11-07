-- VIEW_FUTURE_MEETING 

--11/11 onwards is a future meeting
SELECT view_future_meeting('11/11/2021', 10);
-- result: 2 rows (1,1,17/11)

SELECT join_meeting(1, 1, '2021-11-15', '15:00:00', '16:00:00', 10); -- add new meeting(+1 row)
SELECT view_future_meeting('11/11/2021', 10);

SELECT view_future_meeting('31/10/2021', 10);
-- result: 4 rows



-- VIEW_MANAGER_REPORT
-- employee id does not belong to manager, return empty table
SELECT view_manager_report('2021-11-15', 11);
SELECT view_manager_report('2021-10-31', 1);
--2 rows
SELECT view_manager_report('2021-10-27', 2);
--2 rows



