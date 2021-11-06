-- returns 14's approved 3-hour meeting starting on 8/11/2021 0900
-- and 14's unapproved 1-hour meeting starting on 12/11/2021 1600
SELECT view_booking_report('8/11/2021', 14);

-- returns 14's unapproved 1-hour meeting starting on 12/11/2021 1600
SELECT view_booking_report('9/11/2021', 14);

-- junior employee, returns empty table
SELECT view_booking_report('9/11/2021', 23);

-- returns 2's approved 1-hour meeting starting on 2/11/2021 1000
-- and 2's approved 2-hour meeting starting on 17/11/2021 1600
SELECT view_booking_report('1/11/2021', 2);
