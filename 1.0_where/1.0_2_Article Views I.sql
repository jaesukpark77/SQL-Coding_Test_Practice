/*
https://leetcode.com/problems/article-views-i/ 

Table: Views
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| article_id    | int     |
| author_id     | int     |
| viewer_id     | int     |
| view_date     | date    |
+---------------+---------+
There is no primary key for this table, it may have duplicate rows.
Each row of this table indicates that some viewer viewed an article (written by some author) on some date. 
Note that equal author_id and viewer_id indicate the same person.

Write an SQL query to find all the authors that viewed at least one of their own articles.
Return the result table sorted by id in ascending order.

The query result format is in the following example.
Example 1:
Input: 
Views table:
+------------+-----------+-----------+------------+
| article_id | author_id | viewer_id | view_date  |
+------------+-----------+-----------+------------+
| 1          | 3         | 5         | 2019-08-01 |
| 1          | 3         | 6         | 2019-08-02 |
| 2          | 7         | 7         | 2019-08-01 |
| 2          | 7         | 6         | 2019-08-02 |
| 4          | 7         | 1         | 2019-07-22 |
| 3          | 4         | 4         | 2019-07-21 |
| 3          | 4         | 4         | 2019-07-21 |
+------------+-----------+-----------+------------+
Output: 
+------+
| id   |
+------+
| 4    |
| 7    |
+------+
*/

# [SETTING]
USE PRACTICE;
DROP TABLE VIEWS;
CREATE TABLE VIEWS (ARTICLE_ID INT, AUTHOR_ID INT, VIEWER_ID INT, VIEW_DATE DATE);
INSERT INTO
	VIEWS (ARTICLE_ID, AUTHOR_ID, VIEWER_ID , VIEW_DATE)
VALUES
	('1', '3', '5', '2019-08-01')
	,('1', '3', '6', '2019-08-02')
	,('2', '7', '7', '2019-08-01')
	,('2', '7', '6', '2019-08-02')
	,('4', '7', '1', '2019-07-22')
	,('3', '4', '4', '2019-07-21')
	,('3', '4', '4', '2019-07-21');	    
SELECT * FROM VIEWS;

# [KEY]
# 'There is no primary key for this table, it may have duplicate rows.' : distinct 처리 필요
# Primary Key(=PK): 중복되어 나타날 수 없는 단일 값(unique) (e.g. 우리나라 국민의 주민등록번호)

# [WRONG - CHECK FROM LEETCODE]
SELECT AUTHOR_ID AS ID 
FROM VIEWS
WHERE AUTHOR_ID = VIEWER_ID
ORDER BY AUTHOR_ID;

# [MYSQL] 
SELECT DISTINCT(AUTHOR_ID) AS ID
FROM VIEWS
WHERE AUTHOR_ID = VIEWER_ID
ORDER BY AUTHOR_ID;