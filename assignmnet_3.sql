-- 1. display all customer details who have made more than 5 payments.
select c.customer_id, c.first_name, c.last_name,c.email from sakila.customer c
where (select count(*) from sakila.payment p where c.customer_id=p.customer_id) >5;


-- 2. Find the names of actors who have acted in more than 10 films.

select * from sakila.actor where actor_id in (select actor_id from sakila.film_actor group by actor_id having count(*)>10);

SELECT a.actor_id, a.first_name, a.last_name,
    (
        SELECT COUNT(*) 
        FROM sakila.film_actor fa
        WHERE fa.actor_id = a.actor_id
    ) AS film_count
FROM sakila.actor a HAVING film_count > 10;

-- 3. Find the names of customers who never made a payment.
select * from sakila.customer where customer_id not in (select distinct customer_id from sakila.payment);

-- 4. List all films whose rental rate is higher than the average rental rate of all films.

select film_id,title,description, rental_rate from sakila.film where rental_rate > (select AVG(rental_rate) from sakila.film);

-- 5. List the titles of films that were never rented.
select film_id,title from sakila.film where film_id not in (
select film_id from sakila.inventory i join sakila.rental r on i.inventory_id=r.inventory_id);


-- 6. Display the customers who rented films in the same month as customer with ID 5. -- ask ruchik
select distinct c.customer_id,c.first_name,c.last_name from sakila.customer c join sakila.rental r on c.customer_id=r.customer_id
 where month(r.rental_date) 
 in( select distinct month(rental_date) from sakila.rental where customer_id =5 );

-- 7. Find all staff members who handled a payment greater than the average payment amount.
select distinct s.staff_id, s.first_name,s.last_name from sakila.staff s join sakila.payment p on s.staff_id=p.staff_id where amount >
(select avg(amount) from sakila.payment);

-- 8. Show the title and rental duration of films whose rental duration is greater than the average.
select title, rental_duration from sakila.film where rental_duration>
(select avg(rental_duration) from sakila.film);

-- 9. Find all customers who have the same address as customer with ID 1.

select * from sakila.address;
select * from sakila.customer where address_id=5;
SELECT * FROM sakila.customer WHERE address_id = (
    SELECT address_id
    FROM sakila.customer
    WHERE customer_id = 1
)
AND customer_id <> 1;

-- 10. List all payments that are greater than the average of all payments.
select * from sakila.payment where amount > (
select avg(amount) from sakila.payment);