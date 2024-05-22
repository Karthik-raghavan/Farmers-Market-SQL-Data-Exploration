# GROUP BY

# How many zip codes do these customer come from

SELECT 
	COUNT(DISTINCT customer_zip)
FROM customer;

# How many customers are from zip 22802

SELECT
	COUNT(customer_id)
FROM 
	customer
WHERE 
	customer_zip = 22802;
    
SELECT
	*
FROM 
	customer
WHERE 
	customer_zip = 22802;
    
    
# Which month(s) saw the highest single bill value ever

SELECT 
	DISTINCT EXTRACT(MONTH FROM market_date)
FROM 
	customer_purchases
WHERE 
	(quantity * cost_to_customer_per_qty) = (SELECT MAX(quantity * cost_to_customer_per_qty) FROM customer_purchases);
    
# Which year had the highest average quantity per transaction 

SELECT
	AVG(quantity)
FROM
	customer_purchases
WHERE 
	EXTRACT(YEAR FROM market_date) = 2019; # Does not work so alternative is using a new method - Group BY
    
SELECT
	AVG(quantity)
FROM
	customer_purchases
WHERE 
	EXTRACT(YEAR FROM market_date) = 2020;
    
# If there are many values in years, then we have to run seperately for those using filters

# Which customer made the most number of purchases ?
# We have to filter with each customer id which is time consuming

# In how many different transactions were each of the products purchased ?

# What is the average purchase quantity for each product ?

# GROUP BY Creates a new virtual table 
# Mostly based on Aggregate values
# Cant use aggregated value with non aggregated function
# In any grouped table, its either column listed in group by or aggregation functions

SELECT
	customer_zip
FROM 
	customer
GROUP BY 
	customer_zip;
    
SELECT
	customer_zip, COUNT(*)
FROM 
	customer
GROUP BY 
	customer_zip;
    
SELECT
	customer_zip, COUNT(*),SUM(customer_id),AVG(customer_id), MAX(customer_id), MIN(customer_id), MAX(LENGTH(customer_first_name))
FROM 
	customer
GROUP BY 
	customer_zip;
    
SELECT
	customer_id
FROM
	customer
GROUP BY 
	customer_id;

# Group By tends to find values within each group

# Which year had the highest average quantity per transaction 

SELECT
	EXTRACT(YEAR FROM market_date) AS `Year`, ROUND(AVG(quantity),2) AS `Quantity Average`
FROM 
	customer_purchases
GROUP BY
	EXTRACT(YEAR FROM market_date)
ORDER BY 
	`Quantity Average` DESC;
    

SELECT Transaction_Year, AVG(quantity) AS `Avg Quantity`
FROM (
SELECT EXTRACT(YEAR FROM market_date) AS `Transaction_Year`, quantity FROM customer_purchases
) AS `T`
GROUP BY Transaction_Year
ORDER BY `Avg Quantity` DESC;

# Find the average quantity sold in each month

SELECT 
	EXTRACT(YEAR FROM market_date) AS `Year`,
	EXTRACT(MONTH FROM market_date) AS `Month`, 
    ROUND(AVG(quantity),1) AS `Avg Quantity`, 
    MAX(quantity) AS `Max Quantity`,
    MIN(quantity) AS `Min Quantity`,
    COUNT(quantity) AS `Count Quantity`
FROM customer_purchases
GROUP BY EXTRACT(YEAR FROM market_date),EXTRACT(MONTH FROM market_date)
ORDER BY Year DESC, Month DESC;

# Display all results from the above table where the number of bills is above 100

SELECT 
	EXTRACT(YEAR FROM market_date) AS `Year`,
	EXTRACT(MONTH FROM market_date) AS `Month`, 
    ROUND(AVG(quantity),1) AS `Avg Quantity`, 
    MAX(quantity) AS `Max Quantity`,
    MIN(quantity) AS `Min Quantity`,
    COUNT(quantity) AS `Count Quantity`
FROM customer_purchases
GROUP BY EXTRACT(YEAR FROM market_date),EXTRACT(MONTH FROM market_date)
HAVING `Count Quantity` > 100
ORDER BY Year DESC, Month DESC;

# For filtering group table, we use HAVING 
# We can filter using aggregate values in HAVING unlike WHERE

