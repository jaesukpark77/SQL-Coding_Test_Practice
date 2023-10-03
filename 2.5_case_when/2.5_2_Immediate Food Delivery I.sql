/*
Table: Delivery
+-----------------------------+---------+
| Column Name                 | Type    |
+-----------------------------+---------+
| delivery_id                 | int     |
| customer_id                 | int     |
| order_date                  | date    |
| customer_pref_delivery_date | date    |
+-----------------------------+---------+
delivery_id is the primary key of this table.
The table holds information about food delivery to customers that make orders at some date 
and specify a preferred delivery date (on the same order date or after it).

If the preferred delivery date of the customer is the same as the order date then the order is called immediate
otherwise it called scheduled.

Write an SQL query to find the percentage of "immediate" orders in the table, rounded to 2 decimal places.

The query result format is in the following example:

Delivery table:

+-------------+-------------+------------+-----------------------------+
| delivery_id | customer_id | order_date | customer_pref_delivery_date |
+-------------+-------------+------------+-----------------------------+
| 1           | 1           | 2019-08-01 | 2019-08-02                  |
| 2           | 5           | 2019-08-02 | 2019-08-02                  |
| 3           | 1           | 2019-08-11 | 2019-08-11                  |
| 4           | 3           | 2019-08-24 | 2019-08-26                  |
| 5           | 4           | 2019-08-21 | 2019-08-22                  |
| 6           | 2           | 2019-08-11 | 2019-08-13                  |
+-------------+-------------+------------+-----------------------------+
Result table:

+----------------------+
| immediate_percentage |
+----------------------+
| 33.33                |
+----------------------+
The orders with delivery id 2 and 3 are immediate while the others are scheduled.*/

# [SETTING]
USE PRACTICE;
DROP TABLE DELIVERY;
CREATE TABLE DELIVERY (DELIVERY_ID INT, CUSTOMER_ID INT, ORDER_DATE DATE, CUSTOMER_PREF_DELIVERY_DATE DATE);
INSERT INTO
	DELIVERY (DELIVERY_ID, CUSTOMER_ID, ORDER_DATE, CUSTOMER_PREF_DELIVERY_DATE)
VALUES
	('1', '1', '2019-08-01', '2019-08-02')
	,('2', '5', '2019-08-02', '2019-08-02')
	,('3', '1', '2019-08-11', '2019-08-11')
	,('4', '3', '2019-08-24', '2019-08-26')
	,('5', '4', '2019-08-21', '2019-08-22')
	,('6', '2', '2019-08-11', '2019-08-13');
SELECT * FROM DELIVERY;

# [MYSQL1]
SELECT ROUND(
	(SUM(CASE WHEN D.ORDER_DATE = D.CUSTOMER_PREF_DELIVERY_DATE THEN 1 ELSE 0 END)/ COUNT(*))
, 2) IMMEDIATE_PERCENTAGE
FROM DELIVERY D;

# [MYSQL2]
# 참고: https://stackoverflow.com/questions/40101963/can-we-write-case-statement-without-having-else-statement
# -> 집계 함수는 null을 무시한다.
SELECT ROUND(
	(COUNT(CASE WHEN D.ORDER_DATE = D.CUSTOMER_PREF_DELIVERY_DATE THEN 1 END)/ COUNT(*)) # ELSE는 자동으로 null로 취급 -> null은 집계에 포함이 안된다.
, 2) IMMEDIATE_PERCENTAGE
FROM DELIVERY D;

# [WRONG]
# COUNT 쓸 때 ELSE 0을 써버리면, 0으로 나온 row에 대해서도 COUNT에 포함되기 때문에, 걸국 전체 개수 COUNT(*)와 의미가 같아진다.
SELECT ROUND(
	(COUNT(CASE WHEN D.ORDER_DATE = D.CUSTOMER_PREF_DELIVERY_DATE THEN 1 ELSE 0 END)/ COUNT(*))
, 2) IMMEDIATE_PERCENTAGE
FROM DELIVERY D;