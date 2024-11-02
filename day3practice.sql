--bài 1
SELECT name FROM city WHERE countrycode = 'USA' AND population > 120000
SELECT * FROM city
SELECT * FROM city WHERE ID = 1661
SELECT * FROM city WHERE countrycode ='JPN'
SELECT name FROM city WHERE countrycode = 'JPN'
SELECT city, state FROM station
SELECT DISTINCT city FROM station WHERE id % 2 = 0
SELECT COUNT(city) - COUNT(distinct city) FROM station
SELECT city,length(city) FROM station ORDER BY length(city) ASC, city ASC limit 1;
SELECT city,length(city) FROM station ORDER BY length(city) DESC, city ASC limit 1
SELECT DISTINCT city FROM station WHERE LEFT(city,1) IN ('A','E','I','O','U')
SELECT DISTINCT city FROM station WHERE RIGHT(city,1) IN ('A','E','I','O','U')
SELECT DISTINCT city FROM station WHERE (RIGHT(city,1) IN ('A','E','I','O','U') AND LEFT(city,1) IN ('A','E','I','O','U'))
SELECT DISTINCT city FROM station WHERE LEFT(city,1) NOT IN ('A','E','I','O','U')
SELECT DISTINCT city FROM station WHERE RIGHT(city,1) NOT IN ('A','E','I','O','U')
SELECT DISTINCT city FROM station WHERE NOT (RIGHT(city,1) IN ('A','E','I','O','U') AND LEFT(city,1) IN ('A','E','I','O','U'))
SELECT DISTINCT city FROM station WHERE NOT (RIGHT(city,1) IN ('A','E','I','O','U') AND LEFT(city,1) IN ('A','E','I','O','U'))
SELECT name FROM students WHERE marks >75 ORDER BY right(name,3), ID ASC
SELECT name FROM employee ORDER BY name ASC
SELECT name FROM employee WHERE salary > 2000 and months <10 ORDER BY employee_id ASC
SELECT round(sqrt(power((max(LAT_N)-min(LAT_N)),2) + power((max(LONG_W)-min(LONG_W)),2)),4) FROM station
--BÀI 2
SELECT * FROM city WHERE countrycode ='JPN'
--bài 3
SELECT city, state FROM station
--bài 4
SELECT DISTINCT city FROM station WHERE LEFT(city,1) IN ('A','E','I','O','U')
--bài 5
SELECT DISTINCT city FROM station WHERE RIGHT(city,1) IN ('A','E','I','O','U')
--bài 6
SELECT DISTINCT city FROM station WHERE LEFT(city,1) NOT IN ('A','E','I','O','U')
--bài 7
SELECT name FROM employee ORDER BY name ASC
--bài 8
SELECT name FROM employee WHERE salary > 2000 and months <10 ORDER BY employee_id ASC
--bài 9
SELECT product_id FROM products WHERE low_fats ='y' AND recyclable ='y'
--bài 10
SELECT name FROM customer WHERE referee_id !=2 OR referee_id IS NULL
--bài 11
SELECT name, population, area FROM world 
WHERE area >= 3000000 OR population >= 25000000
--bài 12
SELECT DISTINCT author_id AS id FROM views 
WHERE author_id = viewer_id 
ORDER BY author_id ASC
--bài 13
SELECT part, assembly_step FROM parts_assembly WHERE finish_date IS NULL
--bài 14
SELECT * FROM lyft_drivers
WHERE yearly_salary <=30000 OR yearly_salary >= 70000
--bài 15
SELECT advertising_channel FROM uber_advertising 
WHERE money_spent > 100000 AND year = 2019
