

#1 Display countries quantity.

SELECT count(code) AS QTY FROM country;

|QTY|
+---+
|239|

#2 Display countries quantity in each continent.

SELECT
	continent AS 'Continent Name',
	count(*) AS 'Quantity'
FROM
	country
GROUP BY
	continent
ORDER BY
	Quantity DESC;

|Continent Name|Quantity|
+--------------+--------+
|Africa        |      58|
|Asia          |      51|
|Europe        |      46|
|North America |      37|
|Oceania       |      28|
|South America |      14|
|Antarctica    |       5|
	

#3 Display country, name, population with the most population city in the world. 

SELECT
	city.name AS 'City',
	country.name AS 'Country',
	city.population AS 'City Population'
FROM
	city
JOIN country ON
	country.code = city.country_code
WHERE
	city.population = (
	SELECT
		max(population)
	FROM
		city);

|City           |Country|City Population|
+---------------+-------+---------------+
|Mumbai (Bombay)|India  |       10500000|
	


#4 Display 10 countries with the highest population density.

SELECT
	name AS 'Country',
	(population / surface_area) AS 'PopulationDensity'
FROM
	country
ORDER BY
	PopulationDensity DESC
LIMIT 10;

|Country                      |PopulationDensity|
+-----------------------------+-----------------+
|Macao                        |       26277.7778|
|Monaco                       |       22666.6667|
|Hong Kong                    |        6308.8372|
|Singapore                    |        5771.8447|
|Gibraltar                    |        4166.6667|
|Holy See (Vatican City State)|        2500.0000|
|Bermuda                      |        1226.4151|
|Malta                        |        1203.1646|
|Maldives                     |         959.7315|
|Bangladesh                   |         896.9222|


#5 Display 10 countries with most language quantity.

SELECT
	country.name AS 'Country',
	count(*) AS QTY
FROM
	country
JOIN country_language ON
	country_language.country_code = country.code
GROUP BY
	country
ORDER BY
	QTY DESC
LIMIT 10;

|Country           |QTY|
+------------------+---+
|China             | 12|
|India             | 12|
|Canada            | 12|
|United States     | 12|
|Russian Federation| 12|
|Tanzania          | 11|
|South Africa      | 11|
|Nigeria           | 10|
|Iran              | 10|
|Kenya             | 10|

#6 Display countries with the most and the least population density.

SELECT
	name AS 'Country',
	(population / surface_area) AS 'ppl_km2'
FROM
	country
WHERE
	code = (
	SELECT
		code
	FROM
		country
	WHERE
		(population / surface_area) <> 0
	ORDER BY
		(population / surface_area) ASC
	LIMIT 1)
	OR code = (
	SELECT
		code
	FROM
		country
	WHERE
		(population / surface_area) <> 0
	ORDER BY
		(population / surface_area) DESC
	LIMIT 1)
ORDER BY
	ppl_km2 DESC;

|Country  |ppl_km2   |
+---------+----------+
|Macao    |26277.7778|
|Greenland|    0.0259|


#7 Display country and city names where capital is city with the most population in the country.

SELECT
	country.name AS 'Country',
	capital AS 'Capital'
FROM
	country
JOIN city ON
	country.code = city.country_code
WHERE
	country.capital =
SELECT
	country_code ;
