
---Creating a table to know the date the a particular customer biught an item
DROP TABLE IF EXISTS GROUPED;
CREATE TABLE grouped AS(
SELECT
    userid,
    date(DATE_TRUNC('week', MIN(created))) AS first_purchase
    FROM
    orders
  GROUP BY userid
    ORDER BY 2);
--  SELECT * FROM  grouped;
         
-- creating a table to know the minimum date that they made the first purchase
DROP TABLE IF EXISTS purchase_day;
CREATE TABLE purchase_day AS(
    SELECT
    userid,
    date(DATE_TRUNC ('week', created )) AS min_week
    FROM
    orders
    GROUP BY userid, created);
    
--     SELECT * FROM  purchase_day;
  -- creating a table which shows the difference between the minimum date and purchase date
DROP TABLE IF EXISTS retention;
CREATE TABLE retention AS (
  SELECT
    g.userid,
    g.first_purchase,
    pd.min_week,
    (pd.min_week - g.first_purchase) / 7 AS week_diff
  FROM
    grouped AS g
    JOIN purchase_day AS pd
    ON g.userid = pd.userid
);
--     SELECT * FROM retention;

--viewing the weekly retention
SELECT first_purchase,
COUNT (DISTINCT CASE WHEN week_diff = 0 THEN userid END) AS week_0,
COUNT (DISTINCT CASE WHEN week_diff = 1 THEN userid END) AS week_1,
COUNT (DISTINCT CASE WHEN week_diff = 2 THEN userid END) AS week_2,
COUNT (DISTINCT CASE WHEN week_diff = 3 THEN userid END) AS week_3,
COUNT (DISTINCT CASE WHEN week_diff = 4 THEN userid END) AS week_4,
COUNT (DISTINCT CASE WHEN week_diff = 5 THEN userid END) AS week_5,
COUNT (DISTINCT CASE WHEN week_diff = 6 THEN userid END) AS week_6,
COUNT (DISTINCT CASE WHEN week_diff = 7 THEN userid END) AS week_7,
COUNT (DISTINCT CASE WHEN week_diff = 8 THEN userid END) AS week_8,
COUNT (DISTINCT CASE WHEN week_diff = 9 THEN userid END) AS week_9,
COUNT (DISTINCT CASE WHEN week_diff = 10 THEN userid END) AS week_10,
COUNT (DISTINCT CASE WHEN week_diff = 11 THEN userid END) AS week_11,
COUNT (DISTINCT CASE WHEN week_diff = 12 THEN userid END) AS week_12,
COUNT (DISTINCT CASE WHEN week_diff = 13 THEN userid END) AS week_13,
COUNT (DISTINCT CASE WHEN week_diff = 14 THEN userid END) AS week_14,
COUNT (DISTINCT CASE WHEN week_diff = 15 THEN userid END) AS week_15
FROM retention
GROUP BY first_purchase
ORDER BY 1;
-----------------------------------------------------