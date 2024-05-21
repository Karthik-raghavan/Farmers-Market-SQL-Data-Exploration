# Return all columns along with Length of the string 

SELECT
	customer_last_name AS `LN`,
    LENGTH(customer_last_name) AS `LN-Length`
FROM 
	customer;

# Return all columns along with Length of the string order by last name in desc

SELECT
	customer_last_name AS `LN`,
    LENGTH(customer_last_name) AS `LN-Length`
FROM 
	customer
ORDER BY
	customer_last_name DESC;
    

# Display those records where the customer has a last name longer than 5

SELECT
	*
FROM
	customer
WHERE 
	LENGTH(customer_last_name) > 5;
    
# Testing Functions

SELECT "GREAT" AS `Word1`, LENGTH("GREAT") AS `Word1-Length`;
    
    
# CONCAT

SELECT CONCAT("GREAT", "BRITAIN");

# CONCAT 

SELECT CONCAT("GREAT", "BRITAIN"), CONCAT("1","1");

# CONCAT 

SELECT CONCAT("GREAT", " ","BRITAIN"), CONCAT("1","1");

# LOWER

SELECT LOWER("GREAT");

SELECT LOWER("Great");

# For every customer Display full name in CAPS and as well as the length of the customer full name

SELECT
	*, 
    CONCAT(UPPER(customer_first_name)," ", UPPER(customer_last_name)) AS `Full Name In Caps`,
    LENGTH(customer_first_name) + LENGTH(customer_last_name) AS `Length_Full_Name`
FROM
	customer;
    
# SUBSTR

SELECT SUBSTR("Encapsulation", 3,3);

SELECT SUBSTR("Encapsulation", 3);

SELECT SUBSTR("Encapsulation", 1,1);

SELECT SUBSTR("Encapsulation", 2);

SELECT 
	CONCAT(SUBSTR("ENCAPSULATION",1,1),
		LOWER(SUBSTR("ENCAPSULATION",2))) AS `Word`; 
        
# Display names like jANE cONNOR

SELECT 
	customer_first_name,
    customer_last_name,
    CONCAT(
    LOWER(SUBSTR(customer_first_name,1,1)),
    UPPER(SUBSTR(customer_first_name,2)),
    " ",
    LOWER(SUBSTR(customer_last_name,1,1)),
    UPPER(SUBSTR(customer_last_name,2))
    ) AS `Full Name`
FROM
	customer;
    
# customers_purchases dataset
## yyyy-mm-dd hr:mm:ss is the Date and Time format

SELECT *
FROM customer_purchases;

# What is the total bill value

SELECT
	*, quantity * cost_to_customer_per_qty AS `Total Bill Value`
FROM
	customer_purchases
ORDER BY
	product_id ASC;
    
SELECT
	*, ROUND(quantity * cost_to_customer_per_qty,2) AS `Total Bill Value`
FROM
	customer_purchases
ORDER BY
	product_id ASC;

# Display top 5 transactions in terms of bill value

SELECT
	*, ROUND(quantity * cost_to_customer_per_qty,2) AS `Total Bill Value`
FROM
	customer_purchases
ORDER BY
	`Total Bill Value` DESC
LIMIT 5;

# Date Functions - Extract
# Becomes a numerical value after being extract from date 

SELECT
	*,EXTRACT(YEAR FROM market_date) AS `Transaction Year`
FROM 
	customer_purchases
ORDER BY `Transaction Year` DESC;

# Extract data only from december month

SELECT
	*
FROM 
	customer_purchases
WHERE
	EXTRACT(MONTH FROM market_date) = 12;
    
# No records

# Extract data only from may month

SELECT
	*
FROM 
	customer_purchases
WHERE
	EXTRACT(MONTH FROM market_date) = 5;
    
# Find all transactions that happened in the second half of 2019

SELECT
	*
FROM 
	customer_purchases
WHERE
	EXTRACT(MONTH FROM market_date) > 6 AND
    EXTRACT(YEAR FROM market_date) = 2019; 

# Find all the transactions that happened between midnight and noon

SELECT
	*
FROM
	customer_purchases
WHERE
	EXTRACT(HOUR FROM transaction_time) >= 0 AND EXTRACT(HOUR FROM transaction_time) < 12;

# Find all the transactions by customer_id 7 in the year 2020

SELECT
	*
FROM
	customer_purchases
WHERE
	customer_id = 7 AND EXTRACT(YEAR FROM market_date) = 2020;

# IF Function
# For each transaction categorize whether it happened in first/second half of the year

SELECT
	*,
    IF(
	EXTRACT(MONTH FROM market_date) <= 6, "FH","SH"
    ) AS `FH/SH`
FROM 
	customer_purchases;
    
# BETWEEN
#  Given transaction that happened Jan - Mar 2020

SELECT
	*
FROM 
	customer_purchases
WHERE
	EXTRACT(YEAR FROM market_date) = 2020 AND
    EXTRACT(MONTH FROM market_date) BETWEEN 1 AND 3;
    
SELECT
	*
FROM 
	customer_purchases
WHERE
	market_date BETWEEN '2020-01-01' AND '2020-03-31';
    
# Timestamp

SELECT
	*,EXTRACT(HOUR_SECOND FROM transaction_time)
FROM 
	customer_purchases;
    
#  Given transaction that happened Jan - Mar 2019

SELECT
	*
FROM 
	customer_purchases
WHERE
	market_date BETWEEN '2019-01-01' AND '2019-03-31';
    
#  Given transaction that happened Jan 2019 - Mar 2020

SELECT
	*
FROM 
	customer_purchases
WHERE
	market_date BETWEEN '2019-01-01' AND '2020-03-31';
    
# Find all the transactions done by customers 4,7,1

SELECT
	*
FROM
	customer_purchases
WHERE
	customer_id IN (4,7,1);
    
# Find customers who have A in their name

SELECT 
	*
FROM 
	customer
WHERE 
	customer_first_name LIKE "%a%" OR customer_first_name LIKE "A%";

# Pattern - Wildcards (LIKE)
# _ --> underscore - exactly 1 character
# % --> Percentage - 0 or more characters

SELECT 
	*
FROM 
	customer
WHERE 
	customer_first_name LIKE "a%";

# space is also a character
# data is case sensitive 
# Keywords are not case sensitive


# Display records of customer who have 3 letter first names

SELECT
	*
FROM
	customer
WHERE 
	customer_first_name LIKE '___' OR customer_first_name LIKE "____";
    
SELECT
	*
FROM
	customer
WHERE 
	LENGTH(customer_first_name) < 4;

# First Names ending with E or e

SELECT
	*
FROM
	customer
WHERE 
	customer_first_name LIKE '%e' OR customer_first_name LIKE "%E";

# Names with second letter as a or A

SELECT 
	*
FROM
	customer
WHERE
	customer_first_name LIKE '_a%' OR customer_first_name LIKE '_A%' ;

# Last Names where second last letter is n or N

SELECT 
	*
FROM
	customer
WHERE
	customer_last_name LIKE '%n_' OR customer_last_name LIKE '%N_' ;
    
# Full names where letters ri come in sequence - ignore case and spaces

SELECT 
	*
FROM
	customer
WHERE
	CONCAT(customer_first_name, customer_last_name) LIKE '%ri%';
    
# Aggregating Functions
# Combining into one value

# SUM, AVG, COUNT, MIN, MAX

SELECT 
	SUM(quantity), AVG(quantity), COUNT(quantity), MAX(quantity), MIN(quantity)
FROM
	customer_purchases;
    
# We cannot mix a non aggregated value with a non aggregated values

# NULL Values

SELECT
	*
FROM
	product;
    
SELECT
	*
FROM
	product
WHERE 
	product_qty_type IS NULL;
        
# Since NULL is not a value, we cannot use = to compare
# Null is the absence of values

SELECT
	*
FROM
	product
WHERE 
	product_size IS NULL;
    
SELECT
	*
FROM
	product
WHERE 
	product_size IS NOT NULL;
    
SELECT
	*
FROM
	product
WHERE 
	LOWER(product_qty_type) = "null";
    
SELECT
	*
FROM
	product
WHERE 
	LOWER(product_size) = "null";
    
# Find the smallest and largest first names of customer in alphabetical order

SELECT 
	MIN(customer_first_name),
    MAX(customer_first_name),
    COUNT(customer_first_name)
FROM 
	customer;
    
