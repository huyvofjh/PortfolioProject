-- Cleansed DIM_Date Table --
SELECT 
  [DateKey], 
  [FullDateAlternateKey] AS Date, 
  [EnglishDayNameOfWeek] AS Day, 
  LEFT([EnglishMonthName], 3) AS Month, 
  [MonthNumberOfYear] AS MonthNo, 
  [CalendarQuarter] AS Quarter, 
  [CalendarYear] AS Year 
FROM 
  [AdventureWorksDW2019].[dbo].[DimDate] 
WHERE 
  CalendarYear >= 2019

-----------------------------------------------------------------------------------------------

---- Cleansed DIM_Customer Table --
SELECT 
  c.CustomerKey AS [CustomerKey], 
  c.FirstName AS [FirstName], 
  c.LastName AS[LastName], 
  c.FirstName + ' ' + c.LastName AS FullName, 
  CASE Gender WHEN 'M' THEN 'Male' WHEN 'F' THEN 'Female' END AS Gender, -- Converted 'M' to 'Male" and 'F' to 'Female'
  c.[DateFirstPurchase] AS DateFirtstPurchase, 
  g.City AS CustomerCity 
FROM 
  [AdventureWorksDW2019].[dbo].[DimCustomer] AS c 
  LEFT JOIN [AdventureWorksDW2019].[dbo].[DimGeography] AS g ON g.GeographyKey = c.GeographyKey 
ORDER BY 
  c.CustomerKey ASC

-------------------------------------------------------------------------------------------------

---- Cleansed DIM_Product Table --
SELECT 
  p.[ProductKey] AS ProductKey, 
  p.[ProductAlternateKey] AS ProductItemCode, 
  p.[EnglishProductName] AS ProductName, 
  pc.EnglishProductCategoryName AS [Product Category], -- Joined in from DimProductCategory
  ps.EnglishProductSubcategoryName AS [Sub Category],  -- Joined in from DimProductSubcategory
  p.[Color] AS [Product Color], 
  p.[Size] AS [Product Size], 
  p.[ProductLine] AS [Product Line], 
  p.[ModelName] AS [Model Name], 
  p.[EnglishDescription] AS [Product Description], 
  ISNULL(p.Status, 'Outdated') AS [Product Status]  -- Converted 'NULL' to 'Outdated'
FROM 
  [AdventureWorksDW2019].[dbo].[DimProduct] AS p 
  LEFT JOIN [AdventureWorksDW2019].[dbo].[DimProductSubcategory] AS ps ON ps.ProductSubcategoryKey = p.ProductSubcategoryKey 
  LEFT JOIN [AdventureWorksDW2019].[dbo].[DimProductCategory] AS pc ON pc.ProductCategoryKey = ps.ProductCategoryKey 
ORDER BY 
  p.ProductKey ASC

--------------------------------------------------------------------------------------------------

-- Cleansed FACT_InternetSales Table -- 
SELECT 
  [ProductKey], 
  [OrderDateKey], 
  [DueDateKey], 
  [ShipDateKey], 
  [CustomerKey], 
  [SalesOrderNumber], 
  [TotalProductCost] AS [Product Cost],
  [SalesAmount] AS [Sales Amount]
FROM 
  [AdventureWorksDW2019].[dbo].[FactInternetSales] 
WHERE 
  LEFT(OrderDateKey, 4) >= YEAR(GETDATE())-2  -- Ensures we always only bring two years of date from extraction 
ORDER BY 
  OrderDateKey ASC

