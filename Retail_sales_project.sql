--SQL Retail Analysis
CREATE DATABASE sql_project;

--Create Table
DROP TABLE IF EXISTS retail_sales
CREATE TABLE retail_sales(
   		transactions_id INT PRIMARY KEY,
		sale_date DATE,
		sale_time TIME,
		customer_id INT,
		gender VARCHAR(10),
		age INT,
		category VARCHAR(20),
		quantiy INT ,
		price_per_unit FLOAT,
		cogs FLOAT,
		total_sale FLOAT
)

SELECT * FROM retail_sales;
LIMIT 10;

SELECT 
 Count(*)
FROM retail_sales;

-- Exploration

SELECT *
FROM retail_sales
WHERE transactions_id IS NULL;

SELECT *
FROM retail_sales
WHERE 
   transactions_id IS NULL
   OR
   sale_date IS NULL
   OR
   sale_time IS NULL
   OR 
   customer_id IS NULL
   OR
   gender IS NULL
   OR 
   age IS NULL
   OR 
   category IS NULL
   OR
   quantiy IS NULL
   OR 
   price_per_unit IS NULL
   OR 		
   cogs IS NULL
   OR 
   total_sale IS NULL;

-- DELETE ROWS WHICH HAVE NULL VALUES

DELETE FROM retail_sales
WHERE 
   transactions_id IS NULL
   OR
   sale_date IS NULL
   OR
   sale_time IS NULL
   OR 
   customer_id IS NULL
   OR
   gender IS NULL
   OR 
   age IS NULL
   OR 
   category IS NULL
   OR
   quantiy IS NULL
   OR 
   price_per_unit IS NULL
   OR 		
   cogs IS NULL
   OR 
   total_sale IS NULL;

SELECT COUNT(*)
FROM retail_sales;

-- HOW many Sales we have?
SELECT 
 COUNT(*) as Total_sales
FROM retail_sales;

-- How many customers we have
SELECT COUNT(customer_id)
FROM retail_sales;

--How many unique customers we have - 155
SELECT COUNT(DISTINCT customer_id)
FROM retail_sales;

-- How many categories (unique) we have -3
SELECT 
 COUNT(DISTINCT category) AS Categories_Number,
FROM retail_sales;

SELECT 
 DISTINCT category AS Categories_type
FROM retail_sales;

--Data Analysis & Business Key Problems & Answers
-- Q1 Write a SQL Query to retrieve all columns for sales made on '2022-11-05'

SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Write a SQL query to retrieve all transactions where the category is 'Clothing' and quantity sold is more than 3 in the month of NOV-2022
SELECT 
  category,
  SUM(quantiy) AS Total_quantity
FROM retail_sales
WHERE category = 'Clothing'
GROUP BY 1

SELECT *
FROM retail_sales
WHERE category = 'Clothing'
	 AND 
	 TO_CHAR(sale_date,'YYY-MM') = '2022-11'
GROUP BY 1

SELECT *
FROM retail_sales
WHERE category = 'Clothing'
	 AND 
	 TO_CHAR(sale_date,'YYYY-MM') = '2022-11'
	 AND 
	 quantiy > 3

SELECT *
FROM retail_sales
WHERE category = 'Clothing'
	 AND 
	 TO_CHAR(sale_date,'YYYY-MM') = '2022-11'
	 AND 
	 quantiy > 1

-- Write a SQLquery to calculate the total sales (total_sale) for each category
SELECT 
 category,
 SUM(total_sale) AS Total_sales
FROM retail_sales
GROUP BY category;

SELECT 
 category,
 SUM(total_sale) AS Total_sales,
 COUNT(*) AS Total_orders
FROM retail_sales
GROUP BY category;

-- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category
SELECT
 AVG(age) AS Average_age,
 category
FROM retail_sales
WHERE category = 'Beauty'
GROUP BY category

SELECT
 ROUND(AVG(age),2) AS Average_age,
 category
FROM retail_sales
WHERE category = 'Beauty'
GROUP BY category

-- Q5: Write a SQL query to find all transactions where the total_sale is greater than 1000

SELECT *
FROM retail_sales
WHERE total_sale > 1000

-- Q6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category
SELECT
 category,
 gender,
 COUNT(transactions_id) AS Number_transactions
FROM retail_sales
GROUP BY category, gender
ORDER BY category ASC, gender ASC
 
-- Q7: Write a SQL Query to calcaulate the average sales for each month. find out best selling mont in each year

SELECT * FROM
(
SELECT 
 EXTRACT(YEAR FROM sale_date) AS year,
 EXTRACT(MONTH FROM sale_date) AS month,
 AVG(total_sale) AS Average_sales,
 RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS Ranking
FROM retail_sales
GROUP BY Month, Year
) as t1
WHERE ranking = 1

--ORDER BY year ASC, month

-- Q8: Write a SQL query to find the top 5 customers based on the highest total sales

SELECT
 customer_id,
 SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5

--Q9: Write a SQL query to find number of unique customers who purchased items from each category

SELECT
 category,
 COUNT(DISTINCT customer_id) AS Unique_customers
FROM retail_sales
GROUP BY category
ORDER BY category ASC

--Q10: Write a SQL query to create each shift and number of orders (Examples morning<=12, Afternoon Between 12 &17, Evening >17)
SELECT 
  CASE 
   WHEN sale_time < '12:00:00' THEN 'Morning'	
   WHEN sale_time BETWEEN '12:00:00' AND '17:00:00' THEN 'Afternoon'
   ELSE 'Evening'
  END AS Shift_type,
  COUNT(transactions_id) AS Number_orders
FROM retail_sales
GROUP BY Shift_type
ORDER BY Shift_type ASC


WITH Hourly_sales
AS
(
SELECT *,
 CASE 
  WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
  WHEN EXTRACT(HOUR FROM Sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
  ELSE 'Evening'
 END AS Shift_type
FROM retail_sales
)
SELECT
 Shift_type,
 COUNT(transactions_id) AS Number_orders
FROM Hourly_sales
GROUP BY Shift_type

__ END of Project
 
  
  
 
 


