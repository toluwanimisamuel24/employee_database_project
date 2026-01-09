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

## Key Skills Demonstrated
- Relational database design
- JOINs across multiple tables
- Views for current-state analysis
- Aggregations and subqueries
- Real-world HR and payroll analytics

## Key Insights
- Current workforce distribution
- Department payroll costs
- Career progression patterns
- Gender-based salary comparisons

## Tools Used
- MySQL

---
