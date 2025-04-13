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

