/*
https://leetcode.com/problems/top-travellers/ 

Table: Users
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| name          | varchar |
+---------------+---------+
id is the primary key for this table.
name is the name of the user.
 
Table: Rides
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| user_id       | int     |
| distance      | int     |
+---------------+---------+
id is the primary key for this table.
user_id is the id of the user who traveled the distance "distance".
 
Write an SQL query to report the distance traveled by each user.
Return the result table ordered by travelled_distance in descending order, if two or more users traveled the same distance, order them by their name in ascending order.

The query result format is in the following example.
Example 1:
Input: 
Users table:
+------+-----------+
| id   | name      |
+------+-----------+
| 1    | Alice     |
| 2    | Bob       |
| 3    | Alex      |
| 4    | Donald    |
| 7    | Lee       |
| 13   | Jonathan  |
| 19   | Elvis     |
+------+-----------+
Rides table:
+------+----------+----------+
| id   | user_id  | distance |
+------+----------+----------+
| 1    | 1        | 120      |
| 2    | 2        | 317      |
| 3    | 3        | 222      |
| 4    | 7        | 100      |
| 5    | 13       | 312      |
| 6    | 19       | 50       |
| 7    | 7        | 120      |
| 8    | 19       | 400      |
| 9    | 7        | 230      |
+------+----------+----------+
Output: 
+----------+--------------------+
| name     | travelled_distance |
+----------+--------------------+
| Elvis    | 450                |
| Lee      | 450                |
| Bob      | 317                |
| Jonathan | 312                |
| Alex     | 222                |
| Alice    | 120                |
| Donald   | 0                  |
+----------+--------------------+
Explanation: 
Elvis and Lee traveled 450 miles, Elvis is the top traveler as his name is alphabetically smaller than Lee.
Bob, Jonathan, Alex, and Alice have only one ride and we just order them by the total distances of the ride.
Donald did not have any rides, the distance traveled by him is 0.
*/

# [SETTING]
USE PRACTICE;
DROP TABLE Users;
CREATE TABLE Users (id int, name varchar(30));
INSERT INTO
	Users (id, name)
VALUES
('1', 'Alice')
,('2', 'Bob')
,('3', 'Alex')
,('4', 'Donald')
,('7', 'Lee')
,('13', 'Jonathan')
,('19', 'Elvis');
SELECT * FROM Users;

# [SETTING]
USE PRACTICE;
DROP TABLE Rides;
CREATE TABLE Rides (id int, user_id int, distance int);
INSERT INTO
	Rides (id, user_id, distance)
VALUES
('1', '1', '120')
,('2', '2', '317')
,('3', '3', '222')
,('4', '7', '100')
,('5', '13', '312')
,('6', '19', '50')
,('7', '7', '120')
,('8', '19', '400')
,('9', '7', '230');
SELECT * FROM Rides;

# [PRACTICE]
select *
from Users u
left outer join Rides r
on u.id=r.user_id;

# count: ifnull을 사용하지 않으면, count는 0으로 나온다 (말 그대로 개수가 0개 이기 때문에)
# 비교: https://leetcode.com/problems/students-and-examinations/
select max(u.name) name,
count(r.distance) as test1, # 결과: [Donald] count=0
count(u.id) as test2 # 결과: [Donald] count=1
from Users u
left outer join Rides r
on u.id=r.user_id
group by u.id;

# [MYSQL]
select u.name
, ifnull(sum(r.distance),0) as travelled_distance
#, sum(r.distance) as travelled_distance  # 결과: null -> 틀림!
from Users u
left outer join Rides r
on u.id=r.user_id
group by u.id, u.name # u.name만 쓰는 것은 비추천. 동명이인이 나올 수 있기 때문에
order by travelled_distance desc, name;