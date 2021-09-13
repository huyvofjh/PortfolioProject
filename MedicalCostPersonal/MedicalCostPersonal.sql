-- Cleansing MeicalCostPersonal
SELECT * FROM PortfolioProject..MedicalCostPersonal

-- Duplicate bmi column (bmi_categories = bmi)
ALTER TABLE MedicalCostPersonal
ADD bmi_categories FLOAT

UPDATE MedicalCostPersonal
SET bmi_categories = bmi

-- Duplicate age column (age_categories = bmi)
ALTER TABLE MedicalCostPersonal
ADD age_categories FLOAT

UPDATE MedicalCostPersonal
SET age_categories = age

ALTER TABLE MedicalCostPersonal
DROP COLUMN bmi_categories

----------------------------------------------------------------------
--  Create View and Group bmi values into bmi_categories column
CREATE VIEW Medical AS 
SELECT age,
  CASE WHEN age_categories BETWEEN 18 AND 30 THEN '18-30' 
	   WHEN age_categories BETWEEN 30 AND 50 THEN '30-50' 
	   WHEN age_categories > 50 THEN '>50' END AS age_categories, 
  sex, bmi, 
  CASE WHEN bmi_categories < 18.5 THEN 'UnderWeight' 
	   WHEN bmi_categories BETWEEN 18.5 AND 25 THEN 'Normal' 
	   WHEN bmi_categories BETWEEN 25 AND 30 THEN 'OverWeight' 
	   WHEN bmi_categories BETWEEN 30 AND 35 THEN 'Obese' 
	   WHEN bmi_categories > 35 THEN 'ExtremelyObese' END AS bmi_categories, 
  children, smoker, region, charges 
FROM 
  PortfolioProject..MedicalCostPersonal

-- Data for Visualize
SELECT * FROM Medical 

-------------------------------------------------------------------------
-- Shows Average Charges by bmi_categories
SELECT bmi_categories,ROUND(AVG(charges),2) AS Charges
FROM Medical
GROUP BY bmi_categories
ORDER BY Charges DESC

-- Shows Average Charges by smoker
SELECT smoker, ROUND(AVG(charges),2) AS Charges
FROM Medical 
GROUP BY smoker
ORDER BY charges DESC

