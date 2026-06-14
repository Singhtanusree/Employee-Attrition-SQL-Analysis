
-- PROJECT  : Employee Attrition Analysis
-- FILE     : Business Analysis Queries
-- Author   : Tanushree singh 
-- Tool     : MySQL Workbench
-- Date     : June 2025


--Q1: Which department has highest attrition?
SELECT department , COUNT(*) AS total_emp, 
SUM(attrition) AS employee_left , 
ROUND(SUM(attrition) / COUNT(*) * 100 , 1) AS attrition_rate_pct 
FROM employee_attrition 
GROUP BY department 
ORDER BY attrition_rate_pct DESC ; 

--Finding: Operations has highest attrition at ~37%

--Q2: Does salary affect who leaves?
SELECT CASE WHEN monthlysalary < 50000 THEN "below 50k" 
WHEN monthlysalary BETWEEN 50000 AND 74999 THEN "50k - 75k" 
WHEN monthlysalary BETWEEN 75000 AND 99999 THEN "75k - 100k" 
ELSE "above 100k" 
END AS salaryband , 
COUNT(*) AS total_employee , 
SUM(attrition) AS employee_left , 
ROUND(SUM(attrition) / COUNT(*) *100 ,1) AS attrition_rate_pct 
FROM employee_attrition 
GROUP BY salaryband 
ORDER BY attrition_rate_pct DESC ; 

--Finding: Below 50K employees leave at ~49% vs 17% above 100K

--Q3: Does engagement score predict attrition?
WITH engagement_band AS( 
SELECT * , CASE 
WHEN engagementscore < 2.5 THEN "low" 
WHEN engagementscore BETWEEN 2.5 AND 3.5  THEN "medium" 
WHEN engagementscore > 3.5 THEN "high" 
END AS engagement_level FROM 
employee_attrition ) 
SELECT engagement_level , 
COUNT(*) AS total_employee , 
SUM(attrition) AS employee_left , 
ROUND(SUM(attrition)/ COUNT(*) *100 , 1) AS attrition_rate_pct,
ROUND(AVG(monthlysalary) , 0 ) as avg_monthlysal ,
ROUND(AVG(jobsatisfaction),1) as avg_jobsatisfaction
FROM engagement_band 
GROUP BY engagement_level 
ORDER BY attrition_rate_pct DESC ; 

--Finding: Low engagement employees leave at 63% rate

-- Q4: What are the top reasons people leave?
WITH exit_analysis AS (
SELECT ExitReason,COUNT(*) AS total_exits,
ROUND(AVG(MonthlySalary), 0) AS avg_salary_of_leavers,
ROUND(AVG(TenureYears), 1) AS avg_tenure_before_leaving
FROM employee_attrition
WHERE Attrition = 1
GROUP BY ExitReason
)
SELECT ExitReason,total_exits,
ROUND(total_exits / SUM(total_exits) OVER() * 100, 1) AS pct_of_total_exits,
avg_salary_of_leavers,
avg_tenure_before_leaving,
RANK() OVER(ORDER BY total_exits DESC) AS exit_rank
FROM exit_analysis
ORDER BY total_exits DESC;

--Finding: No Growth is #1 exit reason at ~21% of all exits

-- Q5: Which recruitment source retains best?
SELECT RecruitmentSource,COUNT(*) AS total_hired,
SUM(Attrition) AS total_left,
ROUND(SUM(Attrition) / COUNT(*) * 100, 1) AS attrition_rate_pct,
ROUND(AVG(TenureYears), 1) AS avg_tenure_years,
ROUND(AVG(MonthlySalary), 0) AS avg_salary
FROM employee_attrition
GROUP BY RecruitmentSource
ORDER BY avg_tenure_years DESC;

-- Finding: Campus Placement and Employee Referral retain employees longest

