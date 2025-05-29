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
1. Giai đoạn 2019
- Từ tháng 2/2019 đến 12/2019, số đơn và người mua tăng đều. Đặc biệt từ tháng 6 trở đi, mức tăng rõ rệt hơn 
 ==> cho thấy trang web đang dần thu hút thêm nhiều người dùng

2. Giai đoạn 2020
- Mặc dù COVID-19 nhưng số lượng đơn và người dùng không sụt giảm mạnh (chỉ giảm nhẹ tháng 2–3).
- Từ tháng 4/2020 trở đi, tốc độ tăng nhanh hơn: từ 88 lên 143 vào cuối năm.
==> có thể nhãn hàng đã tận dụng các chiến dịch marketing và bán hàng online.

3. Giai đoạn 2021
- Số lượng đơn hàng tăng đều và đạt mức cao nhất tháng 12: 266 đơn.
==> Cho thấy sự phát triển mạnh mẽ, có thể do nhu cầu tăng, chiến dịch marketing hiệu quả, hoặc mở rộng hệ thống.

4. Giai đoạn đầu 2022
- Xu hướng gia tăng tiếp tục trong giai đoạn tháng 1–3/2022 (305 đơn, 304 người mua).
- Tuy nhiên, tháng 4/2022 giảm đột ngột còn 13 đơn
==> Có thể do thiếu dữ liệu, hoặc thay đổi trong hoạt động kinh doanh, chính sách,...
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
1. Giai đoạn 2019
- số người dùng tăng đều, AOV dao động từ 49.3 đến 83.6.- 
Tháng 5/2019 đạt AOV cao nhất (83.64) 
Tháng 12/2019 AOV giảm xuống 49.37 mặc dù người dùng đạt 68 – cho thấy xu hướng tiếp cận nhiều khách hàng hơn nhưng giá trị đơn giảm

2. Giai đoạn 2020
- Số người dùng tăng đều từ 87 (1/2020) lên 142 (12/2020).
- AOV ở mức 55–65, trong đó:
 06/2020: AOV đạt 74.16 
 12/2020: AOV đạt 64.33 - cả số lượng và giá trị đơn hàng đều ở mức cao

3. Giai đoạn 2021
- Tăng trưởng người dùng liên tục, từ 134 (1/2021) lên đến 265 (12/2021).
- AOV biến động khá lớn ở giai đoạn giữa năm:
 04/2021: cao nhất năm (66.83) và giảm xuống 52.04 ở 05/2021
- Dù lượng người dùng tăng nhưng AOV giảm
4. Giai đoạn 2022
– Lượng người dùng vẫn gia tăng nhưng AOV giảm 
- Tháng 04/2022: người dùng giảm đột ngột (13) và AOV thấp nhất giai đoạn (50.91) 
*/




