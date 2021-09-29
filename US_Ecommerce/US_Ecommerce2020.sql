-- Create View 

CREATE VIEW US_Ecom AS 
SELECT CONVERT(DATE,[Order Date]) AS OrderDate
      --,[Row ID]
      ,[Order ID]
      --,[Ship Mode]
      --,[Customer ID]
      ,[Segment]
      --,[Country]
      ,[City]
      ,[State]
      --,[Postal Code]
      ,[Region]
      --,[Product ID]
      ,[Category]
      ,[Sub-Category] AS SubCategory
      ,[Product Name]
      ,[Sales]
      ,[Quantity]
      ,[Discount]
      ,[Profit]
  FROM [PortfolioProject].[dbo].[US_Ecommerce2020]
----------------------------------------------------------------------------------------------------------------------------
SELECT * FROM US_Ecom

-----------------------------------------------------------------------------------------------------------------------------

-- Shows Profit Margin by Category

SELECT Category, SUM(Sales) AS TotalSales, SUM(Profit) AS TotalProfit, ROUND((SUM(Profit)/SUM(Sales))*100,2) AS ProfitMargin 
FROM US_Ecom
GROUP BY Category
ORDER BY ProfitMargin DESC

-- Shows Profit Margin by Sub-Category

SELECT SubCategory, SUM(Sales) AS TotalSales, SUM(Profit) AS TotalProfit, ROUND((SUM(Profit)/SUM(Sales))*100,2) AS ProfitMargin 
FROM US_Ecom
GROUP BY SubCategory
ORDER BY TotalProfit DESC

-------------------------------------------------------------------------------------------------------------------------------
-- Shows Total Orders by Category

SELECT Category, COUNT([Order ID]) AS TotalOrders
FROM US_Ecom
GROUP BY Category
ORDER BY TotalOrders DESC
------------------------------------------------------------------------------------------------------------------------------
-- Shows Top 5 Sub Category by Total Orders

SELECT TOP(5) SubCategory, COUNT([Order ID]) AS TotalOrder
FROM US_Ecom 
GROUP BY SubCategory
ORDER BY TotalOrder DESC 

--------------------------------------------------------------------------------------------------------------------------------
-- Shows Top 5 City by Total Profit 

SELECT TOP(5) City, SUM(Profit) AS TotalProfit
FROM US_Ecom
GROUP BY City
ORDER BY TotalProfit DESC

--------------------------------------------------------------------------------------------------------------------------------
-- Show Top 5 City by Total Orders

SELECT TOP(5) City, COUNT([Order ID]) AS TotalOrders
FROM US_Ecom
GROUP BY City
ORDER BY TotalOrders DESC
