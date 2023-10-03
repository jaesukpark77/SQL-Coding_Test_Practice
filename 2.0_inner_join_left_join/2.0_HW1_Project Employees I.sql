/*
https://leetcode.com/problems/project-employees-i/ 

Table: Project
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| project_id  | int     |
| employee_id | int     |
+-------------+---------+
(project_id, employee_id) is the primary key of this table.
employee_id is a foreign key to Employee table.
Each row of this table indicates that the employee with employee_id is working on the project with project_id.

Table: Employee
+------------------+---------+
| Column Name      | Type    |
+------------------+---------+
| employee_id      | int     |
| name             | varchar |
| experience_years | int     |
+------------------+---------+
employee_id is the primary key of this table. It's guaranteed that experience_years is not NULL.
Each row of this table contains information about one employee.
 
Write an SQL query that reports the average experience years of all the employees for each project, rounded to 2 digits.
Return the result table in any order.

The query result format is in the following example.
Example 1:
Input: 
Project table:
+-------------+-------------+
| project_id  | employee_id |
+-------------+-------------+
| 1           | 1           |
| 1           | 2           |
| 1           | 3           |
| 2           | 1           |
| 2           | 4           |
+-------------+-------------+
Employee table:
+-------------+--------+------------------+
| employee_id | name   | experience_years |
+-------------+--------+------------------+
| 1           | Khaled | 3                |
| 2           | Ali    | 2                |
| 3           | John   | 1                |
| 4           | Doe    | 2                |
+-------------+--------+------------------+
Output: 
+-------------+---------------+
| project_id  | average_years |
+-------------+---------------+
| 1           | 2.00          |
| 2           | 2.50          |
+-------------+---------------+
Explanation: The average experience years for the first project is (3 + 2 + 1) / 3 = 2.00 and for the second project is (3 + 2) / 2 = 2.50
*/

# [SETTING]
USE PRACTICE;
DROP TABLE PROJECT;
CREATE TABLE PROJECT (PROJECT_ID INT, EMPLOYEE_ID INT);
INSERT INTO
	PROJECT (PROJECT_ID, EMPLOYEE_ID)
VALUES
	('1', '1')
	,('1', '2')
	,('1', '3')
	,('2', '1')
	,('2', '4');
SELECT * FROM PROJECT;	    

# [SETTING]
USE PRACTICE;
DROP TABLE EMPLOYEE;
CREATE TABLE EMPLOYEE (EMPLOYEE_ID INT, NAME VARCHAR(255), EXPERIENCE_YEARS INT);
INSERT INTO
	EMPLOYEE (EMPLOYEE_ID, NAME, EXPERIENCE_YEARS)
VALUES
	('1', 'KHALED', '3')
	,('2', 'ALI', '2')
	,('3', 'JOHN', '1')
	,('4', 'DOE', '2');
SELECT * FROM EMPLOYEE;	   

# [MYSQL]
SELECT P.PROJECT_ID,
ROUND(AVG(E.EXPERIENCE_YEARS),2) AVERAGE_YEARS
FROM PROJECT P
INNER JOIN
EMPLOYEE E
ON P.EMPLOYEE_ID = E.EMPLOYEE_ID
GROUP BY P.PROJECT_ID;