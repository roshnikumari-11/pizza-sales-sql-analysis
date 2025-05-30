
                                                        /*  🍕 Pizza Sales SQL Analysis Project   */

USE pizzahut;
/*
Basic:
Retrieve the total number of orders placed.
Calculate the total revenue generated from pizza sales.
Identify the highest-priced pizza.
Identify the most commonly ordered pizza size.
List the top 5 most popular pizza types, along with their corresponding quantities.

*/


-- Retrieve the total number of orders placed.
SELECT 
    COUNT(order_id)
FROM
    orders;


-- Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(pizzas.price * order_details.quantity),
            2) AS total_revenue
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id;
-- the total revenue generated from pizza sales is 817860.05


-- Identify the highest-priced pizza.
SELECT 
    pizza_types.name, pizza_types.category, pizzas.price
FROM
    pizzas
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;
-- the highest-priced pizza is The Greek Pizza classic type price is $ 35.95



-- Identify the most commonly ordered pizza size.
SELECT 
    size, COUNT(*) AS total_size
FROM
    pizzas
GROUP BY size
ORDER BY total_size DESC
LIMIT 1;
--  the most commonly ordered pizza size is small (S) 32 times


--  List the top 5 most popular pizza types, along with their corresponding quantities.
SELECT 
    pt.name AS pizza_type, SUM(od.quantity) AS total_quantity
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id
        JOIN
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_quantity DESC
LIMIT 5;


-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                  /* Intermediate */
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
Intermediate:
Join the necessary tables to find the total quantity of each pizza category ordered.
Determine the distribution of orders by hour of the day.
Join relevant tables to find the category-wise distribution of pizzas.
Group the orders by date and calculate the average number of pizzas ordered per day.
Determine the top 3 most ordered pizza types based on revenue.

*/

select * from pizzas;
select * from orders;
select * from order_details;
select * from pizza_types;


-- Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
    pt.category, SUM(od.quantity) AS total_quantity
FROM
    pizzas p
        JOIN
    order_details od ON p.pizza_id = od.pizza_id
        JOIN
    pizza_types pt ON pt.pizza_type_id = p.pizza_type_id
GROUP BY pt.category;


-- Determine the distribution of orders by hour of the day.
SELECT 
    HOUR(order_time) AS hour, COUNT(order_id) AS order_count
FROM
    orders
GROUP BY HOUR(order_time);


-- Join relevant tables to find the category-wise distribution of pizzas.

SELECT 
    category, COUNT(name)
FROM
    pizza_types
GROUP BY category;



-- Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT 
    ROUND(AVG(quantity), 0) AS avg_pizza_ordered_per_day
FROM
    (SELECT 
        orders.order_date, SUM(order_details.quantity) AS quantity
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY orders.order_date) AS order_quantity;


-- Determine the top 3 most ordered pizza types based on revenue.

SELECT 
    pizza_types.name,
    SUM(order_details.quantity * pizzas.price) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY revenue DESC
LIMIT 3;






    
