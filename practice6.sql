--Bài 1
WITH twt_duplicate AS
(SELECT company_id, title, description, 
COUNT(*) FROM job_listings
GROUP BY company_id, title, description 
HAVING COUNT(*) > 1)
SELECT COUNT(*) AS duplicate_companies FROM twt_duplicate;

--Bài 2
WITH ranking AS(
SELECT category, product, SUM(spend) AS total_spend,
RANK () OVER(PARTITION BY category ORDER BY category, SUM(spend) DESC) AS rank
FROM product_spend
WHERE EXTRACT (YEAR FROM transaction_date) ='2022'
GROUP BY category,  product)

SELECT category, product, total_spend
FROM ranking 
WHERE rank <=2

/* Lưu ý
- PARTITION: phân vùng dữ liệu theo nhóm và vẫn giữ nguyên dòng dữ liệu cũ
- GROUP BY: nhóm các dữ liệu giống nhau và tính toán như AVG, SUM */

--Bài 3
WITH count_holder AS(
SELECT policy_holder_id, COUNT(case_id) 
FROM callers
GROUP BY policy_holder_id
HAVING COUNT(*)>=3)

SELECT COUNT (policy_holder_id) AS policy_holder_count
FROM count_holder 

--Bài 4
SELECT a.page_id
FROM pages AS a
LEFT JOIN page_likes AS b
  ON a.page_id = b.page_id
WHERE b.page_id IS NULL;

--Bài 5:
WITH count_user AS 
(SELECT  user_id	
FROM user_actions 
WHERE EXTRACT(MONTH FROM event_date) in (6,7) 
AND EXTRACT(YEAR FROM event_date) = 2022 
GROUP BY user_id 
HAVING COUNT(DISTINCT EXTRACT(MONTH FROM event_date)) = 2)

SELECT 7 AS month_ , COUNT(*) AS number_of_user 
FROM count_user;

--Bài 6
WITH tran_count AS(
SELECT 
DATE_FORMAT(trans_date, '%Y-%m') AS month,
country,
COUNT(*) AS trans_count,
SUM(amount) AS trans_total_amount
FROM Transactions
GROUP BY month, country)
,
approved_count AS(
SELECT 
DATE_FORMAT(trans_date, '%Y-%m') AS month,
country,
COUNT(*) AS approved_count,
SUM(amount) AS approved_total_amount
FROM Transactions
WHERE state ='approved'
GROUP BY month, country)

SELECT a.month, a.country, a.trans_count, b.approved_count, 
a.trans_total_amount,
b.approved_total_amount
FROM tran_count AS a
LEFT JOIN approved_count AS b
ON a.month=b.month AND a.country=b.country

--Bài 7
WITH no_of_year AS(
SELECT product_id, year, quantity, price,
RANK () OVER (PARTITION BY product_id ORDER BY year) AS year_number
FROM sales)

SELECT product_id, year AS first_year, quantity, price
FROM no_of_year
WHERE year_number = 1

--Bài 8
SELECT customer_id
FROM customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (SELECT count(product_key) FROM product)


--Bài 9
SELECT employee_id
FROM Employees
WHERE salary < 30000
AND manager_id NOT IN (SELECT employee_id FROM employees)
ORDER BY employee_id ASC

--Bài 10
WITH twt_duplicate AS
(SELECT company_id, title, description, 
COUNT(*) FROM job_listings
GROUP BY company_id, title, description 
HAVING COUNT(*) > 1)
SELECT COUNT(*) AS duplicate_companies FROM twt_duplicate;

--Bài 11
WITH gr_user AS
(SELECT u.name FROM users AS u
JOIN MovieRating as mr
ON u.user_id=mr.user_id
GROUP BY u.user_id
ORDER BY COUNT(*) DESC, u.name ASC
LIMIT 1)
,
gr_movie AS (
SELECT m.title FROM movies AS m
JOIN MovieRating AS mr
ON m.movie_id=mr.movie_id
WHERE month(created_at) = 2
GROUP BY m.movie_id
ORDER BY AVG(rating) DESC, m.title ASC
LIMIT 1)

SELECT name AS results FROM gr_user
UNION ALL
SELECT title AS results FROM gr_movie


--Bài 12
WITH ids AS (
    SELECT accepter_id AS id
    FROM RequestAccepted
    UNION ALL
    SELECT requester_id AS id
    FROM RequestAccepted)
  
SELECT id,COUNT(id) AS num
FROM ids
GROUP BY id
ORDER BY COUNT(id) DESC
LIMIT 1

















