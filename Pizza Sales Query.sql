

-- Calculating the required KPI's --


SELECT SUM(total_price) As Total_Revenue
From pizza_sales

--Total_Revenue 817860.05083847--



SELECT SUM(total_price) / COUNT(Distinct order_id) AS Average_Order_Value
From pizza_sales

--Average_Order_Value 38.3072623343546 --



SELECT SUM(quantity) As Total_Pizzas_Sold
From pizza_sales

--Total_Pizzas_Sold   49574--

SELECT COUNT(Distinct order_id) As Total_Orders
From pizza_sales


--Total_Orders  21350--

SELECT CAST(CAST(SUM(quantity) AS decimal(10,2)) / CAST( COUNT(Distinct order_id) AS decimal(10,2)) AS decimal(10,2)) AS Average_Pizzas_Per_Order
From pizza_sales

--Average_Pizzas_Per_Order 2.32--

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- CHARTS--


--The daily trend for total oreders chart--
--Datename extracts the name of the day of a given date--

SELECT DATENAME(DW,order_date) AS order_day, COUNT(DISTINCT order_id) as Total_orders
FROM pizza_sales
GROUP BY DATENAME(DW,order_date)

/* order_day	Total_orders
Saturday	      3158
Wednesday	      3024
Monday	          2794
Sunday	          2624
Friday	          3538
Thursday	      3239
Tuesday	          2973

*/

--Hourly_Rate for total orders; The number of orders during each hour from 9Am to 11PM--
--DATEPART extracts the hour section of the date-time entry in the order_time column--

SELECT DATEPART(HOUR, order_time) AS Order_Hours, COUNT(DISTINCT order_id) as Total_orders
From pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time)

/*
Order_Hours	Total_orders
9	            1
10	            8
11	            1231
12	            2520
13	            2455
14	            1472
15	            1468
16           	1920
17	            2336
18	            2399
19	            2009
20	            1642
21	            1198
22	            663
23	             28

*/

--Percentage of sales by pizza category

SELECT pizza_category,SUM(total_price) As Total_Sales, SUM(total_price) * 100 / (SELECT SUM(total_price ) from pizza_sales WHERE MONTH(order_date) = 1) AS PCT_Total_Sales
From pizza_sales 
WHERE MONTH(order_date) = 1
GROUP BY pizza_category

/*
pizza_category	  Total_Sales	        PCT_Total_Sales
Classic      	220053.100021362	    26.9059602306976
Chicken	        195919.5	             23.9551375322885
Veggie	        193690.451004028	     23.6825910258677
Supreme	        208196.99981308	        25.4563112111462
*/

--Pecerntage of sales by pizza size----

SELECT pizza_size, SUM(total_price) As Total_Sales, CAST (SUM(total_price) * 100 / (SELECT SUM(total_price ) from pizza_sales ) AS decimal(10,2)) AS PCT_Total_Sales
From pizza_sales 
GROUP BY pizza_size
ORDER BY PCT_Total_Sales

/*
pizza_size	    Total_Sales	       PCT_Total_Sales
XXL	            1006.6000213623	        0.12
XL	            14076	                1.72
S	            178076.49981308	        21.77
M	            249382.25	            30.49
L	            375318.701004028	    45.89

*/

--total number of  pizzas sold by category--

SELECT pizza_category,SUM(quantity) As Total_Pizzas_Sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Pizzas_Sold

/*
pizza_category	 Total_Pizzas_Sold
Chicken	             11050
Veggie	             11649
Supreme             11987
Classic	            14888
*/


--Top 5 sellers by total pizzas sold--

SELECT TOP 5 pizza_name,SUM(quantity) As Total_pizzas_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER By Total_pizzas_Sold DESC

/*
pizza_name	                          Total_pizzas_Sold
The Classic Deluxe Pizza	               2453
The Barbecue Chicken Pizza	               2432
The Hawaiian Pizza	                       2422
The Pepperoni Pizza	                       2418
The Thai Chicken Pizza	                   2371

*/

---Bottom 5 sellers by total pizzas sold--

SELECT TOP 5 pizza_name,SUM(quantity) As Total_pizzas_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER By Total_pizzas_Sold ASC

/*
pizza_name	                     Total_pizzas_Sold
The Brie Carre Pizza	                 490
The Mediterranean Pizza                 	934
The Calabrese Pizza	                     937
The Spinach Supreme Pizza	              950
The Soppressata Pizza	                 961
*/