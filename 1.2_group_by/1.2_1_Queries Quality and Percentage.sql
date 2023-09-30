/*
https://leetcode.com/problems/queries-quality-and-percentage/ 

Table: Queries
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| query_name  | varchar |
| result      | varchar |
| position    | int     |
| rating      | int     |
+-------------+---------+
There is no primary key for this table, it may have duplicate rows.
This table contains information collected from some queries on a database.
The position column has a value from 1 to 500.
The rating column has a value from 1 to 5. Query with rating less than 3 is a poor query.
 
We define query quality as:
The average of the ratio between query rating and its position.
We also define poor query percentage as:
The percentage of all queries with rating less than 3.

Write an SQL query to find each query_name, the quality and poor_query_percentage.
Both quality and poor_query_percentage should be rounded to 2 decimal places.
Return the result table in any order.

The query result format is in the following example.
Example 1:
Input: 
Queries table:
+------------+-------------------+----------+--------+
| query_name | result            | position | rating |
+------------+-------------------+----------+--------+
| Dog        | Golden Retriever  | 1        | 5      |
| Dog        | German Shepherd   | 2        | 5      |
| Dog        | Mule              | 200      | 1      |
| Cat        | Shirazi           | 5        | 2      |
| Cat        | Siamese           | 3        | 3      |
| Cat        | Sphynx            | 7        | 4      |
+------------+-------------------+----------+--------+
Output: 
+------------+---------+-----------------------+
| query_name | quality | poor_query_percentage |
+------------+---------+-----------------------+
| Dog        | 2.50    | 33.33                 |
| Cat        | 0.66    | 33.33                 |
+------------+---------+-----------------------+
Explanation: 
Dog queries quality is ((5 / 1) + (5 / 2) + (1 / 200)) / 3 = 2.50
Dog queries poor_ query_percentage is (1 / 3) * 100 = 33.33

Cat queries quality equals ((2 / 5) + (3 / 3) + (4 / 7)) / 3 = 0.66
Cat queries poor_ query_percentage is (1 / 3) * 100 = 33.33
*/

# [SETTING]
USE PRACTICE;
DROP TABLE Queries;
CREATE TABLE Queries (query_name varchar(30), result varchar(50), position int, rating int);
INSERT INTO
	Queries (query_name, result, position, rating)
VALUES
('Dog', 'Golden Retriever', '1', '5')
,('Dog', 'German Shepherd', '2', '5')
,('Dog', 'Mule', '200', '1')
,('Cat', 'Shirazi', '5', '2')
,('Cat', 'Siamese', '3', '3')
,('Cat', 'Sphynx', '7', '4');
SELECT * FROM Queries;

# [KEY]
# case when과 함께 group by 사용하면 매우 유용!
# (참고) case when을 count로도 사용 가능(count(case when rating < 3 then 1 end)/count(*)) -> Easy 섹션에서 다시 다룰 예정!
# round: 소수점 몇 자리 수 기준으로 반올림

# [MYSQL]
select query_name,
round(avg(rating/position), 2) quality,
round(sum(case when rating < 3 then 1 else 0 end)/count(*)*100, 2) poor_query_percentage
from queries
group by query_name;