-- A CTE is like creating a small temporary table using the WITH statement so that your main query becomes cleaner and easier to read.

-- without CTE
SELECT customer_id, avg_amount
FROM (
    SELECT customer_id, AVG(amount) AS avg_amount
    FROM sakila.payment
    GROUP BY customer_id
) AS temp
WHERE avg_amount > 5;

-- with CTE (scope: with in query)
WITH payment_avg AS (
    SELECT customer_id, AVG(amount) AS avg_amount
    FROM sakila.payment
    GROUP BY customer_id
)
SELECT customer_id, avg_amount
FROM payment_avg
WHERE avg_amount > 5;

-- example 2
-- List customers with their total payment amount
select c.customer_id,c.first_name,c.last_name,sum(p.amount) from sakila.customer c 
join sakila.payment p on c.customer_id=p.customer_id group by c.customer_id ;

-- Find customers whose total payments are greater than 100, and also show what percentage of the max total_payment they paid.
with customer_payment as(
select customer_id,sum(amount) as total_amount from sakila.payment group by customer_id
),
max_amount as (select sum(total_amount) as total_payment from customer_payment)
select c.customer_id, c.first_name, c.last_name, cp.total_amount,
round((cp.total_amount/ma.total_payment)*100,3) as percentage from sakila.customer c 
join customer_payment cp on c.customer_id=cp.customer_id join max_amount ma where cp.total_amount >100;

-- example 3
-- List films and their total rental count
select film_id, count(*) from sakila.inventory i join sakila.rental r on i.inventory_id=r.inventory_id group by film_id,inventory_id;

select * from sakila.inventory;

select inventory_id,count(*) from sakila.rental group by inventory_id; 

-- Recursive CTE

WITH RECURSIVE numbers AS (
    -- Anchor member (starting point)
    SELECT 1 AS n

    UNION ALL

    -- Recursive member (runs repeatedly)
    SELECT n + 1
    FROM numbers
    WHERE n < 10
)
SELECT * FROM numbers;


-- Temporary Table (scope: with in session)

CREATE TEMPORARY TABLE sakila.temp_customer_payments AS
SELECT customer_id, SUM(amount) AS total_payments
FROM sakila.payment
GROUP BY customer_id;

SELECT *
FROM sakila.temp_customer_payments
WHERE total_payments > 100;

--  Views
-- To simplify complex joins
-- To reuse logic in multiple queries
-- To hide sensitive columns
-- To make a query more readable
-- To avoid repeating large SELECT statements
CREATE VIEW sakila.customer_details AS
SELECT  c.customer_id, c.first_name,
    c.last_name,
    a.address,
    ci.city,
    co.country
FROM sakila.customer c
JOIN sakila.address a ON c.address_id = a.address_id
JOIN sakila.city ci ON a.city_id = ci.city_id
JOIN sakila.country co ON ci.country_id = co.country_id;

SELECT * FROM sakila.customer WHERE customer_id = 1;


-- Views that use: GROUP BY,DISTINCT,UNION,aggregates (SUM, COUNT, AVG),complex joins, subqueries
-- are generally considered non-updatable.

CREATE OR REPLACE VIEW sakila.customer_payment_summary AS
SELECT 
    customer_id,
    SUM(amount) AS total_payment
FROM sakila.payment
GROUP BY customer_id;

UPDATE sakila.customer_payment_summary
SET total_payment = 999
WHERE customer_id = 1;

