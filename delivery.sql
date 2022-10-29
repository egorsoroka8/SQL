SELECT first_name AS name, last_name AS surname FROM customers
JOIN orders ON
orders.customer_id = customers.customer_id
JOIN orders_products ON
orders_products.order_id = orders.order_id 
JOIN products ON
products.product_id = orders_products.product_id
WHERE menu_name='SASHIMI SALAD';

"name","surname"
Jennifer,Radriges
Bella,Lorenson
Oscar,Rild
