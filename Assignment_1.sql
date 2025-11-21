select * from sakila.customer;

--  1. Get all customers whose first name starts with 'J' and who are active.
select * from sakila.customer where first_name like 'J%' and active=1;

select * from sakila.film;

-- 2. Find all films where the title contains the word 'ACTION' or the description contains 'WAR'.
select * from sakila.film where title like '%ACTION%' or UPPER(description) like '%WAR%';

-- 3. List all customers whose last name is not 'SMITH' and whose first name ends with 'a'.
select count(*) from sakila.customer where last_name != 'SMITH' and first_name like '%a';

-- 4. Get all films where the rental rate is greater than 3.0 and the replacement cost is not null.
select * from sakila.film  where rental_rate>3.0 and replacement_cost is not NULL;


-- 5. Count how many customers exist in each store who have active status = 1.
select store_id, count(*) as total_customers  from sakila.customer where active=1 group by store_id;

-- 6. Show distinct film ratings available in the film table.
select distinct rating from sakila.film;

select rating,count(*) from sakila.film group by rating; 

-- 7. Find the number of films for each rental duration where the average length is more than 100 minutes.
select rental_duration, count(*) as film_count, AVG(length) as avg_length from sakila.film group by rental_duration having avg(length)>100;

SELECT rental_duration from sakila.film group by rental_duration having avg(length)=112.9913;

SELECT title, length, rental_duration,
    (SELECT AVG(length) 
     FROM sakila.film 
     WHERE rental_duration = 3) AS avg_length
FROM sakila.film
WHERE rental_duration = 3;

-- 8. List payment dates and total amount paid per date, but only include days where more than 100 payments were made.
select DATE(payment_date) as pay_date, SUM(amount), count(*) as total_count from sakila.payment group by DATE(payment_date) having count(*) >100 order by pay_date;
select * from sakila.payment;

-- 9. Find customers whose email address is null or ends with '.org'.
select * from sakila.customer where email is NULL or email  like '%.org';

-- 10. List all films with rating 'PG' or 'G', and order them by rental rate in descending order.
select * from sakila.film where rating IN ('PG','G') order  by rental_rate DESC;


-- 11. Count how many films exist for each length where the film title starts with 'T' and the count is more than 5.
SELECT length, COUNT(*) AS film_count
FROM sakila.film
WHERE title LIKE 'T%'          
GROUP BY length                
HAVING COUNT(*) > 5
ORDER BY film_count DESC,    
         length;
         
select title,length from sakila.film where title like 'T%' and length = 152;

-- 12. List all actors who have appeared in more than 10 films.
SELECT a.actor_id, a.first_name, a.last_name, COUNT(*) AS film_count FROM sakila.actor a
	JOIN sakila.film_actor fa ON fa.actor_id = a.actor_id
	GROUP BY a.actor_id, a.first_name, a.last_name
	HAVING COUNT(*) > 10;
    
-- 13. Find the top 5 films with the highest rental rates and longest lengths combined, ordering by rental rate first and length second.
SELECT film_id, title, rental_rate, length FROM sakila.film ORDER BY rental_rate DESC, length DESC LIMIT 5;

-- 14. Show all customers along with the total number of rentals they have made, ordered from most to least rentals.
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS total_rentals FROM sakila.customer c
JOIN sakila.rental r ON r.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_rentals DESC ;


-- 15 -List the film titles that have never been rented.
select f.film_id, f.title
FROM sakila.film f
WHERE NOT EXISTS (
  SELECT 1
  FROM sakila.inventory i
  JOIN sakila.rental r ON r.inventory_id = i.inventory_id
  WHERE i.film_id = f.film_id
)
ORDER BY f.title;

-- 16. Find all staff members along with the total payments they have processed, ordered by total payment amount in descending order.
SELECT s.staff_id,
       s.first_name,
       s.last_name,
       SUM(p.amount) AS total_processed
FROM sakila.staff s
LEFT JOIN sakila.payment p ON p.staff_id = s.staff_id
GROUP BY s.staff_id, s.first_name, s.last_name
ORDER BY total_processed DESC;

-- 17. Show the category name along with the total number of films in each category.
SELECT c.category_id,
       c.name AS category_name,
       COUNT(fc.film_id) AS film_count
FROM sakila.category c
JOIN sakila.film_category fc ON fc.category_id = c.category_id
GROUP BY c.category_id, c.name
ORDER BY film_count DESC, c.name;

-- 18. List the top 3 customers who have spent the most money in total.
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       SUM(p.amount) AS total_spent
FROM sakila.customer c
JOIN sakila.payment p ON p.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 3;


-- 19. Find all films that were rented in the month of May (any year) and have a rental duration greater than 5 days.

SELECT DISTINCT f.film_id, f.title, f.rental_duration
FROM sakila.film f
JOIN sakila.inventory i ON i.film_id = f.film_id
JOIN sakila.rental r   ON r.inventory_id = i.inventory_id
WHERE MONTH(r.rental_date) = 5
  AND f.rental_duration > 5
ORDER BY f.title;


-- 20. Get the average rental rate for each film category, but only include categories with more than 50 films.

SELECT c.category_id,
       c.name AS category_name,
       AVG(f.rental_rate) AS avg_rental_rate,
       COUNT(fc.film_id)  AS film_count
FROM sakila.category c
JOIN sakila.film_category fc ON fc.category_id = c.category_id
JOIN sakila.film f           ON f.film_id = fc.film_id
GROUP BY c.category_id, c.name
HAVING COUNT(fc.film_id) > 50
ORDER BY avg_rental_rate DESC, c.name;

select * from sakila.film;
select * from sakila.rental;
select * from sakila.inventory;


