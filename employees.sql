

#1 Display the oldest employee.

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
	
#2 Display employee with the highest salary

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

#3 Display avarage salary for each title.

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

#4 Display employee quantity from each department.

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

#5 Display employee quantity by gender.

SELECT
	gender AS Gender,
	count(*) AS QTY
FROM
	employees
GROUP BY
	gender;

#6 Display avarage salary from each department.

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

#7 Display the maximum difference in years between employees.

SELECT
	(max(YEAR(birth_date)) - min(YEAR(birth_date))) AS 'Age Difference'
FROM
	employees;

#8 Display employees name, surname, gender which name and surname start with 'a' and finish with 'a'.

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

#9 Display avarage salary from each gender.

SELECT
	gender AS Gender,
	AVG(salary) AS 'AVG Salary'
FROM
	employees
JOIN salaries ON
	salaries.emp_no = employees.emp_no
GROUP BY
	gender;

#10 Display the number of characters of the longest name.

SELECT
	LENGTH(first_name) AS 'NameLength'
FROM
	employees
ORDER BY
	NameLength DESC
	LIMIT 1;
