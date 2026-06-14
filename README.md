# Employee Attrition Analysis — SQL Project

## Problem Statement
A mid-sized Indian company with 500 employees is experiencing 25.8% attrition
rate — significantly above the 15% industry benchmark. HR leadership needs
data-driven answers: who is leaving, why, and what should we do about it?

## Dataset
- 500 employees | 6 departments | 26 columns
- Covers: demographics, salary, performance, engagement, exit reasons
- Indian corporate context (salaries in INR)

## Tools Used
- MySQL Workbench

## Key Business Questions Answered
1. Which department has highest attrition rate?
2. Does salary band affect who leaves?
3. Does engagement score predict attrition?
4. What are the top exit reasons?
5. Which recruitment source retains employees longest?

## Key Findings
- Operations dept has 37% attrition — highest across all departments
- Employees earning below 50K leave at 49% vs 17% above 100K
- Low engagement employees (score below 2.5) leave at 63% rate
- "No Growth" is #1 exit reason — 21% of all exits
- Campus Placement hires stay longest — avg 5.2 years

## Business Recommendations
- Prioritise salary revision for employees below 50K band
- Introduce quarterly engagement surveys with action plans
- Build internal growth and promotion pathways to reduce "No Growth" exits
- Increase Campus Placement hiring — highest retention, lowest attrition

## SQL Concepts Used
- GROUP BY, HAVING, ORDER BY
- CASE WHEN for salary and engagement banding
- CTEs (WITH clause) for multi-step readable queries
- Window Functions: RANK(), SUM() OVER()
- Aggregate functions: COUNT, SUM, AVG, ROUND
- NULL handling for active vs exited employees

## Files
- 01_data_cleaning.sql — data validation and quality checks
- 02_analysis.sql — 5 business questions with findings# Employee-Attrition-SQL-Analysis
