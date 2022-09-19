-- How many copies of the film Hunchback Impossible exist in the inventory system?
select * from sakila.film where title = "Hunchback Impossible";
select * from sakila.inventory;
select f.film_id, count(i.film_id)
from sakila.film f
JOIN sakila.inventory i
ON  f.film_id = i.film_id
where i.film_id = "439";

-- List all films whose length is longer than the average of all the films
select avg(length) from sakila.film;
select * from sakila.film; 
SELECT film_id, title, length FROM film
WHERE length > (
  SELECT avg(length)
  FROM film
);
;

-- Use subqueries to display all actors who appear in the film Alone Trip
select * from sakila.film_actor;
select * from sakila.film;

select *  from film_actor where film_id = 17;

select * from film where title = "alone Trip";

SELECT last_name, first_name
FROM actor
where actor_id in 
(select actor_id from film_actor
where film_id in
(select film_id from film
where title = "Alone Trip"));

-- Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films
select * from sakila.category;
select * from sakila.film_category;
SELECT title FROM film
WHERE film_id in
	(SELECT film_id FROM film_category
	WHERE category_id in 
		(SELECT category_id FROM category
		WHERE name = "family"));

-- Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.
select * from sakila.customer;
select * from sakila.country;
select * from sakila.adress;
select * from sakila.city;

SELECT first_name, last_name, email FROM customer
WHERE address_id in
	(SELECT address_id FROM address
    WHERE city_id IN
    (SELECT city_id FROM city
    WHERE country_id IN
    (SELECT country_id FROM country
    WHERE country='CANADA')));
    
-- Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.
SELECT actor_id, COUNT(film_id) FROM film_actor
GROUP by actor_id
ORDER by COUNT(film_id) DESC;

SELECT * FROM film
WHERE film_id IN (
SELECT film_id FROM film_actor
WHERE actor_id= '107');

-- Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments
select * from sakila.customer;
select * from sakila.payment;

SELECT customer_id, SUM(amount) FROM payment
GROUP by customer_id
ORDER by SUM(amount) DESC
LIMIT 1; -- customer_id =526 is the most profitable

SELECT * FROM film
WHERE film_id IN (
SELECT film_id FROM inventory
WHERE inventory_id IN (
SELECT inventory_id FROM rental
WHERE customer_id='526'));

-- Customers who spent more than the average payments.
SELECT * FROM sakila.payment;
SELECT * FROM customer
WHERE customer_id IN (
SELECT customer_id FROM payment
WHERE amount> (SELECT 
AVG(amount) FROM payment));

