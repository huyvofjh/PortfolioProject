-- Cleansed DIM_Product Table --
SELECT 
  p.[ProductKey] AS ProductKey, 
  p.[ProductAlternateKey] AS ProductItemCode, 
  --[ProductSubcategoryKey]
  --[WeightUnitMeasureCode]
  --[SizeUnitMeasureCode]
  p.[EnglishProductName] AS ProductName, 
  pc.EnglishProductCategoryName AS [Product Category], -- Joined in from DimProductCategory
  ps.EnglishProductSubcategoryName AS [Sub Category],  -- Joined in from DimProductSubcategory
  --[SpanishProductName]
  --[FrenchProductName]
  --[StandardCost]
  --[FinishedGoodsFlag] 
  p.[Color] AS [Product Color], 
  --[SafetyStockLevel]
  --[ReorderPoint]
  --[ListPrice]
  p.[Size] AS [Product Size], 
  --[SizeRange]
  --p.[Weight] AS Weight
  --[DaysToManufacture] 
  p.[ProductLine] AS [Product Line], 
  --[DealerPrice]
  --[Class]
  --[Style] 
  p.[ModelName] AS [Model Name], 
  --[LargePhoto]
  p.[EnglishDescription] AS [Product Description], 
  --[FrenchDescription]
  --[ChineseDescription]
  --[ArabicDescription]
  --[HebrewDescription]
  --[ThaiDescription]
  --[GermanDescription]
  --[JapaneseDescription]
  --[TurkishDescription]
  --[StartDate]
  --[EndDate]
  ISNULL(p.Status, 'Outdated') AS [Product Status]  -- Converted 'NULL' to 'Outdated'
FROM 
  [AdventureWorksDW2019].[dbo].[DimProduct] AS p 
  LEFT JOIN [AdventureWorksDW2019].[dbo].[DimProductSubcategory] AS ps ON ps.ProductSubcategoryKey = p.ProductSubcategoryKey 
  LEFT JOIN [AdventureWorksDW2019].[dbo].[DimProductCategory] AS pc ON pc.ProductCategoryKey = ps.ProductCategoryKey 
ORDER BY 
  p.ProductKey ASC
