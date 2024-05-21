# Find the transaction with maximum quantity
# Drawback of Aggregate value in filter
# Cannot use the aggregate in where

SELECT
	*
FROm
	customer_purchases
ORDER BY
	quantity DESC
LIMIT 1;

# Display those transactions where the quantity was higher than the overall average quantity of all transactions

SELECT
	*
FROm
	customer_purchases
WHERE 
	quantity > AVG(quantity);
    
# We can overall such issues using Sub Query

SELECT
	*
FROM
	customer_purchases
WHERE 
	quantity = (SELECT MAX(quantity) FROM customer_purchases);
    

SELECT
	*
FROM
	customer_purchases
WHERE 
	quantity > (SELECT AVG(quantity) FROM customer_purchases);
    
# What is the highest bill recorded value

SELECT
	*
FROM 
	customer_purchases
WHERE 
    quantity * cost_to_customer_per_qty = (SELECT MAX(quantity * cost_to_customer_per_qty) FROM customer_purchases);
    
# Display all the transactions where the quantity purchased > overall avg quantity

SELECT
	*
FROM
	customer_purchases
WHERE 
	quantity > (SELECT AVG(quantity) FROM customer_purchases);
    
# Get the names of all customers who purchased on 13th July 2019

SELECT
	customer_id, customer_first_name, customer_last_name
FROM 
	customer
WHERE 
	customer_id IN (SELECT customer_id FROM customer_purchases WHERE market_date = "2019-07-13");
    
# Grouping / Categorizing
# CASE

# Can we categorize transactions as First Half or Second half

SELECT 
	*,
    (CASE
    WHEN EXTRACT(MONTH FROM market_date) < 7 THEN "First Half"
    WHEN EXTRACT(MONTH FROM market_date) >= 7 THEN "Second Half"
    END
    ) AS `FH/SH`
FROM
	customer_purchases;

# We can use multiple IF Condistions instead of CASE

# Give the Quaters 

SELECT 
	*,
    (CASE
    WHEN EXTRACT(MONTH FROM market_date) <4 THEN "Q1"
    WHEN EXTRACT(MONTH FROM market_date) <7 THEN "Q2"
    WHEN EXTRACT(MONTH FROM market_date) <10 THEN "Q3"
    WHEN EXTRACT(MONTH FROM market_date) >=10 THEN "Q4"
    END
    ) AS `Quater`
FROM
	customer_purchases;
    
