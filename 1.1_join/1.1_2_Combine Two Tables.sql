/*
https://leetcode.com/problems/combine-two-tables/ 

Table: Person
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| personId    | int     |
| lastName    | varchar |
| firstName   | varchar |
+-------------+---------+
personId is the primary key column for this table.
This table contains information about the ID of some persons and their first and last names.
 
Table: Address
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| addressId   | int     |
| personId    | int     |
| city        | varchar |
| state       | varchar |
+-------------+---------+
addressId is the primary key column for this table.
Each row of this table contains information about the city and state of one person with ID = PersonId.
 
Write an SQL query to report the first name, last name, city, and state of each person in the Person table.
If the address of a personId is not present in the Address table, report null instead.
Return the result table in any order.

The query result format is in the following example.
Example 1:
Input: 
Person table:
+----------+----------+-----------+
| personId | lastName | firstName |
+----------+----------+-----------+
| 1        | Wang     | Allen     |
| 2        | Alice    | Bob       |
+----------+----------+-----------+
Address table:
+-----------+----------+---------------+------------+
| addressId | personId | city          | state      |
+-----------+----------+---------------+------------+
| 1         | 2        | New York City | New York   |
| 2         | 3        | Leetcode      | California |
+-----------+----------+---------------+------------+
Output: 
+-----------+----------+---------------+----------+
| firstName | lastName | city          | state    |
+-----------+----------+---------------+----------+
| Allen     | Wang     | Null          | Null     |
| Bob       | Alice    | New York City | New York |
+-----------+----------+---------------+----------+
Explanation: 
There is no address in the address table for the personId = 1 so we return null in their city and state.
addressId = 1 contains information about the address of personId = 2.
*/

# [SETTING]
USE PRACTICE;
DROP TABLE PERSON;
CREATE TABLE PERSON (PERSONID INT, FIRSTNAME VARCHAR(255), LASTNAME VARCHAR(255));
INSERT INTO
	PERSON (PERSONID, LASTNAME, FIRSTNAME)
VALUES
	('1', 'WANG', 'ALLEN');
SELECT * FROM PERSON;

# [SETTING]
USE PRACTICE;
DROP TABLE ADDRESS;
CREATE TABLE ADDRESS (ADDRESSID INT, PERSONID INT, CITY VARCHAR(255), STATE VARCHAR(255));
INSERT INTO
	ADDRESS (ADDRESSID, PERSONID, CITY, STATE)
VALUES
	('1', '2', 'NEW YORK CITY', 'NEW YORK');
SELECT * FROM ADDRESS;

# [KEY]
# 'If the address of a personId is not present in the Address table, report null instead.'
# -> inner join이 아니라, left outer join 필요

# [PRACTICE]
SELECT *
FROM PERSON P
LEFT OUTER JOIN ADDRESS A
ON P.PERSONID = A.PERSONID;

# [MYSQL]
SELECT P.FIRSTNAME, 
       P.LASTNAME, 
       A.CITY, 
       A.STATE
FROM PERSON P
LEFT OUTER JOIN ADDRESS A
ON P.PERSONID = A.PERSONID;