/*
https://leetcode.com/problems/employees-earning-more-than-their-managers/


Table: Employee
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| salary      | int     |
| managerId   | int     |
+-------------+---------+
id is the primary key column for this table.
Each row of this table indicates the ID of an employee, their name, salary, and the ID of their manager.
 
Write an SQL query to find the employees who earn more than their managers.
Return the result table in any order.

The query result format is in the following example.
Example 1:
Input: 
Employee table:
+----+-------+--------+-----------+
| id | name  | salary | managerId |
+----+-------+--------+-----------+
| 1  | Joe   | 70000  | 3         |
| 2  | Henry | 80000  | 4         |
| 3  | Sam   | 60000  | Null      |
| 4  | Max   | 90000  | Null      |
+----+-------+--------+-----------+
Output: 
+----------+
| Employee |
+----------+
| Joe      |
+----------+
Explanation: Joe is the only employee who earns more than his manager.
*/

# [SETTING]
USE PRACTICE;
DROP TABLE EMPLOYEE;
CREATE TABLE EMPLOYEE (ID INT, NAME VARCHAR(255), SALARY INT, MANAGERID INT);
INSERT INTO
	EMPLOYEE (ID, NAME, SALARY, MANAGERID)
VALUES
	('1', 'JOE', '70000', '3')
	,('2', 'HENRY', '80000', '4')
	,('3', 'SAM', '60000', NULL)
	,('4', 'MAX', '90000', NULL);	    
SELECT * FROM EMPLOYEE;

# [KEY]
# [MYSQL1] self join
# [MYSQL2] in: 바깥 table의 alias를 안쪽 table의 alias에 그대로 사용 가능
# 안그러면 in 안에 전체 테이블 다 읽어야 되는데, 그럼 너무 비효율적. 바깥 테이블 alias와 조인해서 in 절 안에 있는 데이터 양을 적게 해서 가져오는 셈.
# 그럼 의미에서 subquery도 바깥 테이블 가져올 수 있음

# [PRACTICE]
SELECT * 
FROM EMPLOYEE E
INNER JOIN EMPLOYEE M
ON E.MANAGERID= M.ID; -- SELF JOIN

# [MYSQL1]
SELECT E.NAME AS EMPLOYEE
FROM EMPLOYEE E
INNER JOIN EMPLOYEE M
ON E.MANAGERID= M.ID -- SELF JOIN
WHERE E.SALARY > M.SALARY;

# [MYSQL2]
SELECT E.NAME AS EMPLOYEE
FROM EMPLOYEE E
WHERE E.NAME IN (
               SELECT E.NAME
               FROM EMPLOYEE M
               WHERE E.MANAGERID = M.ID
               AND E.SALARY > M.SALARY
              );