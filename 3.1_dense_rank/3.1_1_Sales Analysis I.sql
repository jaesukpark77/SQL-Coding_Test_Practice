/*
Table: Product
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| product_id   | int     |
| product_name | varchar |
| unit_price   | int     |
+--------------+---------+
product_id is the primary key of this table.

Table: Sales
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| seller_id   | int     |
| product_id  | int     |
| buyer_id    | int     |
| sale_date   | date    |
| quantity    | int     |
| price       | int     |
+------ ------+---------+
This table has no primary key, it can have repeated rows.
product_id is a foreign key to Product table.

Write an SQL query that reports the best seller by total sales price, If there is a tie, report them all.

The query result format is in the following example:
Product table:
+------------+--------------+------------+
| product_id | product_name | unit_price |
+------------+--------------+------------+
| 1          | S8           | 1000       |
| 2          | G4           | 800        |
| 3          | iPhone       | 1400       |
+------------+--------------+------------+
Sales table:
+-----------+------------+----------+------------+----------+-------+
| seller_id | product_id | buyer_id | sale_date  | quantity | price |
+-----------+------------+----------+------------+----------+-------+
| 1         | 1          | 1        | 2019-01-21 | 2        | 2000  |
| 1         | 2          | 2        | 2019-02-17 | 1        | 800   |
| 2         | 2          | 3        | 2019-06-02 | 1        | 800   |
| 3         | 3          | 4        | 2019-05-13 | 2        | 2800  |
+-----------+------------+----------+------------+----------+-------+
Result table:
+-------------+
| seller_id   |
+-------------+
| 1           |
| 3           |
+-------------+
Both sellers with id 1 and 3 sold products with the most total price of 2800.
*/

# [SETTING]
USE PRACTICE;
DROP TABLE SALES;
CREATE TABLE SALES (SELLER_ID INT, PRODUCT_ID INT, BUYER_ID INT, SALE_DATE DATE, QUANTITY INT, PRICE INT);
INSERT INTO
	SALES (SELLER_ID, PRODUCT_ID, BUYER_ID, SALE_DATE, QUANTITY, PRICE)
VALUES
	('1', '1', '1', '2019-01-21', '2', '2000')
	,('1', '2', '2', '2019-01-17', '1', '800')
	,('2', '2', '3', '2019-01-02', '1', '800')
	,('3', '3', '4', '2019-01-13', '2', '2800');
SELECT * FROM SALES;	    
        
# [SETTING]
USE PRACTICE;
DROP TABLE PRODUCT;
CREATE TABLE PRODUCT (PRODUCT_ID INT, PRODUCT_NAME VARCHAR(255), UNIT_PRICE INT);
INSERT INTO
	PRODUCT (PRODUCT_ID, PRODUCT_NAME, UNIT_PRICE)
VALUES
	('1', 'S8', '1000')
	,('2', 'G4', '800')
	,('3', 'IPHONE','1400');
SELECT * FROM PRODUCT;

# [PRACTICE]
# rank, dense_rank, row_number 차이점 확인하기!
SELECT SELLER_ID,
TOT_PRICE,
RANK() OVER (ORDER BY TOT_PRICE DESC) RK,
DENSE_RANK() OVER (ORDER BY TOT_PRICE DESC)  DRK,
ROW_NUMBER() OVER (ORDER BY TOT_PRICE DESC) AS RN
FROM
(
	SELECT SELLER_ID,
	SUM(PRICE) TOT_PRICE
	FROM SALES
	GROUP BY SELLER_ID
) A
ORDER BY TOT_PRICE DESC;
    
# [MYSQL]
SELECT SELLER_ID,
TOT_PRICE
FROM
(
	SELECT SELLER_ID,
	TOT_PRICE,
	RANK() OVER (ORDER BY TOT_PRICE DESC) RK,
	DENSE_RANK() OVER (ORDER BY TOT_PRICE DESC)  DRK
	FROM
	(
		SELECT SELLER_ID,
		SUM(PRICE) TOT_PRICE
		FROM SALES
		GROUP BY SELLER_ID
	) A
) B
WHERE DRK=1; #RK=1도 정답