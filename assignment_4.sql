use sakila;
-- 1. List all customers along with the films they have rented.
SELECT c.customer_id, c.first_name, c.last_name, f.film_id, f.title AS film_title
FROM customer c
JOIN rental r ON r.customer_id = c.customer_id
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film f ON f.film_id = i.film_id
ORDER BY c.customer_id, f.title;

-- 2. List all customers and show their rental count, including those who haven't rented any films.
SELECT  c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS rental_count
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY  c.customer_id, c.first_name, c.last_name
ORDER BY  rental_count DESC,  c.customer_id;
select * from customer;

-- 3. Show all films along with their category. Include films that don't have a category assigned.
SELECT f.film_id, f.title, c.name AS category_name
FROM film f
LEFT JOIN film_category fc ON f.film_id = fc.film_id
LEFT JOIN category c ON fc.category_id = c.category_id
ORDER BY f.title;

select * from film;

-- 4. Show all customers and staff emails from both customer and staff tables using a full outer join (simulate using LEFT + RIGHT + UNION).
-- Part 1: Customers + matching staff (and customers with no staff)
use sakila;
SELECT 
    c.customer_id,
    c.first_name   AS customer_first_name,
    c.last_name    AS customer_last_name,
    c.email        AS customer_email,
    s.staff_id,
    s.first_name   AS staff_first_name,
    s.last_name    AS staff_last_name,
    s.email        AS staff_email
FROM customer c
LEFT JOIN staff s
    ON c.email = s.email
UNION
-- Part 2: Staff with no matching customers (RIGHT JOIN side)
SELECT 
    c.customer_id,
    c.first_name   AS customer_first_name,
    c.last_name    AS customer_last_name,
    c.email        AS customer_email,
    s.staff_id,
    s.first_name   AS staff_first_name,
    s.last_name    AS staff_last_name,
    s.email        AS staff_email
FROM customer c
RIGHT JOIN staff s
    ON c.email = s.email
WHERE c.customer_id IS NULL;   -- avoid duplicates already returned above


-- 5. Find all actors who acted in the film "ACADEMY DINOSAUR".

SELECT a.actor_id, a.first_name, a.last_name
FROM actor a
JOIN film_actor fa  ON a.actor_id = fa.actor_id
JOIN film f  ON fa.film_id = f.film_id
WHERE f.title = 'ACADEMY DINOSAUR';


-- 6. List all stores and the total number of staff members working in each store, even if a store has no staff.

SELECT s.store_id, COUNT(st.staff_id) AS staff_count
FROM store s
LEFT JOIN staff st ON s.store_id = st.store_id
GROUP BY s.store_id
ORDER BY s.store_id;

select * from staff;

-- 7. List the customers who have rented films more than 5 times. Include their name and total rental count.
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS rental_count
FROM customer c
JOIN rental r
    ON c.customer_id = r.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
HAVING
    COUNT(r.rental_id) > 5
ORDER BY
    rental_count DESC;
