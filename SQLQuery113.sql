  
-- Total population vaccinated in the World daily
  SELECT covde.date,covde.population, SUM(CAST(covac.new_vaccinations AS INT)) AS totalDailyvacinationworld
  FROM CovidVaccinations As covac
  JOIN CovidDeaths As covde
  ON covac.location = covde.location
  AND covac.date = covde.date
  WHERE covde.continent IS NOT NULL
  GROUP BY covde.date,covde.population
  ORDER BY 3 DESC

  -- Total population vaccinated in the World daily
  SELECT covde.continent,covde.location,covde.date,covde.population, covac.new_vaccinations, 
  SUM(CAST(covac.new_vaccinations AS INT)) OVER (PARTITION BY covde.location ORDER BY covde.location, covde.date)  AS rollingvacinatoncount
  FROM CovidVaccinations As covac
  JOIN CovidDeaths As covde
  ON covac.location = covde.location
  AND covac.date = covde.date
  WHERE covde.continent IS NOT NULL
  ORDER BY 2,3

  -- using CTE to perform further calculations (below cte helps us know rolling count of percentage vaccinated daily)
  WITH populationvacinated (continent,location,date,population,new_vaccinations,rollingvacinatoncount)
  AS
  (-- Total population vaccinated in the World daily
  SELECT covde.continent,covde.location,covde.date,covde.population, covac.new_vaccinations, 
  SUM(CAST(covac.new_vaccinations AS INT)) OVER (PARTITION BY covde.location ORDER BY covde.location, covde.date)  AS rollingvacinatoncount
  FROM CovidVaccinations As covac
  JOIN CovidDeaths As covde
  ON covac.location = covde.location
  AND covac.date = covde.date
  WHERE covde.continent IS NOT NULL)
  SELECT *, (rollingvacinatoncount/population)*100 as rollingpercentagevacinnated
  FROM populationvacinated


 -- using temp table to archieve same result
 drop table if exists #percentpopvacinated
 CREATE TABLE #percentpopvacinated
 ( 
 continent nvarchar(255),
 location nvarchar(255),
 date  datetime,
 population numeric,
 new_vaccinations numeric,
 rollingvacinatoncount numeric,
 )
 INSERT INTO #percentpopvacinated
 SELECT covde.continent,covde.location,covde.date,covde.population, covac.new_vaccinations, 
  SUM(CAST(covac.new_vaccinations AS INT)) OVER (PARTITION BY covde.location ORDER BY covde.location, covde.date)  AS rollingvacinatoncount
  FROM CovidVaccinations As covac
  JOIN CovidDeaths As covde
  ON covac.location = covde.location
  AND covac.date = covde.date
  WHERE covde.continent IS NOT NULL
  ORDER BY 2,3
  SELECT *, (rollingvacinatoncount/population)*100 AS rollingvacinatoncount
  FROM #percentpopvacinated
  --drop table if exits is very important because it helps make the table reusable when you decide to change things 

  CREATE VIEW percentpopvacinated AS
  SELECT covde.continent,covde.location,covde.date,covde.population, covac.new_vaccinations, 
  SUM(CAST(covac.new_vaccinations AS INT)) OVER (PARTITION BY covde.location ORDER BY covde.location, covde.date)  AS rollingvacinatoncount
  FROM CovidVaccinations As covac
  JOIN CovidDeaths As covde
  ON covac.location = covde.location
  AND covac.date = covde.date
  WHERE covde.continent IS NOT NULL
  --ORDER BY 2,3
  -- YOU CAN NOT USE ORDER BY IN VIEWS

  SELECT *
  FROM percentpopvacinated 

 