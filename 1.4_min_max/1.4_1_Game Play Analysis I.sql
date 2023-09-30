/*
https://leetcode.com/problems/game-play-analysis-i/ 

Table: Activity
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.
 
Write an SQL query to report the first login date for each player.
Return the result table in any order.

The query result format is in the following example.
Example 1:
Input: 
Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-05-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+
Output: 
+-----------+-------------+
| player_id | first_login |
+-----------+-------------+
| 1         | 2016-03-01  |
| 2         | 2017-06-25  |
| 3         | 2016-03-02  |
+-----------+-------------+
*/

# [SETTING]
USE PRACTICE;
DROP TABLE ACTIVITY;
CREATE TABLE ACTIVITY (PLAYER_ID INT, DEVICE_ID INT, EVENT_DATE DATE, GAMES_PLAYED INT);
INSERT INTO
	ACTIVITY (PLAYER_ID, DEVICE_ID, EVENT_DATE, GAMES_PLAYED)
VALUES
	('1', '2', '2016-03-01', '5')
	,('1', '2', '2016-05-02', '6')
	,('2', '3', '2017-06-25', '1')
	,('3', '1', '2016-03-02', '0')
	,('3', '4', '2018-07-03', '5');
SELECT * FROM ACTIVITY;

# [KEY]
# 어렵게 row_number() 사용할 필요 없이, min 집계함수 이용해서 쉽게 풀기
# 'first' 문제는 min과 연결, 'last' 문제는 max와 연결

# [MYSQL]
SELECT PLAYER_ID,
MIN(EVENT_DATE) FIRST_LOGIN
FROM ACTIVITY
GROUP BY PLAYER_ID;