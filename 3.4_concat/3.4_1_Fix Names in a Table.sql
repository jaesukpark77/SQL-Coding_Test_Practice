/*
https://leetcode.com/problems/fix-names-in-a-table/ 

Table: Users
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| user_id        | int     |
| name           | varchar |
+----------------+---------+
user_id is the primary key for this table.
This table contains the ID and the name of the user. The name consists of only lowercase and uppercase characters.
 
Write an SQL query to fix the names so that only the first character is uppercase and the rest are lowercase.
Return the result table ordered by user_id.

The query result format is in the following example.
Example 1:
Input: 
Users table:
+---------+-------+
| user_id | name  |
+---------+-------+
| 1       | aLice |
| 2       | bOB   |
+---------+-------+
Output: 
+---------+-------+
| user_id | name  |
+---------+-------+
| 1       | Alice |
| 2       | Bob   |
+---------+-------+
*/

# [SETTING]
USE PRACTICE;
DROP TABLE Users;
CREATE TABLE Users (user_id int, name varchar(40));
INSERT INTO
	Users (user_id, name)
VALUES
('1', 'aLice')
,('2', 'bOB');
SELECT * FROM Users;

# [KEY]
# substr(string, start_index, length)
# 조심: 첫번째 문자의 start_index=1
# length를 안쓰면, start_index부터 끝까지 가져온다.

# [MYSQL]
select user_id,
CONCAT(UPPER(SUBSTR(name,1,1)),LOWER(SUBSTR(name,2))) name
from Users
order by user_id;
