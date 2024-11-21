--Bài 1
SELECT DISTINCT replacement_cost FROM film
ORDER BY replacement_cost;
--Bài 2
SELECT
CASE 
	WHEN replacement_cost BETWEEN 9.99 AND 19.99 THEN 'low'
	WHEN replacement_cost BETWEEN 20.00 AND 24.99 THEN 'medium'
	WHEN replacement_cost BETWEEN 25.00 AND 29.99 THEN 'high'
END AS category,
COUNT(*)
FROM film
GROUP BY category;
--Bài 3
SELECT a.title, a.length, c.name
FROM film AS a
JOIN film_category AS b
ON a.film_id=b.film_id
JOIN category AS c
ON b.category_id=c.category_id
WHERE c.name IN ('Drama', 'Sports')
ORDER BY LENGTH(c.name) DESC, a.length DESC;
--Bài 4
SELECT c.name,
COUNT(title)
FROM film AS a
JOIN film_category AS b
ON a.film_id=b.film_id
JOIN category AS c
ON b.category_id=c.category_id
GROUP BY c.name
ORDER BY COUNT(title) DESC;
--Bài 5
SELECT a.actor_id, a.first_name, a.last_name,
COUNT(b.film_id) 
FROM actor AS a 
JOIN film_actor AS b 
ON a.actor_id=b.actor_id
GROUP BY a.actor_id
ORDER BY COUNT(b.film_id) DESC;
--Bài 6
SELECT 
SUM(
CASE WHEN b.customer_id IS NULL THEN 1
	ELSE 0
END) AS add_count
FROM address AS a
LEFT JOIN customer AS b
ON a.address_id=b.address_id;
--Bài 7
SELECT a.city,
SUM(d.amount) 
FROM city AS a JOIN address AS b ON a.city_id=b.city_id
JOIN customer AS c ON b.address_id=c.address_id
JOIN payment AS d ON c.customer_id=d.customer_id
GROUP BY a.city
ORDER BY SUM(d.amount) DESC
--Bài 8
SELECT
a.city || ', '|| e.country AS name,
SUM(CASE 
WHEN a.city IS NOT NULL THEN amount
ELSE 0 END) AS total_amount
FROM city AS a JOIN address AS b ON a.city_id=b.city_id
JOIN customer AS c ON b.address_id=c.address_id
JOIN payment AS d ON c.customer_id=d.customer_id
JOIN country AS e ON a.country_id=e.country_id
GROUP BY name
ORDER BY total_amount
