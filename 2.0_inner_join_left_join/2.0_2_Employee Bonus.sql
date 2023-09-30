/*
https://leetcode.com/problems/employee-bonus/ 

Table: Employee
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| empId       | int     |
| name        | varchar |
| supervisor  | int     |
| salary      | int     |
+-------------+---------+
empId is the primary key column for this table.
Each row of this table indicates the name and the ID of an employee in addition to their salary and the id of their manager.
 
 Table: Bonus
 +-------------+------+
| Column Name | Type |
+-------------+------+
| empId       | int  |
| bonus       | int  |
+-------------+------+
empId is the primary key column for this table.
empId is a foreign key to empId from the Employee table.
Each row of this table contains the id of an employee and their respective bonus.

Write an SQL query to report the name and bonus amount of each employee with a bonus less than 1000.
Return the result table in any order.

The query result format is in the following example.
Input: 
Employee table:
+-------+--------+------------+--------+
| empId | name   | supervisor | salary |
+-------+--------+------------+--------+
| 3     | Brad   | null       | 4000   |
| 1     | John   | 3          | 1000   |
| 2     | Dan    | 3          | 2000   |
| 4     | Thomas | 3          | 4000   |
+-------+--------+------------+--------+
Bonus table:
+-------+-------+
| empId | bonus |
+-------+-------+
| 2     | 500   |
| 4     | 2000  |
+-------+-------+
Output: 
+------+-------+
| name | bonus |
+------+-------+
| Brad | null  |
| John | null  |
| Dan  | 500   |
+------+-------+
*/

# [SETTING]
USE PRACTICE;
DROP TABLE EMPLOYEE;
CREATE TABLE EMPLOYEE (EMPID INT, NAME VARCHAR(255), SUPERVISOR INT, SALARY INT);
INSERT INTO
	EMPLOYEE (EMPID, NAME, SUPERVISOR, SALARY)
VALUES
	('1', 'JOHN', '3', '1000')
	,('2', 'DAN', '3', '2000')
	,('3', 'BRAD', NULL, '4000')
	,('4', 'THOMAS', '3', '4000');
SELECT * FROM EMPLOYEE;	  
     
# [SETTING]
USE PRACTICE;
DROP TABLE BONUS;
CREATE TABLE BONUS (EMPID INT, BONUS INT);
INSERT INTO
	BONUS (EMPID, BONUS)
VALUES
	('2', '500')
	,('4', '2000');
SELECT * FROM BONUS;	  
     
# [MYSQL]
SELECT A.NAME,
B.BONUS
FROM
(
	SELECT EMPID,
	NAME
	FROM EMPLOYEE
	WHERE EMPID NOT IN (
		SELECT EMPID
		FROM BONUS
		WHERE BONUS >=1000
		)
) A
LEFT OUTER JOIN
BONUS B
ON A.EMPID=B.EMPID;
					
