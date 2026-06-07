create database e;
use e;
CREATE TABLE sales (
    id INT,
    employee VARCHAR(50),
    department VARCHAR(10),
    sales_amount INT,
    sale_date DATE
);

INSERT INTO sales VALUES
(1, 'Alice', 'A', 1000, '2024-01-01'),
(2, 'Bob',   'B', 1500, '2024-01-02'),
(3, 'Alice', 'A', 2000, '2024-01-03'),
(4, 'Bob',   'B', 1800, '2024-01-04'),
(5, 'Alice', 'A', 1200, '2024-01-05'),
(6, 'Bob',   'B', 1600, '2024-01-06');

#Total sales per employee (Running Total)
SELECT *,
       SUM(sales_amount) OVER(
           PARTITION BY employee
           ORDER BY sale_date
       ) AS running_total
FROM sales;

# Row number per employee
SELECT *,
       ROW_NUMBER() OVER(
           PARTITION BY employee
           ORDER BY sale_date
       ) AS row_num
FROM sales;

#Rank of sales per department.
SELECT *,
       RANK() OVER(
           PARTITION BY department
           ORDER BY sales_amount DESC
       ) AS sales_rank
FROM sales;

#Lead (next sale) per employee.
SELECT *,
       LEAD(sales_amount) OVER(
           PARTITION BY employee
           ORDER BY sale_date
       ) AS next_sale
FROM sales;

#Lag (previous sale) per employee.
SELECT *,
       LAG(sales_amount) OVER(
           PARTITION BY employee
           ORDER BY sale_date
       ) AS previous_sale
FROM sales;

#Average sales per employee.
SELECT *,
       AVG(sales_amount) OVER(
           PARTITION BY employee
       ) AS avg_sales
FROM sales;

#First and last sales per employee.
SELECT *,
       FIRST_VALUE(sales_amount) OVER (PARTITION BY employee ORDER BY sale_date, id) AS first_sale,
       LAST_VALUE(sales_amount) OVER (PARTITION BY employee ORDER BY sale_date, id 
                                      ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_sale
FROM sales;

#Dense rank (no gaps).
SELECT *,
       DENSE_RANK() OVER(
           PARTITION BY department
           ORDER BY sales_amount DESC
       ) AS dense_rank_no_gaps
FROM sales;

#Cumulative average per employee.
SELECT *,
       AVG(sales_amount) OVER(
           PARTITION BY employee
           ORDER BY sale_date
           ROWS BETWEEN UNBOUNDED PRECEDING
           AND CURRENT ROW
       ) AS cumulative_avg
FROM sales;

#Find highest sale per employee.
SELECT *,
       MAX(sales_amount) OVER(
           PARTITION BY employee
       ) AS highest_sale
FROM sales;

#Sales difference from previous record.
SELECT *,
       sales_amount -
       LAG(sales_amount) OVER(
           PARTITION BY employee
           ORDER BY sale_date
       ) AS sales_difference
FROM sales;

#Cumulative count of sales per employee.
SELECT *,
       COUNT(*) OVER(
           PARTITION BY employee
           ORDER BY sale_date
       ) AS cumulative_count
FROM sales;

#Show if sale is above average per employee.
SELECT *,
       AVG(sales_amount) OVER(
           PARTITION BY employee
       ) AS avg_sales,

       CASE
           WHEN sales_amount >
                AVG(sales_amount) OVER(PARTITION BY employee)
           THEN 'Above Average'
           ELSE 'Below Average'
       END AS sale_status
FROM sales;

#Find second highest sale per employee.
SELECT *
FROM (
    SELECT *,
           DENSE_RANK() OVER(
               PARTITION BY employee
               ORDER BY sales_amount DESC
           ) AS rnk
    FROM sales
) temp
WHERE rnk = 2;

