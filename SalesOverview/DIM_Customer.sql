-- Cleansed DIM_Customer Table --
SELECT 
  c.CustomerKey AS [CustomerKey], 
  --[GeographyKey]
  --[CustomerAlternateKey]
  --[Title]
  c.FirstName AS [FirstName], 
  --[MiddleName]
  c.LastName AS[LastName], 
  c.FirstName + ' ' + c.LastName AS FullName, 
  --[NameStyle]
  --[BirthDate]
  --[MaritalStatus]
  --[Suffix]
  CASE Gender WHEN 'M' THEN 'Male' WHEN 'F' THEN 'Female' END AS Gender, -- Converted 'M' to 'Male" and 'F' to 'Female'
  --[EmailAddress]
  --[YearlyIncome]
  --[TotalChildren]
  --[NumberChildrenAtHome]
  --[EnglishEducation]
  --[SpanishEducation]
  --[FrenchEducation]
  --[EnglishOccupation]
  --[SpanishOccupation]
  --[FrenchOccupation]
  --[HouseOwnerFlag]
  --[NumberCarsOwned]
  --[AddressLine1]
  --[AddressLine2]
  --[Phone]
  c.[DateFirstPurchase] AS DateFirtstPurchase, 
  --[CommuteDistance]
  g.City AS CustomerCity -- Joined in from DimGeography Table 
FROM 
  [AdventureWorksDW2019].[dbo].[DimCustomer] AS c 
  LEFT JOIN [AdventureWorksDW2019].[dbo].[DimGeography] AS g ON g.GeographyKey = c.GeographyKey 
ORDER BY 
  c.CustomerKey ASC
