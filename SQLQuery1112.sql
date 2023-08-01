
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM CovidDeaths
ORDER BY 1,2

--Total cases vs Total deaths

SELECT location, date, total_cases, new_cases, total_deaths, population, (total_deaths/total_cases)*100 as death_percentage
FROM CovidDeaths
ORDER BY 1,2

-- Total cases vs total deaths for Nigeria

SELECT location, date, total_cases, new_cases, total_deaths, population, (total_deaths/total_cases)*100 as death_percentage
FROM CovidDeaths
WHERE location = 'Nigeria'
ORDER BY 1,2


-- Total cases vs total deaths for USA

SELECT location, date, total_cases, new_cases, total_deaths, population, (total_deaths/total_cases)*100 as death_percentage
FROM CovidDeaths
WHERE location LIKE '%states%' -- LIKE is used where the actual name of the location or variable is not fully known
ORDER BY 1,2

--total cases vs total population which shows percentage of population affected with covid

SELECT location, date, total_cases, new_cases, total_deaths, population, (total_cases/population)*100 as percentage_affected
FROM CovidDeaths
ORDER BY 1,2

-- percentage affected in Nigeria

SELECT location, date, total_cases, new_cases, total_deaths, population, (total_cases/population)*100 as percentage_affected
FROM CovidDeaths
WHERE location = 'Nigeria'
ORDER BY 1,2

--Countries with the highest infection rate compared to population

SELECT location,population,MAX(total_cases) AS highestinfectionrate, MAX((total_cases/population))*100 as percentage_hihgestinfect
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location,population
ORDER BY 4 DESC


-- Countires with highest deathrate 
SELECT location,MAX(CAST(total_deaths AS int)) AS total_deathcount
--CAST was used to change the variable type to integer
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP By Location
ORDER BY 2 DESC

--Break down by continent

SELECT location,MAX(CAST(total_deaths AS int)) AS total_deathcount
--CAST was used to change the variable type to integer
FROM CovidDeaths
WHERE continent IS NULL
GROUP By Location
ORDER BY 2 DESC

--Break down by continent

SELECT  location, MAX(CAST(total_deaths AS int)) AS total_deathcount
--CAST was used to change the variable type to integer
FROM CovidDeaths
WHERE continent IS NULL
GROUP By location
ORDER BY 2 DESC


--Break down by continent

SELECT  continent, MAX(CAST(total_deaths AS int)) AS total_deathcount
--CAST was used to change the variable type to integer
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP By continent
ORDER BY 2 DESC

--sum of new cases daily worldwide

SELECT date,SUM(new_cases) AS dailyinfectionWorldwide
FROM CovidDeaths
GROUP BY date
ORDER BY 2 DESC

--sum of new cases daily worldwide

SELECT date,SUM(new_cases) AS dailyinfectionWorldwide
FROM CovidDeaths
WHERE continent is not null
GROUP BY date
ORDER BY 2 DESC

--sum of total deaths daily worldwide
SELECT date,SUM(CAST(total_deaths AS INT)) AS dailydeathWorldwide
FROM CovidDeaths
GROUP BY date
ORDER BY 2 DESC

--sum of total deaths daily worldwide for only continets 
SELECT date,SUM(CAST(total_deaths AS INT)) AS dailydeathWorldwide
FROM CovidDeaths
WHERE continent is not null
GROUP BY date
ORDER BY 2 DESC

--percentage of sum of new cases against sum of new deaths 

select date, SUM(new_cases) AS total_cases, SUM(CAST(new_deaths AS INT)) AS total_deaths, SUM(CAST(new_deaths AS INT))/SUM(new_cases) * 100 As DeathPercentage
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY DeathPercentage DESC

-- below script gives sum total of new cases, sum total of news deaths and their percentage

select SUM(new_cases) AS total_cases, SUM(CAST(new_deaths AS INT)) AS total_deaths, SUM(CAST(new_deaths AS INT))/SUM(new_cases) * 100 As DeathPercentage
FROM CovidDeaths
WHERE continent IS NOT NULL








