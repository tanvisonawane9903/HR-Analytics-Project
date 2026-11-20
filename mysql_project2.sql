-- =========================================
-- CREATE DATABASE & USE IT
-- =========================================

CREATE DATABASE  HR_Project;
USE HR_Project;

-- =========================================
-- CREATE TABLE
-- =========================================

CREATE TABLE hr_data (
    Age INT,
    Attrition VARCHAR(10),
    BusinessTravel VARCHAR(50),
    DailyRate INT,
    Department VARCHAR(50),
    DistanceFromHome INT,
    Education INT,
    EducationField VARCHAR(50),
    EmployeeCount INT,
    EmployeeNumber INT PRIMARY KEY,
    EnvironmentSatisfaction INT,
    Gender VARCHAR(10),
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRole VARCHAR(50),
    JobSatisfaction INT,
    MaritalStatus VARCHAR(20),
    MonthlyIncome INT,
    IncomeGroup VARCHAR(20),
    MonthlyRate INT,
    NumCompaniesWorked INT,
    Over18 VARCHAR(5),
    OverTime VARCHAR(5),
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StandardHours INT,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT
);

-- =========================================
-- KPI 1: Employee Count
-- =========================================
SELECT 
    CONCAT(ROUND(COUNT(*) / 1000, 0), 'K') AS Employee_Count
FROM
    hr_data;

-- =========================================
-- KPI 2: Attrition Rate (%)
-- =========================================
SELECT 
    CONCAT(
        ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2),
        '%'
    ) AS Attrition_Rate
FROM hr_data;

-- =========================================
-- KPI 3: Active Employees
-- =========================================
SELECT COUNT(*) AS Active_Employees
FROM hr_data
WHERE Attrition = 'No';

-- =========================================
-- KPI 4: Department-wise Employee Count
-- =========================================
SELECT 
    Department,
    COUNT(*) AS Employee_Count
FROM hr_data
GROUP BY Department
ORDER BY Employee_Count DESC;

-- =========================================
-- KPI 5: Gender Ratio
-- =========================================
SELECT 
    Gender,
    COUNT(*) AS Count,
    CONCAT(
        ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM hr_data), 2),
        '%'
    ) AS Percentage
FROM hr_data
GROUP BY Gender;

-- =========================================
-- KPI 6: Average Salary
-- =========================================
SELECT 
    ROUND(AVG(MonthlyIncome), 2) AS Avg_Salary
FROM hr_data;

-- =========================================
-- KPI 7: Salary Distribution
-- =========================================
SELECT 
    CASE 
        WHEN MonthlyIncome < 3000 THEN 'Low Salary'
        WHEN MonthlyIncome BETWEEN 3000 AND 8000 THEN 'Medium Salary'
        ELSE 'High Salary'
    END AS Salary_Group,
    COUNT(*) AS Employee_Count
FROM hr_data
GROUP BY Salary_Group
ORDER BY Employee_Count DESC;

-- =========================================
-- 8. Overtime Analysis (% Employees Doing Overtime)
-- =========================================
SELECT 
    COUNT(*) AS Total_Employees,

    SUM(CASE WHEN OverTime = 'Yes' THEN 1 ELSE 0 END) AS Overtime_Employees,

    CONCAT(
        ROUND(
            SUM(CASE WHEN OverTime = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
            2
        ),
        '%'
    ) AS Overtime_Percentage

FROM hr_data;

-- =========================================
-- 9. Work-Life Balance Score (Average Rating)
-- =========================================
SELECT 
    ROUND(AVG(WorkLifeBalance), 2) AS Avg_Work_Life_Balance
FROM hr_data;

-- =========================================
-- KPI 10: Job Satisfaction Score
-- =========================================
SELECT 
    ROUND(AVG(JobSatisfaction), 2) AS Avg_Job_Satisfaction
FROM hr_data;

-- =========================================
-- 11.Average Attrition Rate for all Departments
-- =========================================
SELECT 
    Department,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS Attrition_Rate_Percentage
FROM hr_data
GROUP BY Department
ORDER BY Attrition_Rate_Percentage DESC;

-- =========================================
-- 12. Average Hourly Rate of Male Research Scientist
-- =========================================
SELECT 
    ROUND(AVG(HourlyRate), 2) AS Avg_Hourly_Rate
FROM hr_data
WHERE Gender = 'Male'
AND JobRole = 'Research Scientist';

-- =========================================
-- 13. Attrition Rate vs Monthly Income Stats
-- =========================================
SELECT 
    CASE 
        WHEN MonthlyIncome < 3000 THEN 'Low Income'
        WHEN MonthlyIncome BETWEEN 3000 AND 8000 THEN 'Medium Income'
        ELSE 'High Income'
    END AS Income_Group,

    COUNT(*) AS Total_Employees,

    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrition_Count,

    CONCAT(
        ROUND(
            SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
            2
        ),
        '%'
    ) AS Attrition_Rate

FROM hr_data
GROUP BY Income_Group
ORDER BY Attrition_Rate DESC;
-- =========================================
-- 14. Average Working Years for each Department
-- =========================================
SELECT 
    Department,
    ROUND(AVG(TotalWorkingYears), 2) AS Avg_Working_Years
FROM hr_data
GROUP BY Department
ORDER BY Avg_Working_Years DESC;

-- =========================================
-- 15. Job Role vs Work-Life Balance
-- =========================================
SELECT 
    JobRole,
    ROUND(AVG(Wor7kLifeBalance), 2) AS Avg_Work_Life_Balance
FROM hr_data
GROUP BY JobRole
ORDER BY Avg_Work_Life_Balance DESC;

