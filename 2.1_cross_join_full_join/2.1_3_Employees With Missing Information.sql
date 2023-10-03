/*
https://leetcode.com/problems/employees-with-missing-information/ 

Table: Employees
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| employee_id | int     |
| name        | varchar |
+-------------+---------+
employee_id is the primary key for this table.
Each row of this table indicates the name of the employee whose ID is employee_id.
 
Table: Salaries
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| employee_id | int     |
| salary      | int     |
+-------------+---------+
employee_id is the primary key for this table.
Each row of this table indicates the salary of the employee whose ID is employee_id.
 
Write an SQL query to report the IDs of all the employees with missing information. The information of an employee is missing if:
The employee's name is missing, or
The employee's salary is missing.
Return the result table ordered by employee_id in ascending order.

The query result format is in the following example.
Example 1:
Input: 
Employees table:
+-------------+----------+
| employee_id | name     |
+-------------+----------+
| 2           | Crew     |
| 4           | Haven    |
| 5           | Kristian |
+-------------+----------+
Salaries table:
+-------------+--------+
| employee_id | salary |
+-------------+--------+
| 5           | 76071  |
| 1           | 22517  |
| 4           | 63539  |
+-------------+--------+
Output: 
+-------------+
| employee_id |
+-------------+
| 1           |
| 2           |
+-------------+
Explanation: 
Employees 1, 2, 4, and 5 are working at this company.
The name of employee 1 is missing.
The salary of employee 2 is missing.
*/

# [SETTING]
USE PRACTICE;
DROP TABLE Employees;
CREATE TABLE Employees (employee_id int, name varchar(30));
INSERT INTO
	Employees (employee_id, name)
VALUES
('2', 'Crew')
,('4', 'Haven')
,('5', 'Kristian');
SELECT * FROM Employees;

# [SETTING]
USE PRACTICE;
DROP TABLE Salaries;
CREATE TABLE Salaries (employee_id int, salary int);
INSERT INTO
	Salaries (employee_id, salary)
VALUES
('5', '76071')
,('1', '22517')
,('4', '63539');
SELECT * FROM Salaries;

# [MYSQL]
# MYSQL에서는 full outer join을 지원하지 않아서, 이렇게 대체로 full outer join 로직을 작성한다.
select a.employee_id
from Employees a
left outer join
Salaries b
on a.employee_id = b.employee_id
where b.employee_id is null

union

select a.employee_id
from Salaries a
left outer join
Employees b
on a.employee_id = b.employee_id
where b.employee_id is null
order by employee_id;