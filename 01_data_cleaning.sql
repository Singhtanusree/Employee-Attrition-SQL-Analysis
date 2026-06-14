
-- PROJECT  : Employee Attrition Analysis
-- FILE     : Data Cleaning & Validation
-- Author   : Tanushree singh 
-- Tool     : MySQL Workbench
-- Date     : June 2025


-- total rows imported
SELECT COUNT(*) AS total_rows FROM employee_attrition;
-- result: 500

--Check for duplicate Employee IDs
SELECT EmployeeID, COUNT(*) AS count
FROM employee_attrition
GROUP BY EmployeeID
HAVING COUNT(*) > 1;
-- result: 0 rows 

--NULL values in key columns
SELECT SUM(CASE WHEN EmployeeID IS NULL THEN 1 ELSE 0 END) AS null_empid,
SUM(CASE WHEN Department IS NULL THEN 1 ELSE 0 END) AS null_dept,
SUM(CASE WHEN MonthlySalary IS NULL THEN 1 ELSE 0 END) AS null_salary,
SUM(CASE WHEN PerformanceRating IS NULL THEN 1 ELSE 0 END) AS null_perf,
SUM(CASE WHEN Attrition IS NULL THEN 1 ELSE 0 END) AS null_attrition,
SUM(CASE WHEN DateOfExit IS NULL THEN 1 ELSE 0 END) AS null_exit_date
FROM employee_attrition;


--EmploymentStatus values are consistent
SELECT EmploymentStatus, COUNT(*) AS count
FROM employee_attrition
GROUP BY EmploymentStatus;
-- result: Active / Voluntarily Resigned / Terminated only

--PerformanceRating values are consistent
SELECT PerformanceRating, COUNT(*) AS count
FROM employee_attrition
GROUP BY PerformanceRating
ORDER BY count DESC;
-- result: Excellent / Good / Average / Below Average / Poor only

--Salary range for outliers
SELECT MIN(MonthlySalary) AS min_salary,
MAX(MonthlySalary) AS max_salary,
ROUND(AVG(MonthlySalary), 0) AS avg_salary
FROM employee_attrition;
-- result: min 38000, max 141000, avg 73975

--Baseline summary 
SELECT COUNT(*) AS total_employees,
SUM(Attrition) AS total_left,
COUNT(*) - SUM(Attrition) AS total_active,
ROUND(SUM(Attrition) / COUNT(*) * 100, 1) AS attrition_rate_pct,
COUNT(DISTINCT Department) AS departments,
ROUND(AVG(MonthlySalary), 0) AS avg_salary
FROM employee_attrition;
-- result: 500 | 129 | 371 | 25.8% | 6 | 73975