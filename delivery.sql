#1 Display the name and surname of customers who ordered 'SASHIMI SALAD'

SELECT
	first_name AS Name,
	last_name AS Surname
FROM
	customers
JOIN orders ON
	orders.customer_id = customers.customer_id
JOIN orders_products ON
	orders_products.order_id = orders.order_id
JOIN products ON
	products.product_id = orders_products.product_id
WHERE
	menu_name = 'sashimi salad';
	
|Name |Surname|
|-----|-------|
|James|Twist  |
|Ada  |Watson |


#2 Display the name and surname of customers from who did not pay for the order

SELECT
	first_name AS Name,
	last_name AS Surname
FROM
	customers
JOIN orders ON
	orders.customer_id = customers.customer_id
JOIN delivery_list ON
	delivery_list.order_id = orders.order_id
WHERE
	payment_method = 'NULL';
	
|Name    |Surname |
|--------|--------|
|Jennifer|Radriges|
|Bella   |Lorenson|
|Oscar   |Rild    |

#3 Display the name and surname of customer who did last order.

SELECT
	first_name AS Name,
	last_name AS Surname
FROM
	customers
JOIN orders ON
	orders.customer_id = customers.customer_id
JOIN delivery_list ON
	delivery_list.order_id = orders.order_id
WHERE
	date_arrived =(
	SELECT
		max(date_arrived)
	FROM
		delivery_list);
		
|Name   |Surname  |
|-------|---------|
|William|Frankston|
	
#4 Display full customer name and full address from customers. Group by full Address.
	
SELECT
	CONCAT(first_name, ' ', last_name) AS 'Customer Name',
	CONCAT(district, ' ', street, ' ', house, ' ', apartment) AS 'Address'
FROM
	customers
ORDER BY
	Address ASC;
	
|Customer Name    |Address                 |
|-----------------|------------------------|
|Mario Gordon     |East Five Avenue 21 91  |
|Oliver Thompson  |East Five Avenue 77 14  |
|Peter Hall       |North Cascade Rd 17 7   |
|William Frankston|North Cascade Rd 18 88  |
|Bella Lorenson   |North Green Avenue 23 67|
|Henry Smith      |South Brown St 15 56    |
|James Twist      |South Corn St 24 89     |
|Ada Watson       |South Elma St 18 9      |
|Penny Smith      |South First Avenue 1 10 |
|Hellen Bellora   |South First Avenue 11 85|
|Oscar Rild       |South First Avenue 5 13 |
|Erica Visputchu  |South First Avenue 62 44|
|Jennifer Radriges|West Roll St 76 44      |
|Kate Evans       |West Spring St 123 52   |
|Randy Brown      |West Spring St 2 35     |

#5 Display the best selling meal.

SELECT
	menu_name AS 'Best selling'
FROM
	products
JOIN orders_products ON
	orders_products.product_id = products.product_id
WHERE
	quantity = (
	SELECT
		max(quantity)
	FROM
		orders_products);
		
|Best selling       |
|-------------------|
|NUTTY GRILLED SALAD|
	
#6 Display meal name and profit with the most profit.
	
SELECT
	menu_name AS Meal,
	(quantity * price) AS Profit
FROM
	orders_products
JOIN products ON
	products.product_id = orders_products.product_id
ORDER BY
	Profit DESC
LIMIT 1;

|Meal               |Profit|
|-------------------|------|
|NUTTY GRILLED SALAD|42    |

#7 Display product which haven't beed bought.

SELECT
	menu_name
FROM
	products
WHERE
	product_id NOT IN (
	SELECT
		DISTINCT product_id
	FROM
		orders_products);
		

	
#8 Display the customers full name and the amount they spent on the order. Sort by the most expensive purchase.
	
SELECT
	CONCAT(first_name, ' ', last_name) AS 'Customer Name',
	orders_products.order_id AS 'OrderNo',
	ROUND((quantity * price), 2) AS 'Spent'
FROM
	orders_products
JOIN products ON
	products.product_id = orders_products.product_id
JOIN orders ON
	orders.order_id = orders_products.order_id
JOIN customers ON
	customers.customer_id = orders.order_id
GROUP BY
	OrderNo
ORDER BY
	Spent DESC;

#9 Display the delivery time of each order. Sort from longest order.

SELECT  
	orders.order_id AS 'orderID',
	timediff(time(date_arrived), time(date_get)) AS 'DeliveryTime'
FROM
	orders
JOIN delivery_list ON
	delivery_list.order_id = orders.order_id
ORDER BY
	DeliveryTime DESC;

#10 Display orders quantity from each district.

SELECT
	district,
	count(order_id)
FROM
	customers
JOIN orders ON
	orders.customer_id = customers.customer_id
GROUP BY
	district;

#11 Display full name of deliveryman who delivered the longest order.

SELECT
	CONCAT(first_name, ' ', last_name) AS 'Deliveryman Name',
	delivery_type AS 'Delivery Type',
	timediff(time(date_arrived), time(date_get)) AS Time
FROM
	courier_info
JOIN delivery_list ON
	courier_info.courier_id = delivery_list.courier_id
JOIN orders ON
	orders.order_id = delivery_list.order_id
ORDER BY
	time DESC
LIMIT 1;

#12 Display the months in which the average check is less than the average check for the year.

SELECT
	month_name
FROM
	year_statistics
WHERE
	average_check < (
	SELECT
		avg(average_check)
	FROM
		year_statistics);
	
#13 
	
SELECT
	(ROUND((SELECT MAX(average_check) FROM year_statistics) - (SELECT min(average_check) FROM year_statistics), 2)) AS 'Difference'
FROM
	year_statistics
LIMIT 1;

