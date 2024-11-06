--bài 1
SELECT name
FROM students
WHERE marks>75 
ORDER BY RIGHT(name,3), id
--bài 2
SELECT user_id, 
CONCAT(UPPER(LEFT(name,1)),LOWER(RIGHT(name, length(name)-1))) as name
FROM users
ORDER BY user_id
--bài 3
SELECT manufacturer,
'$' || ROUND((SUM(total_sales)/1000000),0) ||' '||'million' AS sale
FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY SUM(total_sales) DESC, manufacturer;
--bài 4
SELECT
EXTRACT(MONTH FROM submit_date) as mth,
product_id as product,
ROUND(AVG(stars),2) AS avg_stars
FROM reviews
GROUP BY product_id, EXTRACT(MONTH FROM submit_date)
ORDER BY mth, product_id
--bài 5
SELECT
sender_id,
COUNT(DISTINCT message_id) as message_count
FROM messages
WHERE EXTRACT(MONTH FROM sent_date) = 8 
AND EXTRACT(YEAR FROM sent_date) = 2022
GROUP BY sender_id
ORDER BY COUNT(message_id) DESC
LIMIT 2
--bài 6
SELECT
tweet_id FROM tweets
WHERE length(content)>15
--bài 7
SELECT 
activity_date AS day, 
COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE activity_date BETWEEN '2019-06-28' AND '2019-07-27'
GROUP BY activity_date 
--bài 8
select 
count(id) as number_employees
from employees
Where EXTRACT(month FROM joining_date) BETWEEN 1 and 7 and
EXTRACT(year FROM joining_date) = 2022;
--bài 9
select
POSITION('a' IN 'Amitah') AS position
from worker
where first_name = 'Amitah';
--bài 10
select title,
Substring(title, length(winery) + 2, 4)
from winemag_p2
WHERE country = 'Macedonia';
