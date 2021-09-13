-- Create Temporary Table, shows Hotel Data and use join to add discount, market segment, cost, meal, country column between 2018 and 2020
WITH HotelTemp AS (
SELECT * FROM PortfolioProject..[2018HotelData]
UNION
SELECT * FROM PortfolioProject..[2019HotelData]
UNION
SELECT * FROM PortfolioProject..[2020HotelData]
)
SELECT * FROM HotelTemp 
LEFT JOIN PortfolioProject..market_segment
ON HotelTemp.market_segment = market_segment.market_segment
LEFT JOIN PortfolioProject..meal_cost
ON HotelTemp.meal = meal_cost.meal
LEFT JOIN PortfolioProject..CountryCode
ON HotelTemp.country  = CountryCode.[Code Value]
WHERE YEAR(HotelTemp.reservation_status_date) BETWEEN 2018 AND 2020