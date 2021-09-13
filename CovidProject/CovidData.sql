USE PortfolioProject

SELECT * FROM PortfolioProject..CovidDeaths
SELECT * FROM PortfolioProject..CovidVaccinations

-- Shows Countries in the World with Total Cases, Total Deaths, Percent of Population Infected and Total Vaccines
WITH PopvsVac (location, continent,population, TotalCases,TotalDeaths,PercentPopulationInfected,TotalVaccines) 
AS
(
SELECT dea.location,dea.continent,dea.population, SUM(dea.new_cases) AS TotalCases,SUM(CONVERT(int,dea.new_deaths)) AS TotalDeaths,
ROUND(MAX(dea.total_cases/dea.population)*100,2) AS PercentPopulationInfected,
MAX(CAST(vac.total_vaccinations AS int)) AS TotalVaccines
FROM CovidDeaths AS dea JOIN CovidVaccinations AS vac
ON dea.location = vac.location AND dea.date = vac.date 
WHERE dea.continent IS NOT NULL 
GROUP BY dea.location,dea.continent,dea.population
)
SELECT *,ROUND((TotalVaccines/population)*100,2) AS VacPerPopulation FROM PopvsVac

------------------------------------------------------------------------------------------------------------------------------------------

-- Shows Countries in Southeast Asia with Total Cases, Total Deaths, Percent of Population Infected and Total Vaccines
WITH PopvsVacSA (location, continent,population, TotalCases,TotalDeaths,PercentPopulationInfected,TotalVaccines) 
AS
(
SELECT dea.location,dea.continent,dea.population, SUM(dea.new_cases) AS TotalCases,SUM(CONVERT(int,dea.new_deaths)) AS TotalDeaths,
ROUND(MAX(dea.total_cases/dea.population)*100,2) AS PercentPopulationInfected,
MAX(CAST(vac.total_vaccinations AS int)) AS TotalVaccinations
FROM CovidDeaths AS dea JOIN CovidVaccinations AS vac
ON dea.location = vac.location AND dea.date = vac.date 
WHERE dea.continent IS NOT NULL AND dea.location IN 
('Brunei', 'Myanmar', 'Cambodia', 'Timor', 'Indonesia', 'Laos', 'Malaysia', 'Philippines', 'Singapore', 'Thailand', 'Vietnam')
GROUP BY dea.location,dea.continent,dea.population
)
SELECT *,ROUND((TotalVaccines/population)*100,2) AS VacPerPopulation FROM PopvsVacSA

--------------------------------------------------------------------------------------------------------------------------------------------

-- Shows New Cases, Rolling People Infected, New Deaths, Rolling People Dead in Vietnam
SELECT location, population,date,SUM(new_cases) AS NewCases, MAX(total_cases) AS TotalCasesCount,
SUM(CAST(new_deaths AS int)) AS NewDeaths, MAX(CAST(total_deaths AS int)) AS TotalDeaths
FROM CovidDeaths
WHERE continent IS NOT NULL AND location = 'Vietnam'
GROUP BY location, population,date
