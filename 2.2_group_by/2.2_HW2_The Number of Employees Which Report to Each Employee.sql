/*
https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee/ 

Table: Employees
+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| employee_id | int      |
| name        | varchar  |
| reports_to  | int      |
| age         | int      |
+-------------+----------+
employee_id is the primary key for this table.
This table contains information about the employees and the id of the manager they report to. Some employees do not report to anyone (reports_to is null). 

For this problem, we will consider a manager an employee who has at least 1 other employee reporting to them.
Write an SQL query to report the ids and the names of all managers, the number of employees who report directly to them, and the average age of the reports rounded to the nearest integer.
Return the result table ordered by employee_id.

The query result format is in the following example.
Example 1:
Input: 
Employees table:
+-------------+---------+------------+-----+
| employee_id | name    | reports_to | age |
+-------------+---------+------------+-----+
| 9           | Hercy   | null       | 43  |
| 6           | Alice   | 9          | 41  |
| 4           | Bob     | 9          | 36  |
| 2           | Winston | null       | 37  |
+-------------+---------+------------+-----+
Output: 
+-------------+-------+---------------+-------------+
| employee_id | name  | reports_count | average_age |
+-------------+-------+---------------+-------------+
| 9           | Hercy | 2             | 39          |
+-------------+-------+---------------+-------------+
Explanation: Hercy has 2 people report directly to him, Alice and Bob. Their average age is (41+36)/2 = 38.5, which is 39 after rounding it to the nearest integer.
*/

# [SETTING]
USE PRACTICE;
DROP TABLE Employees;
CREATE TABLE Employees(employee_id int, name varchar(20), reports_to int, age int);
INSERT INTO
	Employees (employee_id, name, reports_to, age)
VALUES
('9', 'Hercy', 'None', '43')
,('6', 'Alice', '9', '41')
,('4', 'Bob', '9', '36')
,('2', 'Winston', 'None', '37');
SELECT * FROM Employees;

# [MYSQL]
select e.employee_id,
e.name,
count(ee.employee_id) reports_count,
round(avg(ee.age), 0) average_age
from Employees e
inner join Employees ee
on e.employee_id=ee.reports_to
group by e.employee_id, e.name
order by e.employee_id;