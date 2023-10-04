/*
https://leetcode.com/problems/triangle-judgement/ 

Table: Triangle
+-------------+------+
| Column Name | Type |
+-------------+------+
| x           | int  |
| y           | int  |
| z           | int  |
+-------------+------+
(x, y, z) is the primary key column for this table.
Each row of this table contains the lengths of three line segments.
 
Write an SQL query to report for every three line segments whether they can form a triangle.
Return the result table in any order.

The query result format is in the following example.
Example 1:
Input: 
Triangle table:
+----+----+----+
| x  | y  | z  |
+----+----+----+
| 13 | 15 | 30 |
| 10 | 20 | 15 |
+----+----+----+
Output: 
+----+----+----+----------+
| x  | y  | z  | triangle |
+----+----+----+----------+
| 13 | 15 | 30 | No       |
| 10 | 20 | 15 | Yes      |
+----+----+----+----------+
*/

# [SETTING]
USE PRACTICE;
DROP TABLE TRIANGLE;
CREATE TABLE TRIANGLE (X INT, Y INT, Z INT);
INSERT INTO
	 TRIANGLE (X, Y, Z)
VALUES
('13', '15', '30')
,('10', '20', '15');
SELECT * FROM TRIANGLE;


# [MYSQL]
SELECT x,
y,
z,
CASE WHEN x+y <= z THEN 'No'
    WHEN y+z <= x THEN 'No' 
    WHEN z+x <= y THEN 'No' 
    ELSE 'Yes' END AS triangle
FROM triangle;

