# CTE(Common Table Expression) and Views

# Agile
# Debugging (Too many lines of code)
# Integration logic

# > Makes code easy to read and and debug


# Who are the customers who spent > 250$ in the year 2019
# customer id and customer spend 2019

SELECT COUNT(*) AS `CountOfCustomer`
FROM (SELECT 
	DISTINCT customer_id, SUM(quantity * cost_to_customer_per_qty) OVER(PARTITION BY customer_id) AS `TotalSpentByCustomerIn2019`
FROM
	customer_purchases
WHERE EXTRACT(YEAR FROM market_date) = 2019) AS `T`
WHERE T.TotalSpentByCustomerIn2019 > 250;


# Give the find customer who spend more than 100 in 2020

SELECT COUNT(*) AS `CountOfCustomer`
FROM (SELECT 
	DISTINCT customer_id, SUM(quantity * cost_to_customer_per_qty) OVER(PARTITION BY customer_id) AS `TotalSpentByCustomerIn2019`
FROM
	customer_purchases
WHERE EXTRACT(YEAR FROM market_date) = 2020) AS `T`
WHERE T.TotalSpentByCustomerIn2019 > 200;

# Give a list of customers who purchased two or more types of products overall

SELECT
cp.customer_id, COUNT(DISTINCT p.product_id)
FROM product p
JOIN customer_purchases cp
ON cp.product_id = p.product_id
GROUP BY cp.customer_id
HAVING COUNT(p.product_id) >= 2;

# give the customer id and full name of customers  who are common in A B and C

