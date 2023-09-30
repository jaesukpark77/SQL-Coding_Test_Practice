/*
https://leetcode.com/problems/find-customer-referee/

Table: Customer
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| referee_id  | int     |
+-------------+---------+
id is the primary key column for this table.
Each row of this table indicates the id of a customer, their name, and the id of the customer who referred them.
 
Write an SQL query to report the names of the customer that are not referred by the customer with id = 2.
Return the result table in any order.

The query result format is in the following example.
Example 1:
Input: 
Customer table:
+----+------+------------+
| id | name | referee_id |
+----+------+------------+
| 1  | Will | null       |
| 2  | Jane | null       |
| 3  | Alex | 2          |
| 4  | Bill | null       |
| 5  | Zack | 1          |
| 6  | Mark | 2          |
+----+------+------------+
Output: 
+------+
| name |
+------+
| Will |
| Jane |
| Bill |
| Zack |
+------+
*/

# [SETTING]
USE PRACTICE;
DROP TABLE CUSTOMER;
CREATE TABLE CUSTOMER (ID INT, NAME VARCHAR(255), REFEREE_ID INT);
INSERT INTO
	 CUSTOMER (ID, NAME, REFEREE_ID)
VALUES
('1', 'WILL', NULL)
,('2', 'JANE', NULL)
,('3', 'ALEX', '2')
,('4', 'BILL', NULL)
,('5', 'ZACK', '1')
,('6', 'MARK', '2');
SELECT * FROM CUSTOMER;

# [KEY]
# 'that are NOT referred by the customer with id = 2': 여집합의 not in 고려

# [WRONG - CHECK IN LEETCODE]
# null 값은 포함하지 않는다.
SELECT NAME
FROM CUSTOMER
WHERE REFEREE_ID != '2';

# [MYSQL1]
# 하지만 추가 예외 사항(referee_id가 null일 때)를 따로 고려해야되서, 비추
SELECT NAME
FROM CUSTOMER
WHERE REFEREE_ID != '2' OR REFEREE_ID IS NULL;

# [MYSQL2]
# 방법1보다 명확
SELECT NAME
FROM CUSTOMER
WHERE ID NOT IN (SELECT ID 
				FROM CUSTOMER 
				WHERE REFEREE_ID ='2');