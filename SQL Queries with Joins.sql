# JOINS

# What is the avg quantity purchased per transaction in farmers market ?

SELECT
	AVG(quantity)
FROM customer_purchases;

# Display Transactions where the customer purchased more than the avg quantity

SELECT
	*
FROM
	customer_purchases
WHERE
	quantity > (SELECT AVG(quantity) FROM customer_purchases);
    
# Display full names of customers who have purchased "above average" quantity in at least one transaction

SELECT
	CONCAT(c.customer_first_name," ",c.customer_last_name) AS `Customer Full Name`
FROM 
	customer AS c
JOIN 
	customer_purchases AS cp
	ON cp.customer_id = c.customer_id
WHERE
	quantity > (SELECT AVG(quantity) FROM customer_purchases)
ORDER BY `Customer Full Name` ASC;
    
# Another way

SELECT 
	CONCAT(customer_first_name," ",customer_last_name) AS `Customer Full Name`
FROM customer
WHERE customer_id IN 
(SELECT
	customer_id
FROM
	customer_purchases 
WHERE
	quantity > (SELECT AVG(quantity) FROM customer_purchases))
ORDER BY `Customer Full Name` ASC;

# Display transaction details along with customer names for transactions which had "above average" quantity purchased

SELECT 
	T.*
FROM 
(SELECT
	*
FROM
	customer_purchases 
WHERE
	quantity > (SELECT AVG(quantity) FROM customer_purchases)) AS `T`
;
# The above query does not work as we need a way to link another table

# INNER JOIN

SELECT 
	cp.*, c.*
FROM
	customer_purchases AS cp
JOIN
	customer AS c
    ON c.customer_id = cp.customer_id
;

# Get the customer id where it is not available in the above result



SELECT customer_id
FROM customer
WHERE customer_id NOT IN 
(SELECT 
	cp.customer_id
FROM
	customer_purchases AS cp
JOIN
	customer AS c
    ON c.customer_id = cp.customer_id)

UNION ALL

SELECT customer_id
FROM customer_purchases
WHERE customer_id NOT IN 
(SELECT 
	c.customer_id
FROM
	customer_purchases AS cp
JOIN
	customer AS c
    ON c.customer_id = cp.customer_id);

# INNER JOIN

SELECT 
	cp.*, c.*
FROM
	customer_purchases AS cp
INNER JOIN
	customer AS c
    ON c.customer_id = cp.customer_id
;

# LEFT JOIN

SELECT 
	cp.*, c.*
FROM
	customer_purchases AS cp
LEFT JOIN
	customer AS c
    ON c.customer_id = cp.customer_id
;

# RIGHT JOIN

SELECT 
	cp.*, c.*
FROM
	customer_purchases AS cp
RIGHT JOIN
	customer AS c
    ON c.customer_id = cp.customer_id
;


# CROSS JOIN

SELECT 
	cp.*, c.*
FROM
	customer_purchases AS cp
CROSS JOIN
	customer AS c
    ON c.customer_id = cp.customer_id;
    
SELECT 
	cp.*, c.*
FROM
	customer_purchases AS cp
CROSS JOIN
	customer AS c;

# CROSS JOIN

SELECT *
FROM customer
CROSS JOIN customer_purchases;

# SQL SELF JOIN joins the table to itself and allows comparing rows within the same table. 
# SQL CROSS JOIN creates a result table containing paired combination of each row of the first table with each row of the second table.

# NON EQUI JOIN < > (Not EQUAL)