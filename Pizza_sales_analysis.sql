-- creating database and tables;

create database pizzaah;

use pizzaah;

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE NOT NULL,
    order_time TIME NOT NULL
);

CREATE TABLE order_details (
    order_details_id INT NOT NULL PRIMARY KEY,
    order_id INT NOT NULL,
    pizza_id TEXT NOT NULL,
    quantity INT NOT NULL
);


-- Problem statements (Easy)
-- 1. Retrieve total no of orders placed

select count(order_id) as total_orders from orders;

-- 2. Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_sales
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id;
    
-- 3. Identify the highest prized pizza

SELECT 
    pizza_id AS highest_prized_pizza, price
FROM
    pizzas
ORDER BY price DESC
LIMIT 1;

-- 4. Identify the most common pizza size ordered.

SELECT 
    pizzas.size AS pizza_size,
    SUM(order_details.quantity) AS no_of_orders
FROM
    pizzas
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_size;

-- 5. List the top 5 most ordered pizza types along with their quantities.

SELECT 
    pizza_types.name AS pizza_name,
    SUM(order_details.quantity) AS quantity
FROM
    pizzas
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
        JOIN
    pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY pizza_name
ORDER BY quantity DESC
LIMIT 5;

-- Problem statements (Medium)
-- 1.  Join the necessary tables to find the total quantity of each category ordered. 

SELECT 
    pizza_types.category AS pizza_category,
    SUM(order_details.quantity) AS quantity
FROM
    pizzas
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
        JOIN
    pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY pizza_category
ORDER BY quantity DESC;


-- 2. Determine the distribution of orders by hour of the day 

SELECT 
    HOUR(order_time) AS time, COUNT(order_id) AS no_of_orders
FROM
    orders
GROUP BY time
ORDER BY time;

-- 3. Group the dates and Calculate the avg no of pizzas ordered per day 

SELECT 
    ROUND(AVG(date_wise_pizzas.no_of_pizzas_ordered),
            0) AS avg_pizzas_ordered
FROM
    (SELECT 
        orders.order_date AS date,
            SUM(order_details.quantity) AS no_of_pizzas_ordered
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY date) AS date_wise_pizzas;


-- 4. Determine the top 3 most ordered pizza based on revenue

select pizza_types.name as Pizza_name , sum(order_details.quantity*pizzas.price) as price
from pizzas join order_details
on pizzas.pizza_id = order_details.pizza_id
join pizza_types on pizza_types.pizza_type_id = pizzas.pizza_type_id
group by Pizza_name
order by price desc
limit 3;

-- Problem statements (hard)

-- 1. Calculate the percentage contribution of each pizza category towards the revenue.
SELECT 
    pizza_types.category AS Category,
    ROUND(SUM(pizzas.price * order_details.quantity) / (SELECT 
                    SUM(order_details.quantity * pizzas.price) AS total_sales
                FROM
                    order_details
                        JOIN
                    pizzas ON order_details.pizza_id = pizzas.pizza_id) * 100,
            2) AS percentage_contribution
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY category;

-- 2. Analyze the cumulative revenue generated over time.
select date , round(sum(revenue) over(order by date),2) as cumulative_revenue from (
	SELECT 
    orders.order_date AS date,
    SUM(order_details.quantity * pizzas.price) AS revenue
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
        JOIN
    orders ON orders.order_id = order_details.order_id
	group by orders.order_date)as revenue_table;


-- 3. Determine the top 3 most ordered pizza types based on revenue for each pizza category.
select category,name,revenue,category_rank from
(select category,name,revenue,rank() over(partition by category order by revenue desc ) as category_rank
from(
SELECT 
    pizza_types.category AS category,
    pizza_types.name AS name,
    ROUND(SUM(pizzas.price * order_details.quantity),
            2) AS revenue
FROM
    pizzas
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY name , category) as category_wise_revenue) as final_ans where category_rank<=3;