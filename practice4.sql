--Bài 1
SELECT
SUM(CASE
  WHEN device_type = 'laptop' THEN 1
  ELSE 0
  END) AS laptop_reviews,
SUM(CASE
  WHEN device_type IN ('tablet','phone')  THEN 1
  ELSE 0
  END) AS mobile_reviews
FROM viewership;
--Bài 2
SELECT *,
CASE 
    WHEN x+y>z AND y+z>x AND x+z>Y THEN 'Yes'
    ELSE 'No'
END AS triangle
FROM Triangle;
--Bài 3
SELECT 
ROUND(100.0 * SUM(CASE 
WHEN call_category = 'n/a' OR call_category IS NULL then 1
ELSE 0
END) / COUNT(*),1) AS uncategorised_call_pct
FROM callers;
--Bài 4
SELECT name 
FROM customer 
WHERE referee_id !=2 OR referee_id IS NULL
--Bài 5
SELECT survived,
SUM(CASE 
    WHEN pclass = 1 THEN 1
    ELSE 0
END) AS first_class,
SUM(CASE 
    WHEN pclass = 2 THEN 1
    ELSE 0
END) AS second_class,
SUM(CASE 
    WHEN pclass = 3 THEN 1
    ELSE 0
END) AS third_class
from titanic
GROUP BY survived;
