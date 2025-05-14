II. Ad-hocs tasks
--1. Thống kê tổng số lượng người mua và số lượng đơn hàng đã hoàn thành mỗi tháng ( Từ 1/2019-4/2022)
  
SELECT 
FORMAT_DATE('%Y-%m', DATE(created_at)) AS month_year ,
COUNT(order_id) AS total_order,
COUNT(DISTINCT user_id) AS total_user 
FROM bigquery-public-data.thelook_ecommerce.order_items
WHERE status='Complete'
AND DATE(created_at) BETWEEN '2019-01-01' AND '2022-04-01'
GROUP BY FORMAT_DATE('%Y-%m', DATE(created_at))
ORDER BY FORMAT_DATE('%Y-%m', DATE(created_at))

/*INSIGHT:

*/

-- 2. Giá trị đơn hàng trung bình (AOV) và số lượng khách hàng mỗi tháng

SELECT month_year, 
total_user,
total_revenue/total_order AS average_order_value FROM (
SELECT SUM(sale_price) AS total_revenue,
FORMAT_DATE('%Y-%m', DATE(created_at)) AS month_year ,
COUNT(order_id) AS total_order,
COUNT(DISTINCT user_id) AS total_user 
FROM bigquery-public-data.thelook_ecommerce.order_items
WHERE status='Complete'
AND DATE(created_at) BETWEEN '2019-01-01' AND '2022-04-01'
GROUP BY FORMAT_DATE('%Y-%m', DATE(created_at))
ORDER BY FORMAT_DATE('%Y-%m', DATE(created_at))
) AS a

/* INSIGHT

*/

