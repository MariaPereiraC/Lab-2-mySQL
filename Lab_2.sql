USE Sakila;
#Use the sakila database to do the following tasks:

#Display all available tables in the Sakila database.
Show Tables  ; 

#Retrieve all the data from the tables actor, film and customer.
Select * From actor ;
Select * From film ; 
Select * From customer ;

#1. Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
Select max(length) as max_duration, min(length) as min_duration From film ;

#Express the average movie duration in hours and minutes. Don't use decimals. Hint: Look for floor and round functions.
Select * From film ; 
#assuming that the length is displayed in minutes
SELECT
  title, length,
  CONCAT(
    length DIV 60,   -- Get the hours part
    ' hours ',
    length % 60,    -- obtain the remainder 
    ' minutes'
  ) AS converted_time
FROM
  film;
  
#2. You need to gain insights related to rental dates:
#2.1 Calculate the number of days that the company has been operating.
#Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
Select * from rental;
SELECT
  MAX(rental_date) AS last_rental_date,
  MIN(rental_date) AS first_rental_date,
  DATEDIFF(MAX(rental_date), MIN(rental_date)) AS company_ops_time
FROM
  rental;
  
#2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.  
  Select * from rental;
  SELECT *, 
  Monthname(rental_date) as rental_month,
  Dayname(rental_date) as rental_weekday
  FROM rental
  Limit 20;
  
  #3. You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
  Select title, rental_duration From film;
  Select title, IFNULL(rental_duration, 'Not Available') AS updated_duration FROM film
    ORDER BY title ASC;
  
#CHALLENGE 2
#Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
#1.1 The total number of films that have been released.
Select count(distinct title) from film;

#1.2 The number of films for each rating.
Select * from film;
SELECT rating, count(film_id) AS number_of_films FROM film
GROUP BY rating;

#1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
  Select * from film;
SELECT rating, count(film_id) AS number_of_films FROM film
GROUP BY rating
ORDER BY count(film_id) DESC;



#2Using the film table, determine:
#2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
Select * from film;
SELECT rating, round( avg(length),2) AS mean_film_duration FROM film
GROUP BY rating
ORDER BY round( avg(length),2) DESC;

#2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.  
SELECT rating, round( avg(length),2) AS mean_film_duration FROM film
GROUP BY rating
HAVING mean_film_duration > 120;  