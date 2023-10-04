/*
https://leetcode.com/problems/rising-temperature/ 

Table: Weather
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
id is the primary key for this table.
This table contains information about the temperature on a certain day.
 
Write an SQL query to find all dates' Id with higher temperatures compared to its previous dates (yesterday).
Return the result table in any order.

The query result format is in the following example.
Example 1:
Input: 
Weather table:
+----+------------+-------------+
| id | recordDate | temperature |
+----+------------+-------------+
| 1  | 2015-01-01 | 10          |
| 2  | 2015-01-02 | 25          |
| 3  | 2015-01-03 | 20          |
| 4  | 2015-01-04 | 30          |
+----+------------+-------------+
Output: 
+----+
| id |
+----+
| 2  |
| 4  |
+----+
Explanation: 
In 2015-01-02, the temperature was higher than the previous day (10 -> 25).
In 2015-01-04, the temperature was higher than the previous day (20 -> 30).
*/

# [SETTING]
USE PRACTICE;
DROP TABLE WEATHER;
CREATE TABLE WEATHER (ID INT, RECORDDATE DATE, TEMPERATURE INT);
INSERT INTO
	WEATHER (ID, RECORDDATE, TEMPERATURE)
VALUES
('1', '2015-01-01', '10')
,('2', '2015-01-02', '25')
,('3', '2015-01-03', '20')
,('4', '2015-01-04', '30')
,('5', '2015-01-14', '5') # 데이터 추가함
,('6', '2015-01-16', '7'); # 데이터 추가함
SELECT * FROM WEATHER;

# [KEY]
# 'previous'

# [PRACTICE]
SELECT ID,
RECORDDATE RD,
TEMPERATURE T,
LAG(RECORDDATE) OVER (ORDER BY RECORDDATE) PRE_RD, # 1개 row 이전
LAG(TEMPERATURE) OVER (ORDER BY RECORDDATE) PRE_T # 1개 row 이전
FROM WEATHER;
        
# [MYSQL1]
SELECT ID
FROM
(
	SELECT ID,
	RECORDDATE RD,
	TEMPERATURE T,
	LAG(RECORDDATE) OVER (ORDER BY RECORDDATE) PRE_RD, # 1개 row 이전
	LAG(TEMPERATURE) OVER (ORDER BY RECORDDATE) PRE_T # 1개 row 이전
	FROM WEATHER
) A
 WHERE DATE_ADD(PRE_RD, INTERVAL 1 DAY) = RD # 안쓸경우, '2015-01-14', '2015-01-16'에서 예외 상황 발생
 AND PRE_T < T;


# 만약 LAG, LEAD 함수를 지원하지 않는 경우 (ex. 낮은 버전의 SQLLite DB 엔진)
# 참고: https://stackoverflow.com/questions/53630542/alternatives-to-lead-and-lag-in-sqlite

# [PRACTICE]
SELECT ID,
RECORDDATE RD,
TEMPERATURE T,
(
	SELECT T1.RECORDDATE
	FROM WEATHER T1
	WHERE T1.RECORDDATE < A.RECORDDATE # 이전 날짜들 중에서
	ORDER BY T1.RECORDDATE DESC 
	LIMIT 1
) PRE_RD,
(
	SELECT T1.TEMPERATURE
	FROM WEATHER T1
	WHERE T1.RECORDDATE < A.RECORDDATE  # 이전 날짜들 중에서
	ORDER BY T1.RECORDDATE DESC 
	LIMIT 1
) PRE_T
FROM WEATHER A;

# [MYSQL2]
SELECT ID
from
(
	SELECT ID,
	RECORDDATE RD,
	TEMPERATURE T,
	(
		SELECT T1.RECORDDATE
		FROM WEATHER T1
		WHERE T1.RECORDDATE < A.RECORDDATE # 이전 날짜들 중에서
		ORDER BY T1.RECORDDATE DESC 
		LIMIT 1
	) PRE_RD,
	(
		SELECT T1.TEMPERATURE
		FROM WEATHER T1
		WHERE T1.RECORDDATE < A.RECORDDATE # 이전 날짜들 중에서
		ORDER BY T1.RECORDDATE DESC 
		LIMIT 1
	) PRE_T
	FROM WEATHER A
) T
WHERE DATE_ADD(PRE_RD, INTERVAL 1 DAY) = RD # 안쓸경우, '2015-01-14', '2015-01-16'에서 예외 상황 발생
AND PRE_T < T;