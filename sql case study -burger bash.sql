use burger_bash;

##Q.1)How many burgers were ordered?
select count(*) as 'no_of_orders'
from runner_orders;

##Q.2)How many unique customer orders were made?
select count(distinct order_id)as unique_orders
from customer_orders;

##Q.3)How many successful orders were delivered by each runner?
select runner_id,
count(distinct order_id) as successful_order
from runner_orders
where cancellation is null
group by runner_id
order by successful_order desc;

##Q.4)How many of each type of burger was delivered?
select b.burger_name,count(c.burger_id)as delivered_burger_count
from customer_orders as c
join runner_orders as r
on c.order_id=r.order_id
join burger_names as b
on b.burger_id=c.burger_id
where r.distance!=0
group by b.burger_name;

##Q.5)How many Vegetarian and Meatlovers were ordered by each customer?
select c.customer_id,b.burger_name,
count(b.burger_name)as order_count
from customer_orders as c
join burger_names as b
on c.burger_id=b.burger_id
group by c.customer_id,b.burger_name
order by c.customer_id;

##Q.6)What was the maximum number of burgers delivered in a single order?
WITH burger_count_cte AS
(
 SELECT c.order_id, COUNT(c.burger_id) AS burger_per_order
 FROM customer_orders AS c
 JOIN runner_orders AS r
  ON c.order_id = r.order_id
 WHERE r.distance != 0
 GROUP BY c.order_id
)
	select max(burger_per_order) as burger_count
    from burger_count_cte;
    
##Q.7)For each customer, how many delivered burgers had at least 1 change and how many had no changes?
select c.customer_id,
sum(case
when c.exclusions<>'' or c.extras<>''
then 1
else 0
end) as at_least_1_change,
sum(case
when c.exclusions='' and c.extras=''
then 1
else 0
end) as no_change
from customer_orders as c
join runner_orders as r
on c.order_id=r.order_id
where r.distance!=0
group by c.customer_id
order by c.customer_id;

##Q.8)What was the total volume of burgers ordered for each hour of the day?
select extract(hour from order_time)
as hour_of_day,
count(order_id) as burger_count
from customer_orders
group by extract(hour from order_time);

##Q.9)How many runners signed up for each 1 week period? 
select extract(week from registration_date)
as registration_week,
count(runner_id)as runner_signup
from burger_runner
group by extract(week from registration_date);

##Q.10)What was the average distance travelled for each customer?
select c.customer_id,avg(r.distance)as avg_distance
from customer_orders as c
join runner_orders as r
on c.order_id=r.order_id
where r.duration!=0
group by c. customer_id;




    
    


