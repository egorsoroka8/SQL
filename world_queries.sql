

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


#7 Display countries quantity where name and local name the same.
SELECT
	(
	SELECT
		count(name)
	FROM
		country) - (
	SELECT
		count(name)
	FROM
		country
	WHERE
		name = local_name) AS Difference;

	
#8 Display cities quantity which start with A character.
	
	SELECT
	count(name) AS 'Count'
FROM
	city
WHERE
	name LIKE 'a%';

|Count|
+-----+
|  260|


#9 Display 5 cities with the most district quantity and countries in which they are.

SELECT
	city.name AS 'City',
	country.name AS 'Country',
	count(district) AS 'Count'
FROM
	city
JOIN country ON 
country.code = city.country_code
GROUP BY
	country_code
ORDER BY
	count DESC
LIMIT 5;

|City           |Country      |Count|
+---------------+-------------+-----+
|Shanghai       |China        |  363|
|Mumbai (Bombay)|India        |  341|
|New York       |United States|  274|
|São Paulo      |Brazil       |  250|
|Tokyo          |Japan        |  248|

	
#10 Display quantity each government forms and surface area they occupy. 

SELECT
	government_form AS 'Form',
	count(*) AS 'Quantity',
	sum(surface_area) AS 'Area'
FROM
	country
GROUP BY
	government_form
ORDER BY
	Area DESC;

|Form                                        |Quantity|Area       |
+--------------------------------------------+--------+-----------+
|Federal Republic                            |      15|46116599.00|
|Republic                                    |     122|45376058.00|
|Constitutional Monarchy, Federation         |       4|18072106.00|
|Co-administrated                            |       1|13120000.00|
|Peoples Republic                            |       1| 9572900.00|
|Constitutional Monarchy                     |      29| 4207458.50|
|Islamic Republic                            |       2| 4154008.00|
|Monarchy                                    |       5| 2225704.00|
|Part of Denmark                             |       2| 2167489.00|
|Socialistic State                           |       1| 1759540.00|
|Islamic Emirate                             |       1|  652090.00|
|Socialistic Republic                        |       3|  563088.00|
|Monarchy (Sultanate)                        |       2|  315265.00|
|Occupied by Marocco                         |       1|  266000.00|
|Overseas Department of France               |       4|   95317.00|
|Emirate Federation                          |       1|   83600.00|
|Dependent Territory of Norway               |       2|   62481.00|
|Federation                                  |       1|   41284.00|
|Nonmetropolitan Territory of France         |       4|   30555.00|
|Constitutional Monarchy (Emirate)           |       1|   17818.00|
|Dependent Territory of the UK               |      12|   17619.00|
|Administrated by the UN                     |       1|   14874.00|
|Commonwealth of the US                      |       2|    9339.00|
|Autonomous Area                             |       1|    6257.00|
|Parlementary Monarchy                       |       1|    2831.00|
|US Territory                                |       3|    1095.00|
|Special Administrative Region of China      |       2|    1093.00|
|Nonmetropolitan Territory of The Netherlands|       2|     993.00|
|Monarchy (Emirate)                          |       1|     694.00|
|Territorial Collectivity of France          |       2|     615.00|
|Territory of Australia                      |       4|     544.00|
|Nonmetropolitan Territory of New Zealand    |       3|     508.00|
|Parliamentary Coprincipality                |       1|     468.00|
|Dependent Territory of the US               |       1|      16.00|
|Independent Church State                    |       1|       0.40|
