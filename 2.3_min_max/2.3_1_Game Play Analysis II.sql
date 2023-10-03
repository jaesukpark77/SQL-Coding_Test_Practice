/*
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
This table shows the activity of players of some game.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on some day using some device.

Write a SQL query that reports the device that is first logged in for each player.

The query result format is in the following example:
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

Result table:
+-----------+-----------+
| player_id | device_id |
+-----------+-----------+
| 1         | 2         |
| 2         | 3         |
| 3         | 1         |
+-----------+-----------+
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

# [MYSQL1]
SELECT A.PLAYER_ID,
A.DEVICE_ID
FROM ACTIVITY A
INNER JOIN
(
	SELECT PLAYER_ID,
	MIN(EVENT_DATE) MIN_DATE
	FROM ACTIVITY
	GROUP BY PLAYER_ID
) AA
ON A.PLAYER_ID = AA.PLAYER_ID
AND A.EVENT_DATE = AA.MIN_DATE; # 이 부분 작성 필수!

# [PRACTICE]
SELECT PLAYER_ID,
EVENT_DATE,
RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RK
FROM ACTIVITY
ORDER BY PLAYER_ID, EVENT_DATE;

# [MYSQL2]  
SELECT PLAYER_ID,
DEVICE_ID
FROM
(
	SELECT PLAYER_ID,
	DEVICE_ID,
	RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) DATE_RNK
	FROM ACTIVITY
) A
WHERE DATE_RNK = 1;