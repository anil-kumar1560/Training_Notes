-- 1. Identify if there are duplicates in Customer table. Don't use customer id to check the duplicates

select first_name,last_name,email, count(*) as count from sakila.customer group by first_name,last_name,email having count(*) >1;

-- 2. Number of times letter 'a' is repeated in film descriptions
select description,length(description) from sakila.film;
select description, (length(description) - length(replace(lower(description),'a',''))) as count_of_a from sakila.film;
select sum(length(description) - length(replace(lower(description),'a',''))) as count_of_a from sakila.film;

-- 3. Number of times each vowel is repeated in film descriptions 
select sum(length(description) - length(replace(lower(description),'a',''))) as a_count,
sum(length(description) - length(replace(lower(description),'e',''))) as e_count,
sum(length(description) - length(replace(lower(description),'i',''))) as i_count,
sum(length(description) - length(replace(lower(description),'o',''))) as o_count,
sum(length(description) - length(replace(lower(description),'u',''))) as u_count
 from sakila.film;

-- 4. Display the payments made by each customer
--        1. Month wise
--		2. Year wise
--       3. Week wise
select customer_id,month(payment_date),sum(amount) from sakila.payment group by customer_id,month(payment_date) ;
select customer_id,year(payment_date),sum(amount) from sakila.payment group by customer_id,year(payment_date) ;
select customer_id,week(payment_date),sum(amount) from sakila.payment group by customer_id,week(payment_date) ;

-- 5. Check if any given year is a leap year or not.
-- You need not consider any table from sakila database. Write within the select query with hardcoded date

SELECT 
    2024 AS given_year,
    CASE 
        WHEN (2024 % 400 = 0) OR (2024 % 4 = 0 AND 2024 % 100 <> 0)
            THEN 'Leap Year'
        ELSE 'Not a Leap Year'
    END AS result;
    
-- 6. Display number of days remaining in the current year from today.
select datediff(last_day(concat(year(curdate()),'-12-01')),
curdate()) as num;

-- 7. Display quarter number(Q1,Q2,Q3,Q4) for the payment dates from payment table. 
select payment_id, customer_id,rental_id,amount,payment_date,
case 
 when quarter(payment_date)=1 then 'Q1'
 when quarter(payment_date)=2 then 'Q2'
 when quarter(payment_date)=3 then 'Q3'
 else 'Q4'
end as quarter 
 from sakila.payment;

-- 8. Display the age in year, months, days based on your date of birth. 
-- For example: 21 years, 4 months, 12 days
  
  SET @dob = DATE('2000-01-01');  
  
select 
   timestampdiff(year,@dob,curdate()) as years, -- years
  (timestampdiff(month,@dob,curdate()) - timestampdiff(year,@dob,curdate())*12) as months, -- months
datediff(curdate(),
date_add(
date_add(@dob, Interval timestampdiff(year,@dob,curdate()) year), 
interval timestampdiff(month,@dob,curdate()) - timestampdiff(year,@dob,curdate())*12 month
)) as days																						-- days