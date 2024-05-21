# Return all columns from farmers market

SELECT 
	*
FROM 
	customer;

# Display the first name and zip codes of customers 

SELECT 
	customer_first_name, customer_zip
FROM 
	customer;

# Display the first name and zip codes of customers and order by first name is ascending 

SELECT 
	customer_first_name, customer_zip
FROM 
	customer
ORDER BY 
	customer_first_name ASC;

# Display the first name and zip codes of customers and order by zip in descending

SELECT 
	customer_first_name, customer_zip
FROM 
	customer
ORDER BY 
	customer_zip DESC;

# Display the first name and zip codes of customers and order by zip in descending and first name is ascending

SELECT 
	customer_first_name, customer_zip
FROM 
	customer
ORDER BY 
	customer_zip DESC,
    customer_first_name ASC;
    
# Limiting the Number of rows to 3

SELECT
	*
FROM 
	customer
LIMIT 3;

# Return the records of only 3 customers who have first names in dictionary order

SELECT 
	*
FROM 
	customer
ORDER BY
	LENGTH(customer_first_name,customer_last_name) ASC
LIMIT 3;

# Return the records of only 3 customers who have last names in dictionary order

SELECT 
	*
FROM 
	customer
ORDER BY
	LENGTH(customer_first_name) DESC
LIMIT 3;

# Display the records of customer id from 6 to 9

SELECT 
	*
FROM 
	customer
ORDER BY 
	customer_id ASC
LIMIT 4
OFFSET 5;

# Filters
# Apply filter so only customer from zip 22801 are fetched

SELECT
	*
FROM
	customer
WHERE
	customer_zip = 22801;

# Apply filter so only customer from zip 22802 are fetched

SELECT
	*
FROM
	customer
WHERE
	customer_zip = 22802;
    
# Apply filter so only customer from zip 22817 are fetched

SELECT
	*
FROM
	customer
WHERE
	customer_zip = 22817;
    
# Logical Operators
# AND OR NOT

# Apply filter so only customer from zip 22801 or 22802 are fetched

SELECT
	*
FROM
	customer
WHERE
	customer_zip = 22801 
OR 
	customer_zip = 22802;
    
# Display the records of customer id from 6 to 9 using filters

SELECT
	* 
FROM
	customer
WHERE
	customer_id >= 6 
AND
    customer_id < 10;
    
# Display the records of customer id from 6 to 9 using filters order by last name in descending

SELECT
	* 
FROM
	customer
WHERE
	customer_id >= 6 
AND
    customer_id < 10
ORDER BY
	customer_last_name DESC;
    
# Get the records of customers whose ids are present in the list (17,5,3,1,9,10)

SELECT 
	*
FROM 
	customer
WHERE
	customer_id IN (17,5,3,1,9,10);
    
# Get the records of customers whose ids are present not in the list (17,5,3,1,9,10)

SELECT 
	*
FROM 
	customer
WHERE
	customer_id NOT IN (17,5,3,1,9,10);
    
# Repeating values
# Fetch all the customer zip codes

SELECT
	DISTINCT customer_zip
FROM 
	customer;
    
# Fetch all the customer id and zip codes and then display unique

SELECT
	DISTINCT customer_id, customer_zip
FROM customer;

# Fetch distinct names

SELECT
	DISTINCT customer_first_name
FROM customer;

# Functions
# ALIAS / AS

SELECT 
	*, LENGTH(customer_first_name) AS `FN-Length`
FROM 
	customer;

# Using Alias for original column name

SELECT 
	customer_id AS `ID`
FROM 
	customer;
