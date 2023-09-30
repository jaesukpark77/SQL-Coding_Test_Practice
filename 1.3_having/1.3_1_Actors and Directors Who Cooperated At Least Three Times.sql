/*
https://leetcode.com/problems/actors-and-directors-who-cooperated-at-least-three-times/ 

Table: ActorDirector
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| actor_id    | int     |
| director_id | int     |
| timestamp   | int     |
+-------------+---------+
timestamp is the primary key column for this table.
 
Write a SQL query for a report that provides the pairs (actor_id, director_id) where the actor has cooperated with the director at least three times.
Return the result table in any order.

The query result format is in the following example.
Example 1:
Input: 
ActorDirector table:
+-------------+-------------+-------------+
| actor_id    | director_id | timestamp   |
+-------------+-------------+-------------+
| 1           | 1           | 0           |
| 1           | 1           | 1           |
| 1           | 1           | 2           |
| 1           | 2           | 3           |
| 1           | 2           | 4           |
| 2           | 1           | 5           |
| 2           | 1           | 6           |
+-------------+-------------+-------------+
Output: 
+-------------+-------------+
| actor_id    | director_id |
+-------------+-------------+
| 1           | 1           |
+-------------+-------------+
Explanation: The only pair is (1, 1) where they cooperated exactly 3 times.
*/

# [SETTING]
USE PRACTICE;
DROP TABLE ACTORDIRECTOR;
CREATE TABLE ACTORDIRECTOR (ACTOR_ID INT, DIRECTOR_ID INT, TIMESTAMP INT);
INSERT INTO
	ACTORDIRECTOR (ACTOR_ID, DIRECTOR_ID, TIMESTAMP)
VALUES
	('1', '1', '0')
	,('1', '1', '1')
	,('1', '1', '2')
	,('1', '2', '3')
	,('1', '2', '4')
	,('2', '1', '5')
	,('2', '1', '6');
SELECT * FROM ACTORDIRECTOR;

# [KEY]
# 'at least': 등호 포함된 >=
# COUNT(actor_id), COUNT(director_id), COUNT(timestamp), COUNT(*): 모두 having절에서 사용해도 정답

# [MYSQL] 
SELECT ACTOR_ID,
DIRECTOR_ID
FROM ACTORDIRECTOR
GROUP BY ACTOR_ID, DIRECTOR_ID
HAVING COUNT(ACTOR_ID) >= 3;
