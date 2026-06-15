sql_path = os.path.join(project_path, "sql")

sql_content = """-- ================================================
-- HR Attrition Analysis - SQL Queries
-- Author: Priyanka M M
-- Dataset: IBM HR Analytics Employee Attrition
-- ================================================

-- Q1: Overall attrition rate
SELECT 
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Employees_Left,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) 
        AS Attrition_Rate_Percent
FROM hr_attrition;

-- Q2: Attrition rate by department
SELECT 
    Department,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Employees_Left,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) 
        AS Attrition_Rate_Percent
FROM hr_attrition
GROUP BY Department
ORDER BY Attrition_Rate_Percent DESC;

-- Q3: Top 5 job roles with highest attrition
SELECT 
    JobRole,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Employees_Left,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) 
        AS Attrition_Rate_Percent
FROM hr_attrition
GROUP BY JobRole
ORDER BY Attrition_Rate_Percent DESC
LIMIT 5;

-- Q4: Impact of overtime on attrition
SELECT 
    OverTime,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Employees_Left,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) 
        AS Attrition_Rate_Percent
FROM hr_attrition
GROUP BY OverTime
ORDER BY Attrition_Rate_Percent DESC;

-- Q5: Average income - stayed vs left
SELECT 
    Attrition,
    ROUND(AVG(MonthlyIncome), 2) AS Avg_Monthly_Income,
    ROUND(AVG(Age), 1) AS Avg_Age,
    ROUND(AVG(YearsAtCompany), 1) AS Avg_Years_At_Company
FROM hr_attrition
GROUP BY Attrition;

-- Q6: Attrition by age group
SELECT 
    CASE 
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        ELSE '46-60'
    END AS Age_Group,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Employees_Left,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) 
        AS Attrition_Rate_Percent
FROM hr_attrition
GROUP BY Age_Group
ORDER BY Attrition_Rate_Percent DESC;

-- Q7: High risk employees (overtime + low income + young)
SELECT 
    EmployeeNumber,
    Age,
    JobRole,
    Department,
    MonthlyIncome,
    OverTime,
    YearsAtCompany,
    Attrition
FROM hr_attrition
WHERE OverTime = 'Yes' 
    AND MonthlyIncome < 3000 
    AND Age < 30
ORDER BY MonthlyIncome ASC;

-- Q8: Work life balance impact
SELECT 
    WorkLifeBalance,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Employees_Left,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) 
        AS Attrition_Rate_Percent
FROM hr_attrition
GROUP BY WorkLifeBalance
ORDER BY WorkLifeBalance ASC;
"""

# Save the SQL file
with open(os.path.join(sql_path, "hr_attrition_queries.sql"), "w") as f:
    f.write(sql_content)

print("✅ SQL file saved successfully!")
print("Location:", os.path.join(sql_path, "hr_attrition_queries.sql"))