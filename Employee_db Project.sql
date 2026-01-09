SHOW DATABASES;

USE employees_db;

SHOW TABLES;

SELECT * FROM employees LIMIT 10;
SELECT * FROM departments LIMIT 10;
SELECT * FROM salaries LIMIT 10;
SELECT * FROM titles  LIMIT 10;
SELECT * FROM dept_emp LIMIT 10;
SELECT * FROM dept_manager LIMIT 10;

SELECT * FROM employees;

-- EMPLOYEE & HR OPERATIONS
# Question 1: Who are the currently active employees, and which department is each employee currently assigned to?
SELECT 
    e.emp_no, e.first_name, e.last_name, c.dept_no, d.dept_name
FROM
    employees e
        JOIN
    current_dept_emp c ON e.emp_no = c.emp_no
        JOIN
    departments d ON d.dept_no = c.dept_no;
    
# Question 2: How many employees are currently working in each department?
SELECT 
    d.dept_name, COUNT(c.emp_no) AS employee_count
FROM
    current_dept_emp c
        JOIN
    departments d ON c.dept_no = d.dept_no
GROUP BY d.dept_name;

# Question 3: Which department has the highest number of employees at the moment?
SELECT 
    d.dept_name, COUNT(c.emp_no) AS employee_count
FROM
    current_dept_emp c
        JOIN
    departments d ON c.dept_no = d.dept_no
GROUP BY d.dept_name
ORDER BY employee_count DESC
LIMIT 1;

# Question 4: List employees who have worked in more than one department during their time in the company.
SELECT 
    e.first_name, e.last_name, de.emp_no, COUNT( DISTINCT dept_no) AS No_of_department
FROM
    dept_emp de
JOIN employees e 
	ON e.emp_no = de.emp_no
GROUP BY emp_no
HAVING no_of_department > 1
ORDER BY emp_no; 

# Question 5: Which employees have been with the company for more than 10 years?
SELECT 
    emp_no, first_name, last_name, hire_date
FROM
    employees
WHERE
    hire_date < '2016-01-06';
     #   OR
    SELECT 
    emp_no, first_name, last_name, hire_date
FROM
    employees
WHERE
    TIMESTAMPDIFF(YEAR,
        hire_date,
        CURDATE()) > 10;

-- DEPARTMENT & MANAGEMENT ANALYSIS
# Question 6: Who is the current manager of each department?
SELECT * from current_department_manager ;

# Question 7: Which departments have had more than one manager over time?
SELECT 
    dm.dept_no,
    d.dept_name,
    COUNT(DISTINCT dm.emp_no) AS no_of_managers
FROM
    dept_manager dm
        JOIN
    departments d ON d.dept_no = dm.dept_no
GROUP BY dept_no
HAVING no_of_managers > 1;

# Question 8: Which department has had the longest-serving manager (based on management duration)?
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    d.dept_name,
    d.dept_no,
    DATEDIFF(dm.to_date, dm.from_date) AS tenure_days
FROM
    dept_manager dm
        JOIN
    employees e ON dm.emp_no = e.emp_no
        JOIN
    departments d ON dm.dept_no = d.dept_no
ORDER BY tenure_days DESC
LIMIT 1;
# OR
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    d.dept_name,
    d.dept_no,
    TIMESTAMPDIFF(DAY, from_date, to_date) AS tenure_days
FROM
    dept_manager dm
        JOIN
    employees e ON dm.emp_no = e.emp_no
        JOIN
    departments d ON dm.dept_no = d.dept_no
ORDER BY tenure_days DESC
LIMIT 1;

# Question 9: Are there any departments that currently do not have an active manager?
SELECT 
    dm.dept_no, d.dept_name
FROM
    departments d
        LEFT JOIN
    dept_manager dm ON d.dept_no = dm.dept_no
WHERE
    dm.emp_no IS NULL
        AND dm.to_date = '9999-01-01';
        
-- JOB TITLES & CAREER PROGRESSION
# Question 10: What is the current job title of each employee?
SELECT 
    e.emp_no, e.first_name, e.last_name, t.title
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    t.to_date IS NULL
        OR t.to_date = '9999-01-01';

# Question 11: Which employees have held more than one job title during their employment?
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    COUNT(DISTINCT t.title) AS No_of_Job_titles
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
GROUP BY emp_no
HAVING no_of_Job_titles > 1; 

# Question 12: How many employees currently hold each job title (e.g., Engineer, Senior Engineer, Manager)?
SELECT 
    title, COUNT(emp_no) AS no_of_employees
FROM
    titles
WHERE
    to_date IS NULL
        OR to_date = '9999-01-01'
GROUP BY title;

# Question 13: Which employees were promoted (changed titles) within their first 3 years of employment?
SELECT DISTINCT
    t.emp_no, e.first_name, e.last_name
FROM
    titles t
        JOIN
    employees e ON t.emp_no = e.emp_no
WHERE
    TIMESTAMPDIFF(YEAR,
        e.hire_date,
        t.from_date) <= 3;
        
-- SALARY & PAYROLL ANALYSIS
# Question 14: What is the current salary of each employee?
SELECT 
    e.emp_no, e.first_name, e.last_name, s.salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = S.emp_no
WHERE
    to_date IS NULL
        OR to_date = '9999-01-01';

# Question 15: Which employees earn above the company’s average salary?
SELECT 
    e.emp_no, e.first_name, e.last_name, s.salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    s.to_date = '9999-01-01'
        AND s.salary > (SELECT 
            AVG(salary)
        FROM
            salaries
        WHERE
            to_date = '9999-01-01');

# Question 16: What is the average current salary per department?
SELECT 
    d.dept_name, AVG(s.salary) AS avg_salary
FROM
    current_dept_emp c
        JOIN
    salaries s ON c.emp_no = s.emp_no
        JOIN
    departments d ON c.dept_no = d.dept_no
WHERE
    s.to_date = '9999-01-01'
GROUP BY d.dept_name;

# Question 17: Which department has the highest total payroll cost?
SELECT 
    d.dept_name, SUM(s.salary) AS total_payroll
FROM
    current_dept_emp c
        JOIN
    salaries s ON c.emp_no = s.emp_no
        JOIN
    departments d ON c.dept_no = d.dept_no
WHERE
    s.to_date = '9999-01-01'
GROUP BY d.dept_name
ORDER BY total_payroll DESC
LIMIT 1;

# Question 18: Which employees have received salary increases over time, and how many times did their salary change?
SELECT 
    emp_no, COUNT(*) - 1 AS salary_changes
FROM
    salaries
GROUP BY emp_no
HAVING salary_changes > 0;


-- COMBINED BUSINESS INSIGHTS (ADVANCED, REAL-WORLD)
# Question 19: Who are the top 5 highest-paid employees currently, including their department and job title?
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    d.dept_name,
    t.title,
    s.salary
FROM
    employees e
        JOIN
    current_dept_emp c ON e.emp_no = c.emp_no
        JOIN
    departments d ON c.dept_no = d.dept_no
        JOIN
    salaries s ON e.emp_no = s.emp_no
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    s.to_date = '9999-01-01'
        AND (t.to_date IS NULL
        OR t.to_date = '9999-01-01')
ORDER BY s.salary DESC
LIMIT 5;

# Question 20: Is there a noticeable salary difference between genders when grouped by 
# department and current job title?
SELECT 
    d.dept_name, t.title, e.gender, AVG(s.salary) AS avg_salary
FROM
    employees e
        JOIN
    current_dept_emp c ON e.emp_no = c.emp_no
        JOIN
    departments d ON c.dept_no = d.dept_no
        JOIN
    salaries s ON e.emp_no = s.emp_no
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    s.to_date = '9999-01-01'
        AND (t.to_date IS NULL
        OR t.to_date = '9999-01-01')
GROUP BY d.dept_name , t.title , e.gender;

    











