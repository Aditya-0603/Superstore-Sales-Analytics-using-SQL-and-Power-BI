-- Create Database
CREATE DATABASE superstore_db;
USE superstore_db;

--------------------------------------------------
-- 1. Create Raw Table
--------------------------------------------------

CREATE TABLE superstore_raw (
    Row_ID INT,
    Order_ID VARCHAR(20),
    Order_Date VARCHAR(20),
    Ship_Date VARCHAR(20),
    Ship_Mode VARCHAR(50),
    Customer_ID VARCHAR(20),
    Customer_Name VARCHAR(100),
    Segment VARCHAR(50),
    Country VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(50),
    Postal_Code VARCHAR(20),
    Region VARCHAR(50),
    Product_ID VARCHAR(50),
    Category VARCHAR(50),
    Sub_Category VARCHAR(50),
    Product_Name TEXT,
    Sales FLOAT,
    Quantity INT,
    Discount FLOAT,
    Profit FLOAT
) CHARACTER SET latin1;

--------------------------------------------------
-- 2. Load Data
--------------------------------------------------

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'C:/Users/DELL/Desktop/MYSQL Innomatics/Project 2/Sample - Superstore.csv'
INTO TABLE superstore_raw
CHARACTER SET latin1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

--------------------------------------------------
-- 3. Data Validation
--------------------------------------------------

SELECT COUNT(*) AS total_rows FROM superstore_raw;
SELECT * FROM superstore_raw LIMIT 10;
SELECT DISTINCT Category FROM superstore_raw;

--------------------------------------------------
-- 4. Data Cleaning
--------------------------------------------------

-- Convert Dates Check
SELECT STR_TO_DATE(Order_Date, '%c/%e/%Y') AS clean_order_date
FROM superstore_raw;

-- Check NULL values
SELECT *
FROM superstore_raw
WHERE Sales IS NULL OR Profit IS NULL;

-- Check Loss Cases
SELECT *
FROM superstore_raw
WHERE Profit < 0;

--------------------------------------------------
-- 5. Create Clean Table
--------------------------------------------------

DROP TABLE IF EXISTS superstore_clean;


CREATE TABLE superstore_clean AS
SELECT 
    Row_ID,
    Order_ID,
    STR_TO_DATE(REPLACE(Order_Date, '-', '/'), '%c/%e/%Y') AS Order_Date,
    STR_TO_DATE(REPLACE(Ship_Date, '-', '/'), '%c/%e/%Y') AS Ship_Date,
    Ship_Mode,
    Customer_ID,
    Customer_Name,
    Segment,
    Country,
    City,
    State,
    Postal_Code,
    Region,
    Product_ID,
    Category,
    Sub_Category,
    Product_Name,
    Sales,
    Quantity,
    Discount,
    Profit
FROM superstore_raw;

-- Validate Clean Data
SELECT COUNT(*) AS clean_rows FROM superstore_clean; 

--------------------------------------------------
-- 6. Create Star Schema
--------------------------------------------------

-- Orders Table
CREATE TABLE orders AS
SELECT DISTINCT
    Order_ID,
    Order_Date,
    Ship_Date,
    Ship_Mode,
    Customer_ID,
    Region,
    State
FROM superstore_clean;

-- Customers Table
CREATE TABLE customers AS
SELECT DISTINCT
    Customer_ID,
    Customer_Name,
    Segment
FROM superstore_clean;

-- Products Table
CREATE TABLE products AS
SELECT DISTINCT
    Product_ID,
    Product_Name,
    Category,
    Sub_Category
FROM superstore_clean;

-- Sales (Fact Table)
CREATE TABLE sales AS
SELECT 
    Order_ID,
    Product_ID,
    Sales,
    Quantity,
    Discount,
    Profit
FROM superstore_clean;

--------------------------------------------------
-- 7. Business Analysis Queries
--------------------------------------------------

-- Sales by Region
SELECT Region, SUM(Sales) AS Revenue
FROM superstore_clean
GROUP BY Region;

-- Category Performance
SELECT Category, SUM(Sales) AS Total_Sales, SUM(Profit) AS Total_Profit
FROM superstore_clean
GROUP BY Category;

-- Top Customers
SELECT Customer_Name, SUM(Sales) AS Revenue
FROM superstore_clean
GROUP BY Customer_Name
ORDER BY Revenue DESC
LIMIT 10;

-- Loss-making Products
SELECT Product_Name, SUM(Profit) AS Total_Loss
FROM superstore_clean
GROUP BY Product_Name
HAVING SUM(Profit) < 0;

--------------------------------------------------
-- 8. JOIN-based Analysis (IMPORTANT 🔥)
--------------------------------------------------

-- Sales by Category using JOIN
SELECT 
    p.Category,
    SUM(s.Sales) AS Revenue
FROM sales s
JOIN products p ON s.Product_ID = p.Product_ID
GROUP BY p.Category;

-- Customer Revenue using JOIN
SELECT 
    c.Customer_Name,
    SUM(s.Sales) AS Revenue
FROM sales s
JOIN orders o ON s.Order_ID = o.Order_ID
JOIN customers c ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_Name
ORDER BY Revenue DESC;

--------------------------------------------------
-- 9. Window Functions
--------------------------------------------------

-- Rank Customers
SELECT 
    Customer_Name,
    SUM(Sales) AS Revenue,
    RANK() OVER (ORDER BY SUM(Sales) DESC) AS rank_no
FROM superstore_clean
GROUP BY Customer_Name;

-- Running Total
SELECT 
    Order_Date,
    SUM(Sales) AS daily_sales,
    SUM(SUM(Sales)) OVER (ORDER BY Order_Date) AS running_total
FROM superstore_clean
GROUP BY Order_Date;

--------------------------------------------------
-- 10. Final Check
--------------------------------------------------

SELECT SUM(Sales) AS Total_Sales FROM superstore_clean;
SELECT * FROM superstore_clean limit 10000;