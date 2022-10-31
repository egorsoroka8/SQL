

#1 Dispalay employee quantity.

SELECT
	DISTINCT count(emp_no) AS 'Employee QTY'
FROM
	employees;
	
|Employee QTY|
|------------|
|300,024     |


#2 Display the oldest employee.

SELECT
	CONCAT(first_name, ' ', last_name) AS Employee, birth_date AS 'Birth date'
FROM
	employees
WHERE
	birth_date = (
	SELECT
		MIN(birth_date)
	FROM
		employees)
	ORDER BY Employee;
	
|Employee         |Birth date|
|-----------------|----------|
|Eishiro Kuzuoka  |1952-02-01|
|Jouni Pocchiola  |1952-02-01|
|Kiyokazu Whitcomb|1952-02-01|
|Moni Decaestecker|1952-02-01|
|Ronghao Schaad   |1952-02-01|
|Supot Remmele    |1952-02-01|

	
#3 Display employee with the highest salary

SELECT
	CONCAT(first_name, ' ', last_name) AS Employee,
	title AS Title
FROM
	employees
JOIN salaries ON
	salaries.emp_no = employees.emp_no
JOIN titles ON
	titles.emp_no = employees.emp_no
WHERE
	salary = (
	SELECT
		MAX(salary)
	FROM
		salaries)
LIMIT 1;

|Employee      |Title       |
|--------------|------------|
|Tokuyasu Pesch|Senior Staff|


#4 Display avarage salary for each title.

SELECT
	title AS Title,
	AVG(salary) AS 'AverageSalary'
FROM
	salaries
JOIN titles ON
	titles.emp_no = salaries.emp_no
GROUP BY
	title
ORDER BY
	AverageSalary;

|Title             |AverageSalary|
|------------------|-------------|
|Technique Leader  |59,294.3742  |
|Assistant Engineer|59,304.9863  |
|Engineer          |59,508.0397  |
|Senior Engineer   |60,543.2191  |
|Manager           |66,924.2706  |
|Staff             |69,309.1023  |
|Senior Staff      |70,470.8353  |


#5 Display employee quantity from each department.

SELECT
	departments.dept_name AS DeptName,
	count(dept_emp.dept_no) AS QTY
FROM
	dept_emp
JOIN departments ON
	departments.dept_no = dept_emp.dept_no
WHERE
	dept_emp.emp_no IN (
	SELECT
		DISTINCT emp_no
	FROM
		dept_emp)
GROUP BY
	DeptName
ORDER BY
	QTY DESC;
	
|DeptName          |QTY   |
|------------------|------|
|Development       |85,707|
|Production        |73,485|
|Sales             |52,245|
|Customer Service  |23,580|
|Research          |21,126|
|Marketing         |20,211|
|Quality Management|20,117|
|Human Resources   |17,786|
|Finance           |17,346|


#6 Display employee quantity by gender.

SELECT
	gender AS Gender,
	count(*) AS QTY
FROM
	employees
GROUP BY
	gender;
	
|Gender|QTY    |
|------|-------|
|M     |179,973|
|F     |120,051|


#7 Display avarage salary from each department.

SELECT
	dept_name AS Name,
	AVG(salary) AS 'AVGSalary'
FROM
	departments
JOIN dept_manager ON
	dept_manager.dept_no = departments.dept_no
JOIN salaries ON
	salaries.emp_no = dept_manager.emp_no
GROUP BY
	dept_name
ORDER BY AVGSalary DESC;

|Name              |AVGSalary  |
|------------------|-----------|
|Marketing         |88,371.6857|
|Sales             |85,738.7647|
|Research          |77,535.1818|
|Finance           |70,815.8889|
|Quality Management|67,130.9355|
|Development       |59,658.1176|
|Human Resources   |58,286.0556|
|Production        |56,233.4   |
|Customer Service  |54,959.6724|


#8 Display the maximum difference in years between employees.

SELECT
	(max(YEAR(birth_date)) - min(YEAR(birth_date))) AS 'Age Difference'
FROM
	employees;
	
|Age Difference|
|--------------|
|13            |


#9 Display employees name, surname, gender which name and surname start with 'a' and finish with 'a'.

SELECT
	DISTINCT 
	first_name AS Name,
	last_name AS Surname, 
	gender AS Gender
FROM
	employees
WHERE
	first_name LIKE 'a%a'
	AND last_name LIKE 'a%a'
ORDER BY Gender;

|Name    |Surname  |Gender|
|--------|---------|------|
|Abdulla |Akiyama  |M     |
|Abdulla |Azuma    |M     |
|Alenka  |Aloia    |M     |
|Alenka  |Azuma    |M     |
|Aria    |Ariola   |M     |
|Arra    |Akiyama  |M     |
|Almudena|Akiyama  |F     |
|Almudena|Aloia    |F     |
|Ayonca  |Andreotta|F     |


#10 Display avarage salary from each gender.

SELECT
	gender AS Gender,
	AVG(salary) AS 'AVG Salary'
FROM
	employees
JOIN salaries ON
	salaries.emp_no = employees.emp_no
GROUP BY
	gender;
	
|Gender|AVG Salary |
|------|-----------|
|M     |63,838.1769|
|F     |63,769.6032|


#11 Display the number of characters of the longest name.

SELECT
	LENGTH(first_name) AS 'NameLength'
FROM
	employees
ORDER BY
	NameLength DESC
	LIMIT 1;
	
|NameLength|
|----------|
|14        |


#12 Display 10 employees whose difference between highest and lowest salary the most.

SELECT
	salaries.emp_no AS ID,
	CONCAT(first_name, ' ', last_name) AS 'Full Name',
	(max(salary) - min(salary)) AS 'Difference'
FROM
	salaries 
JOIN employees ON
	employees.emp_no = salaries.emp_no
GROUP BY
	ID
ORDER BY
	Difference DESC LIMIT 10;

	
|ID     |Full Name         |Difference|
|-------|------------------|----------|
|43,145 |Fumino Frijda     |53,875    |
|204,805|Nimmagadda Crouzet|53,425    |
|446,888|Ishfaq Iisaku     |53,261    |
|13,386 |Khosrow Sgarro    |53,014    |
|102,654|Gregory Makinen   |52,827    |
|74,848 |Lucian Werthner   |52,721    |
|65,362 |Zsolt McAffer     |52,515    |
|433,372|Rasiah Yemenis    |52,324    |
|466,852|Akemi Warwick     |52,046    |
|484,934|Magy Aamodt       |51,762    |


#13 Display the department in which Fumino Frijda (M) works and his last title.

SELECT
	dept_name AS 'Department',
	title AS 'Title',
	CONCAT(first_name, ' ', last_name) AS 'Full Name',
	titles.from_date AS 'Date'
FROM
	departments
JOIN dept_emp ON
	dept_emp.dept_no = departments.dept_no
JOIN employees ON
	employees.emp_no = dept_emp.emp_no
JOIN titles ON
	titles.emp_no = employees.emp_no
WHERE
	first_name = 'Fumino'
	AND last_name = 'Frijda'
	AND gender = 'M'
ORDER BY
	date DESC
LIMIT 1;

|Department|Title       |Full Name    |Date      |
|----------|------------|-------------|----------|
|Marketing |Senior Staff|Fumino Frijda|1996-12-17|


