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
SELECT page_id FROM pages AS a
JOIN (SELECT page_id, liked_date FROM page_likes
WHERE liked_date IS NULL) AS b
ON a.page_id=b.page_id

--Bài 5
