# Retail Sales Analytics Dashboard using SQL & Power BI

## 📌 Project Overview

This project focuses on analyzing retail sales data using SQL and Power BI to generate business insights and support data-driven decision-making.

The project includes:

* Data cleaning and transformation using MySQL
* Data modeling using Star Schema
* SQL analysis using joins, aggregations, and window functions
* Interactive Power BI dashboard creation
* Business insights generation

---

# 🎯 Objective

The main objective of this project is to:

* Analyze sales performance
* Identify profitable and loss-making products
* Understand customer and regional trends
* Create an interactive dashboard for business decision-making

---

# 🛠️ Tools & Technologies Used

| Tool      | Purpose                   |
| --------- | ------------------------- |
| MySQL     | Data cleaning & analysis  |
| Power BI  | Dashboard & visualization |
| SQL       | Querying & transformation |
| Excel/CSV | Raw dataset source        |

---

# 📂 Dataset Information

The dataset used is the Superstore sales dataset containing:

* Order details
* Customer information
* Product categories
* Sales & profit
* Discounts
* Regional data
* Shipping details

---

# 🧹 Data Cleaning Process

Data cleaning was performed using SQL:

### Steps:

* Checked row counts and validated records
* Handled inconsistent date formats
* Converted text dates into proper DATE format
* Checked for null values
* Validated sales and profit columns

### Example:

```sql
STR_TO_DATE(REPLACE(Order_Date, '-', '/'), '%c/%e/%Y')
```

---

# ⭐ Data Modeling

A Star Schema was created for efficient analysis.

## Fact Table

* sales

## Dimension Tables

* customers
* products
* orders

### Why Star Schema?

* Better performance
* Simpler relationships
* Efficient reporting in Power BI

---

# 📊 SQL Analysis Performed

## Aggregation Queries

* Sales by region
* Category performance
* Top customers
* Loss-making products

## JOIN Operations

Used joins to combine sales, customer, and product data.

## Window Functions

Used:

* RANK()
* Running totals

---

# 📈 Power BI Dashboard

An interactive one-page dashboard was created to visualize:

## KPIs

* Total Sales
* Total Profit
* Profit Margin

## Visuals Used

* KPI Cards
* Bar Charts
* Line Charts
* Tables
* Slicers

---

# 🔍 Business Insights Generated

The project identified:

* Loss-making products
* Impact of discounts on profitability
* Top-performing customers
* Regional sales trends
* Category-wise performance

---

# ⚡ Challenges Faced

## Date Format Issues

The dataset contained inconsistent date formats.

### Solution:

Used:

```sql
REPLACE() + STR_TO_DATE()
```

To standardize and convert dates.

## Data Validation

Validated row counts and totals between SQL and Power BI to ensure data accuracy.

---

# 🧠 Key Learnings

Through this project, I learned:

* SQL data cleaning and transformation
* Data modeling concepts
* Power BI dashboard development
* DAX calculations
* Business insight generation
* Data validation techniques

---

# 🚀 Future Improvements

* Add forecasting analysis
* Implement drill-through reports
* Add advanced DAX measures
* Automate refresh using Power BI Service

---
# 📷 Dashboard Preview


---

<img width="1316" height="734" alt="image" src="https://github.com/user-attachments/assets/cdde4ca1-fdf8-4692-9de9-c3a12f08a8ee" />



This project demonstrates an end-to-end business intelligence workflow from raw data cleaning to interactive dashboard reporting using SQL and Power BI.

It highlights how data analytics can help businesses improve decision-making throug
