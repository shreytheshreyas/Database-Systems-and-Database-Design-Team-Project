-- valid inputs
SELECT * FROM non_compliance('2/11/2021', '6/11/2021');

-- end date in the future
SELECT * FROM non_compliance('6/11/2021', '7/11/2021');

-- start date in the future
SELECT * FROM non_compliance('7/11/2021', '8/11/2021');

-- start date after end date
SELECT * FROM non_compliance('6/11/2021', '5/11/2021');

CALL declare_health(1, '2/11/2021', 36.6);
CALL declare_health(1, '4/11/2021', 36.5);

-- 1 is now only missing 2 instead of 4 originally
SELECT * FROM non_compliance('2/11/2021', '6/11/2021');
