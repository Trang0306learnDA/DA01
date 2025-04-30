SELECT * FROM public.sales_dataset_rfm_prj;

--1. Chuyển đổi kiểu dữ liệu phù hợp cho các trường
ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN ordernumber TYPE INTEGER USING (trim(ordernumber)::INTEGER),
ALTER COLUMN quantityordered TYPE INTEGER USING (trim(quantityordered)::INTEGER),
ALTER COLUMN priceeach TYPE NUMERIC USING (trim(priceeach)::NUMERIC),
ALTER COLUMN orderlinenumber TYPE INTEGER USING (trim(orderlinenumber)::INTEGER),
ALTER COLUMN sales TYPE NUMERIC USING (trim(sales)::NUMERIC),
ALTER COLUMN orderdate TYPE DATE USING (trim(orderdate)::TIMESTAMP),
ALTER COLUMN msrp TYPE INTEGER USING (trim(msrp)::INTEGER);

--2. Check NULL/BLANK (‘’)
SELECT * FROM sales_dataset_rfm_prj
WHERE ordernumber IS NULL
OR quantityordered IS NULL
OR priceeach IS NULL
OR orderlinenumber IS NULL
OR sales IS NULL
OR orderdate IS NULL;

-- 3. Thêm cột CONTACTLASTNAME, CONTACTFIRSTNAME
ALTER TABLE sales_dataset_rfm_prj
ADD COLUMN contactfirstname VARCHAR,
ADD COLUMN contactlastname VARCHAR;

UPDATE sales_dataset_rfm_prj
SET 
contactfirstname = INITCAP(LEFT(contactfullname, POSITION ('-' IN contactfullname)-1)),
contactlastname = INITCAP(RIGHT(contactfullname, length(contactfullname) - POSITION ('-' IN contactfullname)));

--4. Thêm cột QTR_ID, MONTH_ID, YEAR_ID
ALTER TABLE sales_dataset_rfm_prj
ADD COLUMN qtr_id INTEGER,
ADD COLUMN month_id INTEGER,
ADD COLUMN year_id INTEGER;

UPDATE sales_dataset_rfm_prj
SET
qtr_id = EXTRACT(QUARTER FROM orderdate),
month_id = EXTRACT(MONTH FROM orderdate),
year_id = EXTRACT(YEAR FROM orderdate);

--5. Hãy tìm outlier (nếu có) cho cột QUANTITYORDERED
-- cách 1: sử dụng IQR/BOXPLOT tìm ra outlier
-- B1: Tính Q1, Q3, IQR
-- B2: xác định min=Q1-1.5*IQR; MAX=Q3+1.5*IQR
WITH twt_min_max_value AS (
SELECT 
Q1-1.5*IQR AS min_value,
Q3+1.5*IQR AS max_value FROM (
SELECT
percentile_cont(0.25) WITHIN GROUP (ORDER BY quantityordered) as Q1,
percentile_cont(0.75) WITHIN GROUP (ORDER BY quantityordered) as Q3,
percentile_cont(0.75) WITHIN GROUP (ORDER BY quantityordered) - percentile_cont(0.25) WITHIN GROUP (ORDER BY quantityordered) as IQR
FROM sales_dataset_rfm_prj) AS a)
-- B3: xác định outlier <min or >max
SELECT * FROM sales_dataset_rfm_prj
WHERE quantityordered < (SELECT min_value FROM twt_min_max_value)
OR quantityordered > (SELECT max_value FROM twt_min_max_value);

--Cách 2: sử dụng Z-score

WITH CTE AS (
SELECT 
quantityordered,
AVG(quantityordered) AS avg, 
stddev(quantityordered) AS stddv
FROM sales_dataset_rfm_prj
GROUP BY quantityordered
)

SELECT
(quantityordered - avg) / stddv as z_score
FROM CTE
WHERE ABS((quantityordered - avg) / stddv) > 2
