--Bài 1
SELECT COUNTRY.Continent AS name,
FLOOR(AVG(CITY.Population)) as avg_pop
FROM city
INNER JOIN country 
ON CITY.CountryCode=COUNTRY.Code
GROUP BY COUNTRY.Continent
--Bài 2
SELECT 
ROUND(AVG(CASE
  WHEN texts.signup_action = 'Confirmed' THEN 1
  ELSE 0
END),2) AS confirm_rate
FROM emails 
INNER JOIN texts 
ON emails.email_id=texts.email_id
--Bài 3
SELECT b.age_bucket,
ROUND(SUM(CASE
WHEN activity_type='send' then a.time_spent
ELSE 0 END)
/SUM(CASE
WHEN activity_type IN ('open','send') then a.time_spent
ELSE 0 END)*100.0,2) AS sending,
ROUND(SUM(CASE
WHEN activity_type='open' then a.time_spent
ELSE 0 END)
/SUM(CASE
WHEN activity_type IN ('open','send') then a.time_spent
ELSE 0 END)*100.0,2) AS opening
FROM activities AS a 
JOIN age_breakdown AS b 
ON a.user_id=b.user_id
GROUP BY b.age_bucket
--Bài 4
SELECT a.customer_id
FROM customer_contracts AS a 
JOIN products AS b 
ON a.product_id=b.product_id
GROUP BY a.customer_id
HAVING count(DISTINCT product_category)=(select count(DISTINCT product_category) from products)
--Bài 5
SELECT mng.employee_id, mng.name,
COUNT(emp.reports_to) AS reports_count,
ROUND(AVG(emp.age),0) AS average_age
FROM employees as mng
JOIN employees as emp
ON mng.employee_id =emp.reports_to 
GROUP BY mng.employee_id
ORDER BY mng.employee_id
--Bài 6
SELECT a.product_name,
SUM(b.unit) AS unit
FROM products AS a
JOIN orders AS b
ON a.product_id=b.product_id
WHERE b.order_date BETWEEN '2020-02-01' AND '2020-02-29'
GROUP BY a.product_id
HAVING SUM(b.unit)>=100
--Bài 7
SELECT a.page_id
FROM pages AS a LEFT JOIN page_likes AS b 
ON a.page_id=b.page_id
WHERE b.page_id IS NULL
GROUP BY a.page_id
ORDER BY a.page_id ASC
