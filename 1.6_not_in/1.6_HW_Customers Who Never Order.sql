/*
https://leetcode.com/problems/customers-who-never-order/ 

Table: Customers
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
id is the primary key column for this table.
Each row of this table indicates the ID and name of a customer.
 
Table: Orders
+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| customerId  | int  |
+-------------+------+
id is the primary key column for this table.
customerId is a foreign key of the ID from the Customers table.
Each row of this table indicates the ID of an order and the ID of the customer who ordered it.
 
Write an SQL query to report all customers who never order anything.
Return the result table in any order.

The query result format is in the following example.
Example 1:
Input: 
Customers table:
+----+-------+
| id | name  |
+----+-------+
| 1  | Joe   |
| 2  | Henry |
| 3  | Sam   |
| 4  | Max   |
+----+-------+
Orders table:
+----+------------+
| id | customerId |
+----+------------+
| 1  | 3          |
| 2  | 1          |
+----+------------+
Output: 
+-----------+
| Customers |
+-----------+
| Henry     |
| Max       |
+-----------+
*/

# [SETTING]
USE PRACTICE;
DROP TABLE CUSTOMERS;
CREATE TABLE CUSTOMERS (ID INT, NAME VARCHAR(255));
INSERT INTO
	CUSTOMERS (ID, NAME)
VALUES
	('1', 'JOE')
	,('2', 'HENRY')
	,('3', 'SAM')
	,('4', 'MAX');
SELECT * FROM CUSTOMERS;

# [SETTING]
USE PRACTICE;
DROP TABLE ORDERS;
CREATE TABLE ORDERS (ID INT, CUSTOMERID INT);
INSERT INTO
	ORDERS (ID, CUSTOMERID)
VALUES
	('1', '3')
	,('2', '1');
SELECT * FROM ORDERS;

# [KEY]
# 'all customers who NEVER order anything': 여집합의 not in 고려

# [MYSQL]
SELECT NAME AS CUSTOMERS
FROM CUSTOMERS
WHERE ID NOT IN (
	SELECT CUSTOMERID 
	FROM ORDERS
);
