# Date and Time Functions

# Get current date and time

SELECT current_date();
SELECT current_time();
select current_timestamp();

# Extract Components

SELECT EXTRACT(HOUR FROM current_time());

# Add / Subtract Date

SELECT DATE_ADD(current_date(),INTERVAL 3 DAY);

# Date Difference