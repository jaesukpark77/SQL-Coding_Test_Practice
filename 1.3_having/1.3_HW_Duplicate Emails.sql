/*
https://leetcode.com/problems/duplicate-emails/ 

Table: Person
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| email       | varchar |
+-------------+---------+
id is the primary key column for this table.
Each row of this table contains an email. The emails will not contain uppercase letters.

Write an SQL query to report all the duplicate emails. Note that it's guaranteed that the email field is not NULL.
Return the result table in any order.

The query result format is in the following example.
Example 1:
Input: 
Person table:
+----+---------+
| id | email   |
+----+---------+
| 1  | a@b.com |
| 2  | c@d.com |
| 3  | a@b.com |
+----+---------+
Output: 
+---------+
| Email   |
+---------+
| a@b.com |
+---------+
Explanation: a@b.com is repeated two times.
*/

# [SETTING]
USE PRACTICE;
DROP TABLE CINEMA;
CREATE TABLE PERSON (ID INT, EMAIL VARCHAR(255));
INSERT INTO
	PERSON (ID, EMAIL) 
VALUES
	('1', 'A@B.COM')
	,('2', 'C@D.COM')
	,('3', 'A@B.COM');    
SELECT * FROM PERSON;

# [MYSQL]
SELECT EMAIL
FROM PERSON
GROUP BY EMAIL
HAVING COUNT(EMAIL) > 1;
