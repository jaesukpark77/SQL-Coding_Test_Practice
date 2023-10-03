/*
https://leetcode.com/problems/sales-person/ 

Table: SalesPerson
+-----------------+---------+
| Column Name     | Type    |
+-----------------+---------+
| sales_id        | int     |
| name            | varchar |
| salary          | int     |
| commission_rate | int     |
| hire_date       | date    |
+-----------------+---------+
sales_id is the primary key column for this table.
Each row of this table indicates the name and the ID of a salesperson alongside their salary, commission rate, and hire date.

Table: Company
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| com_id      | int     |
| name        | varchar |
| city        | varchar |
+-------------+---------+
com_id is the primary key column for this table.
Each row of this table indicates the name and the ID of a company and the city in which the company is located.

Table: Orders
+-------------+------+
| Column Name | Type |
+-------------+------+
| order_id    | int  |
| order_date  | date |
| com_id      | int  |
| sales_id    | int  |
| amount      | int  |
+-------------+------+
order_id is the primary key column for this table.
com_id is a foreign key to com_id from the Company table.
sales_id is a foreign key to sales_id from the SalesPerson table.
Each row of this table contains information about one order. This includes the ID of the company, the ID of the salesperson, the date of the order, and the amount paid.
 
Write an SQL query to report the names of all the salespersons who did not have any orders related to the company with the name "RED".
Return the result table in any order.

The query result format is in the following example.
Example 1:
Input: 
SalesPerson table:
+----------+------+--------+-----------------+------------+
| sales_id | name | salary | commission_rate | hire_date  |
+----------+------+--------+-----------------+------------+
| 1        | John | 100000 | 6               | 4/1/2006   |
| 2        | Amy  | 12000  | 5               | 5/1/2010   |
| 3        | Mark | 65000  | 12              | 12/25/2008 |
| 4        | Pam  | 25000  | 25              | 1/1/2005   |
| 5        | Alex | 5000   | 10              | 2/3/2007   |
+----------+------+--------+-----------------+------------+
Company table:
+--------+--------+----------+
| com_id | name   | city     |
+--------+--------+----------+
| 1      | RED    | Boston   |
| 2      | ORANGE | New York |
| 3      | YELLOW | Boston   |
| 4      | GREEN  | Austin   |
+--------+--------+----------+
Orders table:
+----------+------------+--------+----------+--------+
| order_id | order_date | com_id | sales_id | amount |
+----------+------------+--------+----------+--------+
| 1        | 1/1/2014   | 3      | 4        | 10000  |
| 2        | 2/1/2014   | 4      | 5        | 5000   |
| 3        | 3/1/2014   | 1      | 1        | 50000  |
| 4        | 4/1/2014   | 1      | 4        | 25000  |
+----------+------------+--------+----------+--------+
Output: 
+------+
| name |
+------+
| Amy  |
| Mark |
| Alex |
+------+
Explanation: 
According to orders 3 and 4 in the Orders table, it is easy to tell that only salesperson John and Pam have sales to company RED, so we report all the other names in the table salesperson.
*/

# [SETTING]
USE PRACTICE;
DROP TABLE SALESPERSON;
CREATE TABLE SALESPERSON (SALES_ID INT, NAME VARCHAR(255), SALARY INT, COMMISSION_RATE INT, HIRE_DATE DATE);
INSERT INTO
	SALESPERSON (SALES_ID, NAME, SALARY, COMMISSION_RATE, HIRE_DATE)
VALUES
	('1', 'JOHN', '100000', '6', '2006-04-01')
	,('2', 'AMY', '120000', '5', '2010-05-01')
	,('3', 'MARK', '65000', '12', '2008-12-24')
	,('4', 'PAM', '25000', '25', '2005-01-01')
	,('5', 'ALEX', '50000', '10', '2007-02-03');
SELECT * FROM SALESPERSON;	

# [SETTING]
USE PRACTICE;
DROP TABLE COMPANY;
CREATE TABLE COMPANY (COM_ID INT, NAME VARCHAR(255), CITY VARCHAR(255));
INSERT INTO
	COMPANY (COM_ID, NAME, CITY)
VALUES
	('1', 'RED', 'BOSTON')
	,('2', 'ORANGE', 'NEW YORK')
	,('3', 'YELLOW', 'BOSTON')
	,('4', 'GREEN', 'AUSTIN');
SELECT * FROM COMPANY;	

# [SETTING]
USE PRACTICE;
DROP TABLE ORDERS;
CREATE TABLE ORDERS (ORDER_ID INT, DATES DATE, COM_ID INT, SALES_ID INT, AMOUNT INT);
INSERT INTO
	ORDERS (ORDER_ID, DATES, COM_ID, SALES_ID, AMOUNT)
VALUES
	('1', '2014-01-01', '3', '4', '100000')
	,('2', '2014-02-01', '4', '5', '5000')
	,('3', '2014-03-01', '1', '1', '50000')
	,('4', '2014-04-01', '1', '4', '25000');
SELECT * FROM ORDERS;	

# [MYSQL]
# 예외 케이스: 아직 영업을 하지 못한 Mark, Amy
# -> 최종 query에서 이러한 영업원을 제외할 것이다.
SELECT NAME
FROM SALESPERSON
WHERE SALES_ID NOT IN (
	SELECT SALES_ID
	FROM ORDERS
	WHERE COM_ID IN (
		SELECT COM_ID
		FROM COMPANY
		WHERE NAME = 'RED'
	)
);		

