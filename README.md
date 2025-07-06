# 🍕 Pizza Sales Analysis using SQL

This project presents an in-depth analysis of a fictional pizza sales database using SQL. The goal is to extract meaningful insights from sales data that can help a business understand customer preferences, revenue trends, and product performance.

## 📂 Project Overview
The analysis is performed on a relational database named pizzaah which simulates a real-world pizza restaurant's sales data. It includes multiple levels of SQL queries (Easy, Medium, Hard) to solve different business questions, from basic aggregations to advanced window functions and revenue breakdowns.

## 🧱 Database Schema
The project involves three main tables:

### 1. orders :
   
Column	Data Type	Description,

order_id	INT	Unique ID for each order, 

order_date	DATE	Date when the order was placed, 

order_time	TIME	Time when the order was placed.

### 2. order_details :
   
Column	Data Type	Description,

order_details_id	INT	Unique ID for each order detail entry, 

order_id	INT	Foreign key referencing orders table, 

pizza_id	TEXT	ID of the pizza ordered, 

quantity	INT	Number of pizzas ordered.

### 3. pizzas :
   
Column	Data Type	Description,

pizza_id	TEXT	Unique ID of the pizza, 

pizza_type_id	TEXT	Foreign key referencing pizza_types table, 

size	TEXT	Size of the pizza (S, M, L, XL), 

price	FLOAT	Price of the pizza.

### 4. pizza_types :

Column	Data Type	Description,

pizza_type_id	TEXT	Unique type ID, 

name	TEXT	Name of the pizza, 

category	TEXT	Category (Classic, Veggie, etc.).

## 🧠 Key Analytical Methods Used
Joins: To combine relevant data from multiple tables.

Aggregate Functions: SUM(), COUNT(), AVG() for totals, averages, etc.

Grouping: GROUP BY to analyze by category, size, hour, etc.

Sorting and Ranking: ORDER BY, LIMIT, RANK() for top performers.

Window Functions: For cumulative revenue analysis and category-wise ranking.

Subqueries and CTEs: For modular and layered querying.

Data Transformation: Calculating percentage contributions and averages.

## 🔍 Insights Extracted
### 🟢 Easy Level
Total number of orders placed, 

Total revenue generated, 

Most expensive pizza, 

Most common pizza size, 

Top 5 most ordered pizzas.

### 🟡 Medium Level
Order distribution by hour,

Average pizzas ordered per day,

Top revenue-generating pizzas,

Quantity breakdown by category.

### 🔴 Hard Level
Percentage contribution to revenue by category,

Cumulative revenue over time,

Top 3 pizzas by revenue in each category.
