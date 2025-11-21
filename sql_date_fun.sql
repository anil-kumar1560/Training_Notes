-- DATE DIFF
SELECT rental_id, rental_date, return_date, DATEDIFF(return_date, rental_date) AS rental_days FROM sakila.rental where DATEDIFF(return_date, rental_date)  >5 LIMIT 10;

-- MONTH (date)
SELECT rental_id, rental_date, MONTH(rental_date) AS rental_month FROM sakila.rental LIMIT 10;
-- Month Name
SELECT rental_id, rental_date, MONTHNAME(rental_date) AS rental_month_name FROM sakila.rental LIMIT 10;
-- Year
SELECT rental_id, rental_date, Year(rental_date) AS rental_month_name FROM sakila.rental LIMIT 10;
-- DATE
SELECT rental_id, rental_date, Date(rental_date) AS rental_month_name FROM sakila.rental LIMIT 10;

-- NOW()
SELECT NOW() AS current_datetime;

-- Interval 1 Day
SELECT rental_id, rental_date, DATE_ADD(rental_date, INTERVAL 1 DAY) AS expected_return_date FROM sakila.rental LIMIT 5;

-- DAYNAME(date)
SELECT rental_id, rental_date, DAYNAME(rental_date) AS rental_day_name FROM sakila.rental LIMIT 10;
-- DAY(date)
SELECT rental_id, rental_date, DAY(rental_date) AS rental_day_of_month FROM sakila.rental LIMIT 10;
-- DAYOFWEEK(date)
SELECT rental_id, rental_date, DAYOFWEEK(rental_date) AS weekday_num FROM sakila.rental LIMIT 10;
-- DAYOFYEAR(date)
SELECT payment_id, payment_date, DAYOFYEAR(payment_date) AS day_of_year FROM sakila.payment LIMIT 10;


-- Subqueries

-- Type 1.Single Row Subquery (Returns one value)
-- Films longer than the average length
SELECT film_id, title, length
FROM sakila.film
WHERE length > (SELECT AVG(length) FROM sakila.film);

-- Type 2.Multiple Row Subquery (Returns multiple rows)
-- Get all customers who have made at least one payment.
SELECT customer_id, first_name, last_name FROM sakila.customer
WHERE customer_id IN (
    SELECT DISTINCT customer_id
    FROM sakila.payment
);

-- Type 3.Multiple-Column Subquery (Returns multiple columns at once)
-- Films with same rental_rate AND length as another film
SELECT film_id, title, rental_rate, length
FROM sakila.film
WHERE (rental_rate, length) IN (
    SELECT rental_rate, length
    FROM sakila.film
    GROUP BY rental_rate, length
    HAVING COUNT(*) > 1
);


-- Type 4.Correlated subquery (Inner query depends on the outer query -> runs once per row.)
-- Get all rentals whose amount is greater than the average payment amount for that customer.
SELECT r.rental_id,
       r.customer_id,
       p.amount
FROM sakila.rental r
JOIN sakila.payment p ON r.rental_id = p.rental_id
WHERE p.amount > (
    SELECT AVG(p2.amount)
    FROM sakila.payment p2
    WHERE p2.customer_id = r.customer_id
);

-- Customers who made more than 5 rentals
SELECT c.customer_id, c.first_name
FROM customer c
WHERE (
    SELECT COUNT(*)
    FROM rental r
    WHERE r.customer_id = c.customer_id
) > 5;


-- Type 5.Subquery in SELECT Clause
-- Add total payments for each customer
SELECT 
    c.customer_id, 
    c.first_name,
    (SELECT SUM(amount) FROM sakila.payment p WHERE p.customer_id = c.customer_id) AS total_paid
FROM sakila.customer c;

-- Type 6.Subquery in FROM Clause (Inline View / Derived Table)
-- Find avg payment per customer using inline view
SELECT customer_id, avg_amount
FROM (
    SELECT customer_id, AVG(amount) AS avg_amount
    FROM sakila.payment
    GROUP BY customer_id
) AS t;

-- Type 7.EXISTS / NOT EXISTS Subquery
-- Customers who have never rented a movie
SELECT customer_id, first_name
FROM sakila.customer c
WHERE NOT EXISTS (
    SELECT 1 FROM sakila.rental r
    WHERE r.customer_id = c.customer_id
);
