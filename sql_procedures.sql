-- Stored Procedures
-- A stored procedure is a block of SQL code saved in the database that you can execute whenever you want.

-- simple example: List all customers

DELIMITER //

CREATE PROCEDURE sakila.get_all_customers()
BEGIN
    SELECT customer_id, first_name, last_name
    FROM sakila.customer;
END //
DELIMITER ;
CALL sakila.get_all_customers();

-- Get all films by category (Procedure With Input Parameter)

DELIMITER $$

CREATE PROCEDURE sakila.get_films_by_category(IN cat_name VARCHAR(50))
BEGIN
    SELECT f.film_id, f.title
    FROM sakila.film f
    JOIN sakila.film_category fc ON f.film_id = fc.film_id
    JOIN sakila.category c ON fc.category_id = c.category_id
    WHERE c.name = cat_name;
END $$

DELIMITER ;

CALL sakila.get_films_by_category('Comedy');

-- Get payments in a date range (Procedure With Multiple Input Parameters)

DELIMITER $$
CREATE PROCEDURE sakila.get_payments_between(IN start_date DATE, IN end_date DATE)
BEGIN
    SELECT payment_id, customer_id, amount, payment_date
    FROM sakila.payment
    WHERE payment_date BETWEEN start_date AND end_date;
END $$
DELIMITER ;

CALL sakila.get_payments_between('2005-05-01', '2005-05-31');

-- Return total payments for a customer (Procedure With Output Parameter)
DELIMITER $$
CREATE PROCEDURE sakila.get_total_payment( IN cust_id INT, OUT total DECIMAL(10,2) )
BEGIN
    SELECT SUM(amount) INTO total
    FROM sakila.payment
    WHERE customer_id = cust_id;
END $$
DELIMITER ;

CALL sakila.get_total_payment(1, @total);
SELECT @total;

-- Dynamic Procedure
-- A dynamic stored procedure is a procedure that builds SQL statements as text and runs them using:
-- PREPARE, EXECUTE, (optional) DEALLOCATE PREPARE

-- Example 1(Dynamic procedure to get data from any table)
use sakila;

DELIMITER $$
CREATE PROCEDURE get_all_from_table(IN tbl_name VARCHAR(50))
BEGIN
    SET @sql = CONCAT('SELECT * FROM ', tbl_name);
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END $$
DELIMITER ;

CALL get_all_from_table('customer');

-- Example 2 (user passes column name + value)

DELIMITER $$
CREATE PROCEDURE search_customer_dynamic( IN column_name VARCHAR(50), IN column_value VARCHAR(100) )
BEGIN
    SET @sql = CONCAT('SELECT customer_id, first_name, last_name FROM customer WHERE ',column_name,' = ?');
    SET @val := column_value;
    PREPARE stmt FROM @sql;
    EXECUTE stmt USING @val;
    DEALLOCATE PREPARE stmt;
END $$
DELIMITER ;
DRop procedure search_customer_dynamic;

CALL search_customer_dynamic('customer_id', 1);

-- Example 3 
DELIMITER $$
CREATE PROCEDURE list_select_queries(IN db_name VARCHAR(64))
BEGIN
    SELECT CONCAT( 'SELECT * FROM ', TABLE_SCHEMA,'.',TABLE_NAME,';') AS select_query
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA = db_name
    ORDER BY TABLE_NAME;
END $$

DELIMITER ;

DRop procedure list_select_queries;

CALL list_select_queries('sakila');
