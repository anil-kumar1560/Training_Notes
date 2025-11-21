-- Distinct
select distinct rating from sakila.film;

-- Count
select count(*) from sakila.film;

-- LIMIT
-- Top 10 Lengthy movies 
select * from sakila.film order by length desc LIMIT 10;

-- Where Clause
-- number of movies whose duration more than or equal to 3 hours
select count(*) from sakila.film where length>179;

-- Order By
-- Films ordered by A-Z
select film_id,title,length from sakila.film order by title;

-- using desc
select film_id,title,length from sakila.film order by title desc;

-- AND Operator
-- Active customers whose firstname start with 'J'
SELECT customer_id, first_name, last_name FROM sakila.customer
WHERE active = 1 AND first_name LIKE 'J%';

-- OR Operator
-- Films with rating 'PG' OR 'R'
SELECT film_id, title, rating FROM sakila.film
WHERE rating = 'PG' OR rating = 'R';

-- IN Operator
-- Films rating with 'PG' or 'R' or 'PG-13' 
SELECT film_id, title, rating FROM sakila.film
WHERE rating IN ('PG', 'PG-13', 'R');

-- NOT IN Operator
SELECT film_id, title, rating FROM sakila.film
WHERE rating NOT IN ('G', 'PG');

-- LIKE Operator
SELECT film_id, title FROM sakila.film
WHERE title LIKE '%LOVE%';

-- IS NULL Operator
SELECT customer_id, first_name, last_name, email
FROM sakila.customer WHERE email IS NULL;

-- Between Operator
SELECT film_id, title, length FROM sakila.film
WHERE length BETWEEN 90 AND 120;

-- Group by and Having clause
-- Number of flims in each rating
SELECT rating, COUNT(*) AS film_count FROM sakila.film GROUP BY rating;

SELECT rating, COUNT(*) AS film_count
FROM sakila.film GROUP BY rating HAVING COUNT(*) > 200;


