# Employee Database SQL Analysis

## 📌 Project Overview

This repository contains SQL scripts and analysis based on a corporate employee management database. The goal is to demonstrate SQL proficiency through real-world HR analytics use-cases, including:

- Workforce distribution
- Department history
- Job title progression
- Salary analysis
- Gender pay gap insights

---

## 🛠 Database Tables

| Table | Description |
|-------|-------------|
| `employees` | Personal info for each employee |
| `departments` | Department list |
| `dept_emp` | Employee ↔ Department history |
| `dept_manager` | Department manager history |
| `titles` | Job title history |
| `salaries` | Salary history |

---

## 🧱 Schema (DDL)

All `CREATE TABLE` statements are in `schema/create_tables.sql`.

---

## 📈 Views

Reusable logical views are stored in `views/`:

- `dept_emp_latest_date.sql`: Latest dept assignment dates
- `current_dept_emp.sql`: Current department assignment

---

## 🔍 Analytics Queries

Query scripts organized by topic:

| File | Focus |
|------|-------|
| `queries/hr_operations.sql` | HR related questions |
| `queries/department_analysis.sql` | Dept metrics |
| `queries/titles_analysis.sql` | Job title insights |
| `queries/salary_analysis.sql` | Salary analysis |
| `queries/advanced_insights.sql` | Combined analytics |

---

## 💾 Data Import

CSV files are provided in the `data/` folder for quick import using:

```sql
LOAD DATA LOCAL INFILE 'data/employees.csv'
INTO TABLE employees
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;
