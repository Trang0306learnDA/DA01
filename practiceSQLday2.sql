--bài 1
SELECT DISTINCT city FROM station WHERE ID%2=0
--bài 2
SELECT COUNT(CITY) - COUNT(DISTINCT CITY) FROM station
-- bài 3

--bài 4
SELECT ROUND(CAST(SUM(item_count*order_occurrences)/SUM(order_occurrences) AS decimal),1) AS mean FROM items_per_order;
--bài 5
SELECT DISTINCT candidate_id 
FROM candidates
WHERE skill IN ('Python','Tableau','PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(skill)=3
--bài 6
SELECT user_id,
DATE(MAX(post_date)) - DATE(MIN(post_date)) AS days_between
FROM posts
WHERE post_date BETWEEN '2021-01-01' AND '2022-01-01'
GROUP BY user_id
HAVING COUNT(post_id) >=2
--bài 7
SELECT card_name,
MAX(issued_amount) - MIN(issued_amount) AS difference
FROM monthly_cards_issued
GROUP BY card_name
ORDER BY (MAX(issued_amount) - MIN(issued_amount)) DESC;
--bài 8
SELECT manufacturer, 
COUNT(drug) AS drug_count,
SUM(cogs - total_sales) AS total_loss
FROM pharmacy_sales
WHERE total_sales < cogs
GROUP BY manufacturer
ORDER BY total_loss DESC;
--bài 9
SELECT * 
FROM cinema
WHERE id%2 !=0 AND description != 'boring'
ORDER BY rating DESC
--bài 10
SELECT teacher_id,
COUNT(DISTINCT subject_id) as cnt
FROM teacher
GROUP BY teacher_id
--bài 11
SELECT user_id,
COUNT(follower_id) as followers_count 
FROM followers
GROUP BY user_id
ORDER BY user_id
--bài 12
SELECT class
FROM courses
GROUP BY class
HAVING COUNT(student) >=5
