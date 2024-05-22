# Window Functions

SELECT *
FROM (SELECT 
	*, MAX(customer_id) OVER() AS `Max_Value`,SUM(customer_id) OVER() AS `Sum_Value`,
    LENGTH(customer_first_name) AS `Len_FN`,
    AVG(LENGTH(customer_first_name)) OVER() AS `Avg_FN`
FROM customer) AS `T`
WHERE T.Len_FN  > T.Avg_FN;

SELECT 
	*,
    MAX(customer_id) OVER(PARTITION BY customer_zip) AS `Max_Val`
FROM
	customer;
    
# For erery row display market date, cust id, quantity, avg qty in full table

SELECT 
	market_date, customer_id, quantity, AVG(quantity) OVER() AS `avg_of_quantity`
FROM
	customer_purchases;

# next to each row, display the avg qty for that customer

SELECT
	customer_id, quantity, ROUND(AVG(quantity) OVER(PARTITION BY customer_id),2) AS `avg_quantity_per_customer`
FROM
	customer_purchases;
    
# RANKING FUNCTIONS

# RANK - Will have missing values
# DENSE RANK - no gaps

SELECT
	*,
    LENGTH(customer_first_name) AS `Length_of_FN`,
    RANK() OVER(ORDER BY LENGTH(customer_first_name) DESC) AS `Rank`,
    DENSE_RANK() OVER(ORDER BY LENGTH(customer_first_name) DESC) AS `Dense_Rank`,
    ROW_NUMBER() OVER(ORDER BY LENGTH(customer_first_name) DESC) AS `Row_Number`
FROM 
	customer;
    
# Partition by zip codes and use rank

SELECT
	*, 
    RANK() OVER(PARTITION BY customer_zip ORDER BY customer_id ASC) AS `Rank`,
    DENSE_RANK() OVER(PARTITION BY customer_zip ORDER BY customer_id ASC) AS `Dense_Rank`
FROM
	customer;
    
SELECT
	*, 
    RANK() OVER() AS `Rank`,
    DENSE_RANK() OVER() AS `Dense_Rank`,
    ROW_NUMBER() OVER() AS `Row_Number`
FROM
	customer;

# N_TILE
# Generates group number

SELECT
	*, NTILE(4) OVER(ORDER BY customer_id ASC) AS `Group`
FROM
	customer
;

# NTILE Becomes PERCENTILE WHEN There are 100 Groups

# WINDOW FRAMES

SELECT customer_id, SUM(customer_id) OVER(ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM customer;

SELECT customer_id, SUM(customer_id) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM customer;

SELECT customer_id, SUM(customer_id) OVER(ROWS BETWEEN CURRENT ROW AND CURRENT ROW)
FROM customer;

SELECT customer_id, SUM(customer_id) OVER(ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)
FROM customer;

SELECT customer_id, SUM(customer_id) OVER(ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING), SUM(customer_id) OVER(ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING)
FROM customer;

# Find the day which had the most number of transactions

SELECT
	DISTINCT market_date, COUNT(*) OVER(PARTITION BY EXTRACT(DAY FROM market_date)) AS `Count`
FROM 
	customer_purchases
ORDER BY Count DESC;

SELECT
	*
FROM 
	customer_purchases
WHERE market_date = "2020-08-05";

SELECT transaction_time, customer_id, quantity, SUM(quantity) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS `Cumulative_Quantity`
FROM customer_purchases
WHERE market_date = "2020-08-05"
ORDER BY transaction_time ASC;

# For every transaction, give the change over the previous transaction

SELECT transaction_time, customer_id, quantity, SUM(quantity) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS `Cumulative_Quantity`,
	SUM(quantity) OVER(ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS `Change_Over`#,
    #quantity - SUM(quantity) OVER(ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS `Q-C`
FROM customer_purchases
WHERE market_date = "2020-08-05"
ORDER BY transaction_time ASC;

# Average of last 3 transaction

SELECT transaction_time, customer_id, quantity,AVG(quantity) OVER(ORDER BY transaction_time ASC ROWS BETWEEN 2 PRECEDING and CURRENT ROW) `avg_last_3_rows`
FROM customer_purchases
WHERE market_date = "2020-08-05"
ORDER BY transaction_time ASC;

# Value Extraction Function

SELECT customer_id,customer_first_name,
	FIRST_VALUE(customer_first_name) OVER(ORDER BY customer_id ASC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),
    NTH_VALUE(customer_first_name,3) OVER(ORDER BY customer_id ASC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),
    LEAD(customer_first_name) OVER(ORDER BY customer_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),
    LAG(customer_first_name) OVER(ORDER BY customer_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM customer;