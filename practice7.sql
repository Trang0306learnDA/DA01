--Bài 1
WITH twt_total_spend AS(
SELECT EXTRACT (YEAR FROM transaction_date) AS year,
product_id,
SUM(spend) OVER (PARTITION BY product_id, EXTRACT (YEAR FROM transaction_date)) AS curr_year_spend
FROM user_transactions)

SELECT year, product_id,curr_year_spend,
LAG(curr_year_spend) OVER (PARTITION BY product_id ORDER BY product_id, year) AS prev_year_spend,
ROUND((curr_year_spend - LAG(curr_year_spend) OVER (PARTITION BY product_id ORDER BY product_id, year))
/LAG(curr_year_spend) OVER (PARTITION BY product_id ORDER BY product_id, year)*100,2) AS yoy_rate
FROM twt_total_spend
ORDER BY product_id, year

--Bài 2
SELECT card_name, issued_amount FROM (
SELECT
card_name, issued_amount,
ROW_NUMBER() OVER (PARTITION BY card_name ORDER BY issue_year, issue_month) AS rank
FROM monthly_cards_issued) AS monthly
WHERE rank=1
ORDER BY issued_amount DESC;

--Bài 3
SELECT user_id, spend, transaction_date
FROM (
SELECT *,
ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY transaction_date) AS rank
FROM transactions) AS transaction_rank
WHERE rank=3;

--Bài 4:
SELECT transaction_date, user_id, COUNT(product_id) AS purchase_count
FROM (SELECT *,
RANK() OVER(PARTITION BY user_id ORDER BY transaction_date DESC) AS rank
FROM user_transactions) AS count_trans
WHERE rank=1
GROUP BY transaction_date, user_id
ORDER BY transaction_date;

--Bài 5
SELECT user_id, tweet_date,   
ROUND(AVG(tweet_count) OVER ( PARTITION BY user_id ORDER BY tweet_date     
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),2) AS rolling_avg_3d
FROM tweets;

--Bài 6
WITH payments AS (
  SELECT 
    merchant_id, 
    EXTRACT(EPOCH FROM transaction_timestamp - 
      LAG(transaction_timestamp) OVER(
        PARTITION BY merchant_id, credit_card_id, amount 
        ORDER BY transaction_timestamp)
    )/60 AS minute_difference 
  FROM transactions) 

SELECT COUNT(merchant_id) AS payment_count
FROM payments 
WHERE minute_difference <= 10;


--Bài 7
WITH ranking AS(
SELECT category, product, SUM(spend) AS total_spend,
RANK () OVER(PARTITION BY category ORDER BY category, SUM(spend) DESC) AS rank
FROM product_spend
WHERE EXTRACT (YEAR FROM transaction_date) ='2022'
GROUP BY category,  product)

SELECT category, product, total_spend
FROM ranking 
WHERE rank <=2

  
  --Bài 8
WITH top_10_cte AS (
  SELECT 
    artists.artist_name,
    DENSE_RANK() OVER (
      ORDER BY COUNT(songs.song_id) DESC) AS artist_rank
  FROM artists
  INNER JOIN songs
    ON artists.artist_id = songs.artist_id
  INNER JOIN global_song_rank AS ranking
    ON songs.song_id = ranking.song_id
  WHERE ranking.rank <= 10
  GROUP BY artists.artist_name
)

SELECT artist_name, artist_rank
FROM top_10_cte
WHERE artist_rank <= 5;


