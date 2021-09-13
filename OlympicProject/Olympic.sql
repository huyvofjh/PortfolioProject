-- Data for Visualization
SELECT 
  ath.[ID], 
  ath.[Name] AS Competitor, 
  CASE WHEN ath.[Sex] = 'M' THEN 'Male'  -- Convert "M" and "F" to "Male" and "Female"
       WHEN ath.[Sex] = 'F' THEN 'Female' END AS Gender, 
  CASE WHEN ath.[Age] < 18 THEN 'Under 18' -- Convert Age to Age Grouping
       WHEN ath.[Age] BETWEEN 18 AND 25 THEN '18-25' 
       WHEN ath.[Age] BETWEEN 25 AND 30 THEN '25-30' 
       WHEN ath.[Age] > 30 THEN 'Over 30' END AS Age, 
  ath.[Height], 
  ath.[Weight], 
  ath.[NOC] AS CountryCode, 
  SUBSTRING(ath.Games, 1, CHARINDEX(' ', ath.Games)-1) AS Year, -- Breaking out Games into individual columns (Year, Season)
  -- LEFT(ath.Games, CHARINDEX(' ',ath.Games)-1) AS Year,
  -- RIGHT(ath.Games, CHARINDEX(' ',REVERSE(ath.Games))-1) AS Season
  SUBSTRING(ath.Games, CHARINDEX(' ', ath.Games)+ 1, LEN(ath.Games)) AS Season , 
  ath.[City], 
  ath.[Sport], 
  ath.[Event], 
  CASE WHEN ath.[Medal] = 'NA' THEN 'No Information' -- Convert "NA" to "No Information" 
  ELSE ath.Medal END AS Medal, 
  coun.Definition AS Country 
FROM olympic_games..athletes_event_results AS ath 
  LEFT JOIN olympic_games..[dbo.countrycode] AS coun 
  ON ath.NOC = coun.[Code Value]

---------------------------------------------------------------------------------

-- Shows the Total Athletes in the Summer (Winter) Olympic Games
WITH OlympicCTE (ID, Name,Year, Season) AS (
SELECT ID, 
  Name,
  SUBSTRING(Games, 1, CHARINDEX(' ', Games)-1) AS Year, 
  SUBSTRING(Games, CHARINDEX(' ', Games)+ 1, LEN(Games)) AS Season 
FROM olympic_games..athletes_event_results 
)
SELECT COUNT(DISTINCT(ID)) AS NumberOfAthletes FROM OlympicCTE
WHERE Season = 'Summer'

---------------------------------------------------------------------------------

-- Shows the Total Number of Medals in the Summer (Winter) Olympic Games
WITH OlympicCTE (ID, Name,Medal, Year, Season) AS (
SELECT ID, 
  Name, 
  Medal,
  SUBSTRING(Games, 1, CHARINDEX(' ', Games)-1) AS Year, 
  SUBSTRING(Games, CHARINDEX(' ', Games)+ 1, LEN(Games)) AS Season 
FROM olympic_games..athletes_event_results 
)
SELECT COUNT(Medal)AS NumberOfMedals FROM OlympicCTE
WHERE Season = 'Summer' AND Medal <> 'NA'

SELECT * FROM olympic_games..athletes_event_results
----------------------------------------------------------------------------------

-- Shows the Number of Medals in the Summer (Winter) Olympic Games
WITH OlympicCTE (ID, Name,Medal, Year, Season) AS (
SELECT ID, 
  Name, 
  Medal,
  SUBSTRING(Games, 1, CHARINDEX(' ', Games)-1) AS Year, 
  SUBSTRING(Games, CHARINDEX(' ', Games)+ 1, LEN(Games)) AS Season 
FROM olympic_games..athletes_event_results 
)
SELECT DISTINCT(Medal), COUNT(Medal)AS NumberOfMedals FROM OlympicCTE
WHERE Season = 'Summer' AND Medal <> 'NA'
GROUP BY Medal  
