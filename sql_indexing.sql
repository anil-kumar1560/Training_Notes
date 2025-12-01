-- Natural key (A natural key is a primary key that comes from real-world data.
-- It already exists naturally in the business.)
-- Examples are SSN, Email, Phone Number,....


-- Surrogate Key (A surrogate key is a primary key that does NOT come from real-world data.
-- It is artificial, created by the database.)
-- Examples are Auto Increment IDs,Random numeric identifier (10001) 

-- Indexing (fast search, fast filtering, fast joins.)
-- Without index → MySQL scans every row in the table (FULL TABLE SCAN).
-- With index → MySQL jumps directly to the matching rows.
-- Indexes use B-Tree structures:
-- Think of it like a sorted tree.
-- MySQL quickly jumps through levels: root → branch → leaf
-- Makes searching O(log n) instead of O(n).

-- Index on one coulmn
CREATE INDEX idx_customer_email ON customer(email);

-- Index on Multiple columns (Composite Index)
CREATE INDEX idx_city_postal ON address(city_id, postal_code);

-- Dropping an Index(Deleting)
DROP INDEX idx_customer_email ON customer;

-- How to see Index
SHOW INDEX FROM customer;

CREATE DATABASE IF NOT EXISTS index_demo;
USE index_demo;

DROP TABLE IF EXISTS customers_no_index;

CREATE TABLE customers_no_index (
    id INT AUTO_INCREMENT PRIMARY KEY,   -- clustered index
    name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
    age INT
) ENGINE = InnoDB;

-- We’ll insert 100,000 rows using a stored procedure and a loop.
DELIMITER $$
CREATE PROCEDURE fill_customers()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 100000 DO
        INSERT INTO customers_no_index (name, email, city, age)
        VALUES (
            CONCAT('Name', i),
            CONCAT('user', i, '@example.com'),
            IF(i % 2 = 0, 'Hyderabad', 'Mumbai'),
            FLOOR(18 + RAND() * 40)
        );
        SET i = i + 1;
    END WHILE;
END $$
DELIMITER ;

CALL fill_customers();
select count(*) from customers_no_index;

EXPLAIN
SELECT *
FROM customers_no_index
WHERE email = 'user50@example.com';

CREATE INDEX idx_email ON customers_no_index(email);
DROP INDEX idx_email ON customers_no_index;

EXPLAIN
SELECT count(*)
FROM customers_no_index
WHERE city = 'Hyderabad';

CREATE INDEX idx_city ON customers_no_index(city);
DROP INDEX idx_city ON customers_no_index;
