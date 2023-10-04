/*
Several friends at a cinema ticket office would like to reserve consecutive available seats.
Can you help to query all the consecutive available seats order by the seat_id using the following cinema table?
| seat_id | free |
|---------|------|
| 1       | 1    |
| 2       | 0    |
| 3       | 1    |
| 4       | 1    |
| 5       | 1    |

Your query should return the following result for the sample case above.

| seat_id |
|---------|
| 3       |
| 4       |
| 5       |

Note:
The seat_id is an auto increment int, and free is bool (1 means free, and 0 means occupied.).
Consecutive available seats are more than 2(inclusive) seats consecutively available.
*/

# [SETTING]
USE PRACTICE;
DROP TABLE SEATS;
CREATE TABLE SEATS (SEAT_ID INT, FREE INT);
INSERT INTO
	SEATS (SEAT_ID, FREE)
VALUES
	('1', '1')
	,('2', '0')
	,('3', '1')
	,('4', '1')
	,('5', '1');
SELECT * FROM SEATS;

# [KEY]
# 'consecutive': (1) 이전 좌석과 지금 좌석 비교, (2) 지금 좌석과 이후 좌석 비교

# [PRACTICE]
SELECT SEAT_ID,
LAG(FREE) OVER (ORDER BY SEAT_ID) PREV_FREE,
FREE,
LEAD(FREE) OVER (ORDER BY SEAT_ID) POST_FREE
FROM SEATS
ORDER BY SEAT_ID;

# [MYSQL]
SELECT SEAT_ID
FROM
(
	SELECT SEAT_ID,
	LAG(FREE) OVER (ORDER BY SEAT_ID) PREV_FREE,
    FREE,
    LEAD(FREE) OVER (ORDER BY SEAT_ID) POST_FREE
	FROM SEATS
) S
WHERE (PREV_FREE=1 AND FREE=1) OR (FREE=1 AND POST_FREE=1);