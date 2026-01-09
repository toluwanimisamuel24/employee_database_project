CREATE OR REPLACE VIEW dept_emp_latest_date AS
    SELECT emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
    FROM dept_emp
    GROUP BY emp_no;

# View that separates Current vs Former Employees
CREATE OR REPLACE VIEW employee_status AS
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    l.to_date,
    CASE
        WHEN l.to_date = '9999-01-01' THEN 'CURRENT_EMPLOYEE'
        WHEN l.to_date >= CURDATE() THEN 'CURRENT_EMPLOYEE'
        ELSE 'FORMER_EMPLOYEE'
    END AS status
FROM employees e
JOIN dept_emp_latest_date l
  ON e.emp_no = l.emp_no;
    
# shows only the current department for each employee
CREATE OR REPLACE VIEW current_dept_emp AS
    SELECT 
        emp_no, dept_no, from_date, to_date
    FROM
        dept_emp
    WHERE
        to_date = '9999-01-01'
            OR to_date >= CURDATE();
            
# Shows only the current manager for each department
CREATE OR REPLACE VIEW current_employee_department AS
    SELECT 
        d.dept_name, e.emp_no, e.first_name, e.last_name
    FROM
        dept_manager dm
            JOIN
        employees e ON dm.emp_no = e.emp_no
            JOIN
        departments d ON dm.dept_no = d.dept_no
    WHERE
        dm.to_date = '9999-01-01'; or dm_to_date >= curdate()