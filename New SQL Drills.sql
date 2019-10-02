-- 1) Schema of the relationship between the people, salaries, and hof_inducted tables

-- The diagram and answers for this problem are in a separate file.

-- 2) The namefirst and namelast fields of the people table and the inducted field from the hof_inducted table

SELECT namefirst, namelast, inducted
FROM people LEFT OUTER JOIN hof_inducted
ON people.playerid = hof_inducted.playerid;

-- 3) The first names, last names, birth dates, death dates, and birth countries for players from the negro baseball leagues

SELECT birthyear, deathyear, birthcountry, namefirst, namelast
FROM people LEFT OUTER JOIN hof_inducted
ON people.playerid = hof_inducted.playerid
WHERE yearid = 2006 AND votedby = 'Negro League';

-- 4) The yearid, playerid, teamid, and salary fields from the salaries table and the category field from the hof_inducted table

SELECT salaries.yearid, salaries.playerid, teamid, salary, category
FROM salaries INNER JOIN hof_inducted
ON salaries.playerid = hof_inducted.playerid;

-- 5) The playerid, yearid, teamid, lgid, and salary fields from the salaries table and the inducted field from the hof_inducted table

SELECT salaries.playerid, salaries.yearid, teamid, lgid, salary, inducted
FROM hof_inducted FULL OUTER JOIN salaries
ON hof_inducted.playerid = salaries.playerid

-- 6) The hof_inducted and hof_not_inducted tables

SELECT * FROM hof_inducted
UNION ALL
SELECT * FROM hof_not_inducted;

SELECT playerid FROM hof_inducted
UNION
SELECT playerid FROM hof_not_inducted;

-- 7) The last name, first name, and total recorded salaries for all players found in the salaries table

SELECT namelast, namefirst, SUM(salary)
FROM salaries LEFT OUTER JOIN people
ON salaries.playerid = people.playerid
GROUP BY namelast, namefirst
ORDER BY namelast, namefirst;

-- 8) Records from the hof_inducted and hof_not_inducted tables that include playerid, namefirst, and namelast

SELECT hof_inducted.playerid, yearid, namefirst, namelast
FROM hof_inducted LEFT OUTER JOIN people
ON hof_inducted.playerid = people.playerid

UNION ALL

SELECT hof_not_inducted.playerid, yearid, namefirst, namelast
FROM hof_not_inducted LEFT OUTER JOIN people 
ON hof_not_inducted.playerid = people.playerid;

-- 9) A table including all records from both hof_inducted and hof_not_inducted, and include a new field, namefull, 
-- which is formatted as namelast, namefirst (in other words, the last name, followed by a comma, then a space, 
-- then the first name) and the yearid and inducted fields and include only records since 1980 from both tables

SELECT CONCAT(namelast,',', namefirst) AS namefull, yearid, inducted
FROM hof_inducted LEFT OUTER JOIN people
ON hof_inducted.playerid = people.playerid
WHERE YEARID >= 1980

UNION ALL

SELECT CONCAT(namelast,',', namefirst) AS namefull, yearid, inducted
FROM hof_not_inducted LEFT OUTER JOIN people
ON hof_not_inducted.playerid = people.playerid
WHERE yearid >= 1980

ORDER BY yearid, inducted DESC, namefull;

-- 10) The highest annual salary for each teamid, ranked from high to low, along with the corresponding playerid, 
-- and the namelast and namefirst in the resulting table

SELECT yearid, teamid, playerid, salary
FROM salaries
WHERE salary IN
       (SELECT MAX(salary)
	   FROM salaries
	   GROUP BY yearid, teamid)
ORDER BY salary DESC;

SELECT yearid, teamid, salaries.playerid, namelast, namefirst, salary
FROM salaries LEFT OUTER JOIN people
      ON salaries.playerid = people.playerid
WHERE salary IN
       (SELECT MAX(salary)
	   FROM salaries
	   GROUP BY yearid, teamid)
ORDER BY salary DESC;

-- 11) Birthyear, deathyear, namefirst, and namelast of all the players born since the birth year of Babe Ruth

SELECT birthyear, deathyear, namefirst, namelast
FROM people
WHERE birthyear > ANY
       (SELECT birthyear
	   FROM people
	   WHERE playerid = 'ruthba01')
ORDER BY birthyear;

-- 12) Namefirst, namelast, and a field called usaborn

SELECT namefirst, namelast,
        CASE
		        WHEN birthcountry = 'USA' THEN 'USA'
				ELSE 'non-USA'
		END AS usaborn
FROM people
ORDER BY 3;

-- 13) Average height for players throwing with their right hand versus their left hand

SELECT 
AVG(CASE WHEN throws = 'R' THEN height END) AS right_height,
AVG(CASE WHEN throws = 'L' THEN height END) AS left_height
FROM people;

-- 14) Average of each team's maximum player salary since 2010

WITH max_sal_by_team_by_year AS
       (SELECT teamid, yearid, MAX(salary) AS max_sal
	   FROM salaries
	   GROUP BY teamid, yearid)
SELECT teamid, AVG(max_sal) AS avg_max_sal_since_2010
       FROM max_sal_by_team_by_year
	   WHERE yearid > 2010
	   GROUP BY teamid;
