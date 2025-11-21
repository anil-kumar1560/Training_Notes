-- STRINGS


-- LPAD
select * from sakila.customer;

SELECT customer_id, first_name,LPAD(first_name, 10, '*') AS padded_name
FROM sakila.customer LIMIT 5;

-- RPAD
SELECT customer_id, first_name,RPAD(first_name, 10, '*') AS padded_name
FROM sakila.customer LIMIT 5;

-- Substring
SELECT title, SUBSTRING(title, 1, 3) AS first_three_letters FROM sakila.film LIMIT 5;

SELECT rental_id, rental_date, SUBSTRING(rental_date, 1, 4) AS rental_year
FROM sakila.rental LIMIT 5;

-- Concatination
SELECT customer_id, first_name, last_name,
       CONCAT(first_name, ' ', last_name) AS full_name
FROM sakila.customer LIMIT 5;

-- Reverse 
SELECT title, REVERSE(title) AS reversed_title FROM sakila.film LIMIT 5;

-- Length
SELECT title, length(title) AS title_length
FROM sakila.film LIMIT 5;

-- Locate 
SELECT title, locate('A',title) as index_of_R  FROM sakila.film LIMIT 5;

-- Substring Index
select email, substring_index(email,'@',1) as fullname from sakila.customer limit 5; 

select email, substring_index(email,'.',-1) as Domain from sakila.customer limit 5; 
select email, substring_index(email,'.',1) as Domain from sakila.customer limit 5; 

-- Upper and Lower
SELECT first_name, Lower(first_name) AS lower_name FROM sakila.customer LIMIT 5;

SELECT first_name, Upper(first_name) AS upper_name FROM sakila.customer LIMIT 5;

-- left and right
SELECT title, LEFT(title, 3) AS first_three_letters FROM sakila.film LIMIT 5;

SELECT title, Right(title, 3) AS first_three_letters FROM sakila.film LIMIT 5;

-- CASE Function

select title, length,
	case 
		when length <50 then 'Short'
        when length between 50 and 120 then 'Medium'
        else 'Long'
	END as length_category
from sakila.film limit 10;
    
    
SELECT first_name, last_name, active,
       CASE
           WHEN active = 1 THEN 'Active Customer'
           ELSE 'Inactive Customer'
       END AS status
FROM sakila.customer
LIMIT 10;

-- Replace
SELECT email, REPLACE(email, '.', '@') AS email_with_spaces FROM sakila.customer LIMIT 5;

-- Regular Expressions
-- Names starting with X, Y, Z
SELECT customer_id, first_name, last_name
FROM sakila.customer WHERE first_name REGEXP '^[XYZ]';

-- Names ending with X, Y, Z
SELECT customer_id, first_name, last_name
FROM sakila.customer WHERE first_name REGEXP '[XYZ]$';

-- Emails Ending with .org and .net
SELECT email FROM sakila.customer
WHERE email REGEXP '\\.(org|net)$';

-- last name with exactly 5 letters
 select customer_id, first_name, last_name from sakila.customer where last_name regexp '^[A-Za-z]{5}$' limit 5;
 
 -- Titles that contain the word 'Love' or 'Heart'
 select film_id, title from sakila.film where title regexp 'Love|heart';
 
 -- CAST
SELECT payment_id, amount,
       CAST(amount AS SIGNED) AS amount_int
FROM sakila.payment LIMIT 5;


SELECT payment_id, amount,
       CAST(amount AS CHAR) AS amount_int
FROM sakila.payment LIMIT 5;
 
 
 -- RAND() random movie titles
SELECT film_id, title FROM sakila.film
ORDER BY RAND() LIMIT 5;
 
 -- Power 
 SELECT film_id, title, rental_duration,
       POWER(rental_duration, 2) AS rental_duration_squared FROM sakila.film LIMIT 5;

-- Floor
SELECT payment_id, amount, FLOOR(amount) AS amount_floor FROM sakila.payment LIMIT 5;

-- CEIL
SELECT payment_id, amount, Ceil(amount) AS amount_floor FROM sakila.payment LIMIT 5;

-- MOD
SELECT customer_id, first_name, last_name, MOD(customer_id, 2) AS is_odd
FROM sakila.customer LIMIT 10;

-- TRIM
select ('  Hello  ') as text;
-- output: '  Hello  '
SELECT TRIM('   HELLO   ') AS trimmed_text;
-- output:  'HELLO'
-- LTRIM
SELECT LTRIM('   HELLO          ') AS trimmed_text;
--  output : 'HELLO          '
-- RTRIM
SELECT RTRIM('   HELLO          ') AS trimmed_text;
-- output: '   HELLO'

-- INSTR (Similar to Locate)
SELECT title, INSTR(title, 'Love') AS pos_of_love FROM sakila.film where title regexp 'Love' LIMIT 10;

-- Concatenate with separator
SELECT CONCAT_WS(' -- ', concat(first_name,' ', last_name), email) AS info FROM sakila.customer LIMIT 5;

-- Repeat
SELECT first_name, REPEAT('*', length(first_name)) AS stars
FROM sakila.customer LIMIT 10;

-- SPACE
SELECT CONCAT(first_name, SPACE(3), last_name) AS full_name_with_gap FROM sakila.customer LIMIT 10;

-- INSERT
SELECT title, INSERT(title, 2, 5, 'XXXX') AS modified_title FROM sakila.film LIMIT 10;

-- FORMAT
SELECT amount, FORMAT(amount, 3) AS formatted_amount FROM sakila.payment LIMIT 5;
--  '2.99', '2.990'

-- ASCII
SELECT first_name,
       ASCII(first_name) AS first_char_code
FROM sakila.customer LIMIT 5;


