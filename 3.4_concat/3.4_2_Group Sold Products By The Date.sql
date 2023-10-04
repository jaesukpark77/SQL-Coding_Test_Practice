/*
https://leetcode.com/problems/group-sold-products-by-the-date/ 

Table Activities:
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| sell_date   | date    |
| product     | varchar |
+-------------+---------+
There is no primary key for this table, it may contain duplicates.
Each row of this table contains the product name and the date it was sold in a market.
 
Write an SQL query to find for each date the number of different products sold and their names.
The sold products names for each date should be sorted lexicographically.
Return the result table ordered by sell_date.

The query result format is in the following example.
Example 1:
Input: 
Activities table:
+------------+------------+
| sell_date  | product     |
+------------+------------+
| 2020-05-30 | Headphone  |
| 2020-06-01 | Pencil     |
| 2020-06-02 | Mask       |
| 2020-05-30 | Basketball |
| 2020-06-01 | Bible      |
| 2020-06-02 | Mask       |
| 2020-05-30 | T-Shirt    |
+------------+------------+
Output: 
+------------+----------+------------------------------+
| sell_date  | num_sold | products                     |
+------------+----------+------------------------------+
| 2020-05-30 | 3        | Basketball,Headphone,T-shirt |
| 2020-06-01 | 2        | Bible,Pencil                 |
| 2020-06-02 | 1        | Mask                         |
+------------+----------+------------------------------+
Explanation: 
For 2020-05-30, Sold items were (Headphone, Basketball, T-shirt), we sort them lexicographically and separate them by a comma.
For 2020-06-01, Sold items were (Pencil, Bible), we sort them lexicographically and separate them by a comma.
For 2020-06-02, the Sold item is (Mask), we just return it.
*/

# [SETTING]
USE PRACTICE;
DROP TABLE Activities;
CREATE TABLE Activities (sell_date date, product varchar(20));
INSERT INTO
	Activities (sell_date, product)
VALUES
('2020-05-30', 'Headphone')
,('2020-06-01', 'Pencil')
,('2020-06-02', 'Mask')
,('2020-05-30', 'Basketball')
,('2020-06-01', 'Bible')
,('2020-06-02', 'Mask')
,('2020-05-30', 'T-Shirt');
SELECT * FROM Activities;

# [KEY]
# group_concat: group by 컬럼 기준으로 값들을 이어준다. 값들은 자동으로 쉼표(,)로 구분한다.

# [MYSQL]
select sell_date,
count(distinct product) as num_sold,
GROUP_CONCAT(distinct product ORDER BY product ASC) products
from Activities
group by sell_date;