/*
https://leetcode.com/problems/user-activity-for-the-past-30-days-i/ 

Table: Activity
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| session_id    | int     |
| activity_date | date    |
| activity_type | enum    |
+---------------+---------+
There is no primary key for this table, it may have duplicate rows.
The activity_type column is an ENUM of type ('open_session', 'end_session', 'scroll_down', 'send_message').
The table shows the user activities for a social media website. 
Note that each session belongs to exactly one user.

Write an SQL query to find the daily active user count for a period of 30 days ending 2019-07-27 inclusively. A user was active on someday if they made at least one activity on that day.
Return the result table in any order.

The query result format is in the following example.
Input: 
Activity table:
+---------+------------+---------------+---------------+
| user_id | session_id | activity_date | activity_type |
+---------+------------+---------------+---------------+
| 1       | 1          | 2019-07-20    | open_session  |
| 1       | 1          | 2019-07-20    | scroll_down   |
| 1       | 1          | 2019-07-20    | end_session   |
| 2       | 4          | 2019-07-20    | open_session  |
| 2       | 4          | 2019-07-21    | send_message  |
| 2       | 4          | 2019-07-21    | end_session   |
| 3       | 2          | 2019-07-21    | open_session  |
| 3       | 2          | 2019-07-21    | send_message  |
| 3       | 2          | 2019-07-21    | end_session   |
| 4       | 3          | 2019-06-25    | open_session  |
| 4       | 3          | 2019-06-25    | end_session   |
+---------+------------+---------------+---------------+
Output: 
+------------+--------------+ 
| day        | active_users |
+------------+--------------+ 
| 2019-07-20 | 2            |
| 2019-07-21 | 2            |
+------------+--------------+ 
Explanation: Note that we do not care about days with zero active users.
*/

# [SETTING]
USE PRACTICE;
DROP TABLE ACTIVITY;
CREATE TABLE ACTIVITY (USER_ID INT, SESSION_ID INT, ACTIVITY_DATE DATE, ACTIVITY_TYPE VARCHAR(255));
INSERT INTO
	ACTIVITY (USER_ID, SESSION_ID, ACTIVITY_DATE, ACTIVITY_TYPE)
VALUES
	('1', '1', '2019-07-20', 'OPEN_SESSION')
	,('1', '1', '2019-07-20', 'SCROLL_DOWN')
	,('1', '1', '2019-07-20', 'END_SESSION')
	,('2', '4', '2019-07-20', 'OPEN_SESSION')
	,('2', '4', '2019-07-21', 'SEND_MESSAGE')
	,('2', '4', '2019-07-21', 'END_SESSION')
	,('3', '2', '2019-07-21', 'OPEN_SESSION')
	,('3', '2', '2019-07-21', 'SEND_MESSAGE')
	,('3', '2', '2019-07-21', 'END_SESSION')
	,('4', '3', '2019-06-25', 'OPEN_SESSION')
	,('4', '3', '2019-06-25', 'END_SESSION');
SELECT * FROM ACTIVITY;	

# [KEY]
# DATE_SUB 함수, DATE_ADD 함수
# 'period of 30 days': 한 쪽은 등호 있고, 한 쪽은 등호가 없어야지 기간이 30일이 된다.

# [WRONG DATE]
SELECT '2019-07-27' - 30 AS col1,
'2019-07-27' AS col2;

# [RIGHT DATE]
SELECT DATE_SUB('2019-07-27', INTERVAL 30 DAY) AS col1,
'2019-07-27' AS col2;

# [MYSQL]
SELECT ACTIVITY_DATE AS DAY,
COUNT(DISTINCT USER_ID) AS ACTIVE_USERS
FROM ACTIVITY
WHERE DATE_SUB('2019-07-27', INTERVAL 30 DAY) < ACTIVITY_DATE
AND ACTIVITY_DATE <= '2019-07-27'
GROUP BY ACTIVITY_DATE;