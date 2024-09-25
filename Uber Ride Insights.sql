select * from drivers d ;
select * from passengers p ;
select * from rides r ;

#What are & how many unique pickup locations are there in the dataset?
select pickup_location  from rides r group by pickup_location ;

SELECT COUNT(DISTINCT pickup_location) from rides r ;

#2.           What is the total number of rides in the dataset?
select count(ride_id)Total_NO_of_Rides from rides r ;


#3.           Calculate the average ride duration.
select avg(ride_duration) from rides r ;
-- 
-- 4.           List the top 5 drivers based on their total earnings.
select driver_id, sum(earnings)Total_Earnings from drivers d group by driver_id order by  Total_Earnings desc limit 5;
-- 
-- 5.           Calculate the total number of rides for each payment method.
select count(ride_id)Total_NO_of_Rides, payment_method  from rides r group by payment_method ;


-- 6.           Retrieve rides with a fare amount greater than 20.
select * from rides r order by fare_amount >20;
-- 
-- 7.           Identify the most common pickup location.
select pickup_location, count(*)Total_Rides from rides r group by pickup_location order by Total_Rides desc limit 1 ;

-- 
-- 8.           Calculate the average fare amount.
select avg(fare_amount) from rides r ;
-- 
-- 9.           List the top 10 drivers with the highest average ratings.
select driver_id , avg(rating)Avg_Ratings from drivers d group by driver_id order by Avg_Ratings desc limit 10;
-- 
-- 10.      Calculate the total earnings for all drivers.
select sum(earnings) from drivers d ;
-- 
-- 11.      How many rides were paid using the "Cash" payment method?
select payment_method,  count(*) from rides r where payment_method ="Cash";
-- 
-- 12.      Calculate the number of rides & average ride distance for rides originating from the 'Dhanbad' pickup location.
select pickup_location, count(*)Total_Rides, avg(ride_distance) from rides r  where pickup_location ="Dhanbad";
-- 
-- 13.      Retrieve rides with a ride duration less than 10 minutes.
select * from rides r order by ride_duration <10 ;

-- 
-- 14.      List the passengers who have taken the most number of rides.
select passenger_name  , count(*)rides_count   from passengers p group by passenger_name  order by rides_count desc ;
select passenger_name  , count(*)rides_count   from passengers p group by passenger_name  order by rides_count desc limit 1;

-- 
-- 15.      Calculate the total number of rides for each driver in descending order.
select driver_id ,  count(*)total_rides from rides r group by driver_id order by total_rides desc;

-- 
-- 16.      Identify the payment methods used by passengers who took rides from the 'Gandhinagar' pickup location.
select payment_method , passenger_id from rides r where pickup_location ="Gandhinagar";
-- 
-- 17.      Calculate the average fare amount for rides with a ride distance greater than 10.
select avg(fare_amount)Avg_amount from rides r order by ride_distance >10;
-- 
-- 18.      List the drivers in descending order accordinh to their total number of rides.
select driver_id ,total_rides from drivers d  order by total_rides  desc ;
-- 
-- 19.      Calculate the percentage distribution of rides for each pickup location.
SELECT pickup_location, COUNT(*) AS ride_count, ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) from rides r ) , 2) AS percentage 
FROM rides r GROUP BY pickup_location order by percentage desc;
-- 
-- 20.      Retrieve rides where both pickup and dropoff locations are the same.
select *  from rides r where pickup_location = dropoff_location ;
-- 
-- 
-- 
-- Intermediate Level:     
-- 
--                  
-- 
-- -- 1.           List the passengers who have taken rides from at least 300 different pickup locations.
select passenger_id , count(DISTINCT pickup_location)different_pickup_loction  from rides r group by passenger_id having different_pickup_loction >= 300;
-- -- 
-- -- 2.           Calculate the average fare amount for rides taken on weekdays.
select avg(fare_amount) from rides r WHERE DAYOFWEEK(STR_TO_DATE(ride_timestamp, '%m/%d/%Y %H:%i'))>5;
select ride_timestamp, (STR_TO_DATE(ride_timestamp)) from rides r;
-- -- 
-- -- 3.           Identify the drivers who have taken rides with distances greater than 19.
 select driver_id , ride_distance  from rides r where ride_distance > 19;
-- -- 
-- -- 4.           Calculate the total earnings for drivers who have completed more than 100 rides.
SELECT driver_id, SUM(earnings) AS total_earnings FROM drivers d 
WHERE driver_id IN (SELECT driver_id FROM rides r GROUP BY driver_id HAVING COUNT(*) > 100)
GROUP BY driver_id;

select driver_id , sum(earnings) from drivers d group by driver_id having count(*)>100;

-- -- 5.           Retrieve rides where the fare amount is less than the average fare amount.
select * from rides r where fare_amount <(select Avg(fare_amount) from rides r) ; 
)
-- -- 
-- -- 6.           Calculate the average rating of drivers who have driven rides with both 'Credit Card' and 'Cash' payment methods.

select driver_id , avg(rating)AVG_ratings from drivers d 
where driver_id in (select driver_id from rides r where payment_method in ("Case" , "Credit Card")) group by driver_id ;


-- -- 
-- -- 7.           List the top 3 passengers with the highest total spending.
select passenger_id, passenger_name , sum(total_spent)sum_spend from passengers p group by passenger_id, passenger_name  order by sum_spend desc limit 3;

SELECT p.passenger_id, p.passenger_name, SUM(r.fare_amount) AS total_spending
FROM passengers p JOIN Rides r ON p.passenger_id = r.passenger_id
GROUP BY p.passenger_id, p.passenger_name ORDER BY total_spending desc LIMIT 3;

-- 
-- -- 
-- -- 8.           Calculate the average fare amount for rides taken during different months of the year.

SELECT MONTH(STR_TO_DATE(ride_timestamp, '%m/%d/%Y %H:%i')) month_of_year, AVG(fare_amount)avg_fare FROM Rides GROUP BY month_of_year;
-- -- 
-- -- 9.           Identify the most common pair of pickup and dropoff locations.
SELECT pickup_location, dropoff_location, COUNT(*)ride_count FROM rides r GROUP BY pickup_location, dropoff_location;
-- -- 
-- -- 10.      Calculate the total earnings for each driver and order them by earnings in descending order.
select driver_id , sum(earnings)total_earning from drivers d group by driver_id order by total_earning desc;
-- -- 
-- -- 11.      List the passengers who have taken rides on their signup date.
SELECT p.passenger_id, p.passenger_name FROM passengers p  JOIN Rides r ON p.passenger_id = r.passenger_id WHERE DATE(p.signup_date) = DATE(r.ride_timestamp);

-- -- 
-- -- 12.      Calculate the average earnings for each driver and order them by earnings in descending order.
SELECT driver_id, avg(earnings)average_earnings FROM drivers d  GROUP BY driver_id ORDER BY average_earnings DESC;



-- -- 13.      Retrieve rides with distances less than the average ride distance.
select ride_id , avg(ride_distance)avg_distance from rides r where ride_distance < (select avg(ride_distance)avg_distance from rides r) group by ride_id ;
-- -- 
-- -- 14.      List the drivers who have completed the least number of rides.
select driver_name , count(driver_id)total_rides_counts  from drivers d group by driver_name order by total_rides_counts asc;
select driver_name , count(total_rides)total_rides_counts  from drivers d group by driver_name order by total_rides_counts asc;


-- -- 
-- -- 15.      Calculate the average fare amount for rides taken by passengers who have taken at least 20 rides.
select avg(fare_amount) from rides r  order  by passenger_id in (select passenger_id from rides r  group by passenger_id having count(*)>= 20);

-- -- 
-- -- 16.      Identify the pickup location with the highest average fare amount.
select pickup_location , avg(fare_amount)amount_avg from rides r group by pickup_location order by amount_avg desc limit 1;
-- -- 
-- -- 17.      Calculate the average rating of drivers who completed at least 100 rides.
SELECT driver_id, avg(rating)avg_rating FROM drivers d 
WHERE driver_id IN (SELECT driver_id FROM rides r GROUP BY driver_id HAVING COUNT(*) > 100)
GROUP BY driver_id;

-- -- 
-- -- 18.      List the passengers who have taken rides from at least 5 different pickup locations.
select passenger_id , count(DISTINCT pickup_location)different_pickup_loction  from rides r group by passenger_id having different_pickup_loction >= 5;

-- -- 
-- -- 19.      Calculate the average fare amount for rides taken by passengers with ratings above 4.
SELECT passenger_id ,AVG(fare_amount) FROM rides WHERE passenger_id in (SELECT passenger_id FROM passengers p  WHERE rating > 4)group by passenger_id ;
-- 
-- #20.      Retrieve rides with the shortest ride duration in each pickup location.
select ride_id, ride_duration, pickup_location from rides where ride_duration= (select min(ride_duration) from rides);

-- 
-- 
-- 
-- Advanced Level:
-- 
-- #1.           List the drivers who have driven rides in all pickup locations.
select distinct driver_id,pickup_location from rides where pickup_location in (select distinct pickup_location from rides);



-- 
-- #2.           Calculate the average fare amount for rides taken by passengers who have spent more than 300 in total.
select passenger_id ,avg(fare_amount) from rides r where passenger_id in(select passenger_id from passengers p where total_spent>300) group by passenger_id ;
-- 
-- #3.           List the bottom 5 drivers based on their average earnings.
select driver_id , avg(earnings)avg_earning from drivers d group by driver_id order by avg_earning asc limit 5;
-- 
-- #4.           Calculate the sum fare amount for rides taken by passengers who have taken rides in different payment methods.
select passenger_id , SUM(fare_amount)FROM rides 
WHERE passenger_id IN (SELECT passenger_id FROM rides GROUP BY passenger_id HAVING COUNT(DISTINCT payment_method) > 1)group by passenger_id ;


-- 
-- #5.           Retrieve rides where the fare amount is significantly above the average fare amount.
SELECT * from rides r WHERE fare_amount > (SELECT AVG(fare_amount) from rides r2);

-- 
-- #6.           List the drivers who have completed rides on the same day they joined.


-- 
-- #7.           Calculate the average fare amount for rides taken by passengers who have taken rides in different payment methods.
SELECT AVG(fare_amount) FROM rides r WHERE passenger_id IN ( SELECT passenger_id FROM  rides r GROUP BY passenger_id
    HAVING COUNT(DISTINCT payment_method) > 1);
-- 
-- #8.           Identify the pickup location with the highest percentage increase in average fare amount compared to the overall average fare.
   SELECT pickup_location, AVG(fare_amount) AS avg_fare,
       (AVG(fare_amount) - (SELECT AVG(fare_amount) from rides r )) * 100.0 / (SELECT AVG(fare_amount) FROM rides r) AS percentage_increase
FROM rides r  GROUP BY pickup_location ORDER BY percentage_increase desc LIMIT 1;
-- 
-- #9.           Retrieve rides where the dropoff location is the same as the pickup location.
SELECT *FROM rides r WHERE pickup_location = dropoff_location;
-- 
-- #10.           Calculate the average rating of drivers who have driven rides with varying pickup locations.
select  AVG(rating) FROM drivers d  WHERE driver_id IN (SELECT DISTINCT driver_id FROM rides r  GROUP BY driver_id
    HAVING COUNT(DISTINCT pickup_location) > 1);

