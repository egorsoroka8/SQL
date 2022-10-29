#1 Display the name and surname of customers who ordered 'SASHIMI SALAD'

SELECT
	first_name,
	last_name
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

#2 Display the name and surname of customers from who did not pay for the order

SELECT
	first_name AS name,
	last_name AS surname
FROM
	customers
JOIN orders ON
	orders.customer_id = customers.customer_id
JOIN delivery_list ON
	delivery_list.order_id = orders.order_id
WHERE
	payment_method = 'NULL';

#3 Display the name and surname of customer who did last order.

SELECT
	first_name AS name,
	last_name AS surname
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
	
#4 Display full customer name and full address from customers. Group by full Address.
	
SELECT
	CONCAT(first_name, ' ', last_name) AS 'Customer Name',
	CONCAT(district, ' ', street, ' ', house, ' ', apartment) AS 'Address'
FROM
	customers
ORDER BY
	Address ASC;

#5 Display the most expensive meal.

SELECT
	menu_name AS 'Most Expensive Meal'
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
	
#6 Display meal name and profit with the most profit.
	
SELECT
	menu_name AS Meal,
	(quantity * price) AS MostProfit
FROM
	orders_products
JOIN products ON
	products.product_id = orders_products.product_id
ORDER BY
	MostProfit DESC
LIMIT 1;

