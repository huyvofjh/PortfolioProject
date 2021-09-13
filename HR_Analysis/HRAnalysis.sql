-- Cleansing HRDataset Table
SELECT SUBSTRING(employee_name, CHARINDEX(',',employee_name)+1,LEN(employee_name)) AS FirstName,
	   SUBSTRING([employee_name],1,CHARINDEX(',',employee_name)-1) AS LastName
      --,[empid]
      --,[marriedid]
      --,[maritalstatusid]
      --,[genderid]
      --,[empstatusid]
      --,[deptid]
      --,[perfscoreid]
      --,[fromdiversityjobfairid]
      ,[salary]
      --,[termd]
      --,[positionid]
      ,[position]
      ,[state]
      --,[zip]
      ,CONVERT(date,[dob]) as DateOfBirth
      ,CASE WHEN [sex] = 'M' then 'Male'
			WHEN sex = 'F' then 'Female' END AS Gender
      ,[maritaldesc]
      ,[citizendesc]
      --,[hispaniclatino]
      ,[racedesc]
      ,CAST([dateofhire] AS Date) AS DateOfHire
      ,CAST([dateoftermination] AS Date) AS DateOfTermination
      ,CASE WHEN [termreason] = 'N/A-StillEmployed' THEN 'StillEmployed' 
			ELSE TermReason END AS TermReason
      ,[employmentstatus]
      ,[department]
      --,[managername]
      --,[managerid]
      ,[recruitmentsource]
      ,[performancescore]
      ,[engagementsurvey]
      ,[empsatisfaction]
      --,[specialprojectscount]
      --,[lastperformancereview_date]
      --,[dayslatelast30]
      ,[absences]
FROM [PortfolioProject].[dbo].[HRDataset]


--------------------------------------------------------------------------------------------------------
-- Create View From HRDataset Table
CREATE VIEW HRData AS 
SELECT [empid], SUBSTRING(employee_name, CHARINDEX(',',employee_name)+1,LEN(employee_name)) AS FirstName,
	   SUBSTRING([employee_name],1,CHARINDEX(',',employee_name)-1) AS LastName
	  ,CASE WHEN [sex] = 'M' then 'Male'
			WHEN sex = 'F' then 'Female' END AS Gender
	  ,CONVERT(date,[dob]) as DateOfBirth
      ,[position]
      ,[state]
      ,[maritaldesc]
      ,[citizendesc]
      ,[racedesc]
	  ,[salary]
      ,CONVERT(Date,[dateofhire]) AS DateOfHire
      ,CONVERT(Date,[dateoftermination]) AS DateOfTermination
      ,CASE WHEN [termreason] = 'N/A-StillEmployed' THEN 'StillEmployed' 
			ELSE TermReason END AS TermReason
      ,[employmentstatus]
      ,[department]
      ,[recruitmentsource]
      ,[performancescore]
      ,[engagementsurvey]
      ,[empsatisfaction]
      ,[absences]
FROM [PortfolioProject].[dbo].[HRDataset]

---------------------------------------------------------------------------------------------------
-- Shows Employees Informations and Starting Age, Terminating Age, Working Time by Months and Employees Satisfication
-- Data for Visualize
SELECT [empid],FirstName, LastName,Gender,maritaldesc AS MaritalStatus,
position, department, citizendesc AS CitizenDesc, recruitmentsource, 
DATEDIFF(YEAR,DateOfBirth, DateOfHire) AS StartingAge, 
DATEDIFF(YEAR,DateOfBirth, DateOfTermination) AS TerminatingAge,
DATEDIFF(Month,DateOfHire,DateOfTermination) AS 'WorkingTime(Months)', 
TermReason, salary,absences,
CASE WHEN empsatisfaction = 1 THEN 'Dissatisfied'
	 WHEN empsatisfaction = 2 THEN 'Dissatisfied' 
	 WHEN empsatisfaction = 3 THEN 'Neutral' 
	 WHEN empsatisfaction = 4 THEN 'Satisfied' 
	 WHEN empsatisfaction = 5 THEN 'Satisfied' END AS EmpSatisfaction
FROM HRData

-- Shows Average Salary by Sex
SELECT AVG(salary) FROM HRData
WHERE Gender = 'Male'

SELECT AVG(salary) FROM HRData
WHERE Gender = 'Female'

---------------------------------------------------------------------------------------------------
-- Shows Salary by Marital Status
SELECT MaritalDesc, ROUND(AVG(salary),2) AS Salary
FROM PortfolioProject..HRDataset
GROUP BY MaritalDesc

-- Shows Salary by Term Reason
SELECT TermReason, ROUND(AVG(salary),2) AS Salary
FROM PortfolioProject..HRDataset
GROUP BY TermReason
ORDER BY Salary DESC

-- Shows Salary by position
SELECT Position, ROUND(AVG(salary),2) AS Salary
FROM PortfolioProject..HRDataset
GROUP BY Position
ORDER BY Salary DESC

-- Shows Salary by departments
SELECT Department, ROUND(AVG(salary),2) AS Salary
FROM PortfolioProject..HRDataset
GROUP BY Department
ORDER BY Salary DESC
-----------------------------------------------------------------------------------
-- Shows Salary by Recruiment Source
SELECT Position, RecruitmentSource, ROUND(AVG(salary),2) AS Salary
FROM PortfolioProject..HRDataset
GROUP BY Position,RecruitmentSource
ORDER BY Salary DESC
