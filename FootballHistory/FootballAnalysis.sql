SELECT * FROM PortfolioProject..football

--------------------------------------------------------------------
-- Shows the Match, Score, Goal Difference between the teams, the match which has most Goal Difference
SELECT date,
CONCAT(home_team,'-',away_team) AS Match, -- Use CONCAT to combine two columns 
home_team, away_team, 
CONCAT(home_score,'-',away_score) AS Score,
home_score, away_score,
ABS(home_score - away_score) AS GoalDifference,
CASE WHEN (home_score > away_score) THEN 'Win'
	WHEN (home_score = away_score) THEN 'Draw'
	WHEN (home_score < away_score) THEN 'Lose' END AS HomeTeamsResult,
CASE WHEN (home_score < away_score) THEN 'Win'
	WHEN (home_score = away_score) THEN 'Draw'
	WHEN (home_score > away_score) THEN 'Lose' END AS AwayTeamsResult,
tournament, city, country,
CASE WHEN neutral = 0 THEN 'No'
	 WHEN neutral = 1 THEN 'Yes' END NeutralStadium
FROM PortfolioProject..football
ORDER BY GoalDifference DESC

-------------------------------------------------------------------------
-- Show the home team which has scored most
SELECT home_team, SUM(home_score) TotalHomeGoals
FROM PortfolioProject..football
GROUP BY home_team
ORDER BY TotalHomeGoals DESC

----------------------------------------------------------------------------
-- Show the away team which has scored most
SELECT away_team, SUM(away_score) TotalAwayGoals
FROM PortfolioProject..football
GROUP BY away_team
ORDER BY TotalAwayGoals DESC

-----------------------------------------------------------------------------
CREATE VIEW FB AS
SELECT date,
CONCAT(home_team,'-',away_team) AS Match, -- Use CONCAT to combine two columns 
home_team, away_team, 
CONCAT(home_score,'-',away_score) AS Score,
home_score, away_score,
ABS(home_score - away_score) AS GoalDifference,
CASE WHEN (home_score > away_score) THEN 'Win'
	WHEN (home_score = away_score) THEN 'Draw'
	WHEN (home_score < away_score) THEN 'Lose' END AS HomeTeamsResult,
CASE WHEN (home_score < away_score) THEN 'Win'
	WHEN (home_score = away_score) THEN 'Draw'
	WHEN (home_score > away_score) THEN 'Lose' END AS AwayTeamsResult,
tournament, city, country,
CASE WHEN neutral = 0 THEN 'No'
	 WHEN neutral = 1 THEN 'Yes' END NeutralStadium
FROM PortfolioProject..football
--ORDER BY GoalDifference DESC

--------------------------------------------------------------------------------
-- Shows the Home Teams has the win matches most
SELECT home_team,COUNT(*) AS WinMatches FROM FB
WHERE HomeTeamsResult = 'Win'
GROUP BY home_team
ORDER BY COUNT(*) DESC

--------------------------------------------------------------------------------
-- Shows the Away Teams has the win matches most
SELECT away_team,COUNT(*) AS WinMatches FROM FB
WHERE AwayTeamsResult = 'Win'
GROUP BY away_team
ORDER BY COUNT(*) DESC
