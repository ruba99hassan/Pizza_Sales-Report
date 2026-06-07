select * from pizza_sales
--total revenue
select SUM(total_price)as  Total_Revenue from pizza_sales


--avg order
select (SUM(total_price)/COUNT(distinct order_id)) as Average_orders from pizza_sales


--total pia sold
select sum(quantity)as total_pizza_sold from pizza_sales


--total order
select COUNT( distinct order_id) as total_orders from pizza_sales


--avg pizza order
select cast(cast(sum( quantity)as decimal(10,2))/cast(count( distinct order_id)as decimal(10,2)) as decimal(10,2)) as Averge_pizza_order
from pizza_sales


--daily trend for totl order
SELECT 
    DATENAME(WEEKDAY, TRY_CAST(order_date AS DATE)) AS order_day,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
WHERE TRY_CAST(order_date AS DATE) IS NOT NULL
GROUP BY DATENAME(WEEKDAY, TRY_CAST(order_date AS DATE));

-- hourly trend for total order
select DATENAME(hour,order_time) as order_hour,COUNT(distinct order_id)as total_order
from pizza_sales

group by 
DATENAME(hour,order_time),
datepart(hour,order_time)

order by datepart(hour,order_time)

--%sales by category

SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category


--%SALES BY PIZZA SIZE
select pizza_size,cast(sum(total_price) as  decimal(10,2)) as total_revenue,
cast(sum(total_price)*100/ (select sum(total_price) from pizza_sales)as decimal(10,2)) as PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size


--TOTAL PIZZA SOLD BY PIZZA CATEGORY
select pizza_category, sum(quantity) as total_pizza_sold
from pizza_sales
group by pizza_category 
order by total_pizza_sold desc

--top 5 best pizza by  total pizza 

select top 5 pizza_name, sum(quantity) as total_pizza_sold
from pizza_sales
group by pizza_name
order by total_pizza_sold desc

---bottom 5 pizza by total pizza sold

select TOP 5 pizza_name, sum(quantity) as total_pizza_sold
from pizza_sales
group by pizza_name
order by total_pizza_sold ASC

