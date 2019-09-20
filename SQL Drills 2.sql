-- 1) Query for a list of all the unique values in the 'country' field

SELECT DISTINCT country
FROM ksprojects;

-- 2) Unique values for main_category field and for category field

SELECT COUNT(DISTINCT main_category) AS count_main_category,
COUNT(DISTINCT category) AS count_category
FROM ksprojects;

-- Answers are 15 and 158 for the count_main_category and the count_category, respectively

-- 3) List of all the unique combinations of main_category and category fields

SELECT DISTINCT main_category, category
FROM ksprojects
ORDER BY main_category;

-- 4) Unique categories in each main_category

SELECT main_category, COUNT(DISTINCT category)
FROM ksprojects
GROUP BY main_category
ORDER BY main_category;

-- 5) Query for the average number of backers per main_category 

SELECT main_category, round(AVG(backers),0) AS avg_backers
FROM ksprojects
GROUP BY main_category
ORDER BY avg_backers DESC;

-- 6) Query for each category for the successful campaigns and the average difference per project between dollars pledged and the goal 

SELECT category, AVG(usd_pledged - goal) AS raised_over_goal, COUNT(*)
FROM ksprojects
WHERE state = 'successful'
GROUP BY category;

-- 7) Query for each main category for projects that had zero backers for that category and the largest goal amount 
-- for that category and for projects with zero backers

SELECT main_category, MAX(goal), COUNT(*)
FROM ksprojects
WHERE backers = 0
GROUP BY main_category;

-- 8) The average USD per backer for each category and the results for which the average USD per backer is < $50

SELECT category, AVG(usd_pledged/NULLIF(backers,0)) AS avg_pledge_per_backer
FROM ksprojects
GROUP BY category
HAVING AVG(usd_pledged/NULLIF(backers,0)) < 50
ORDER BY avg_pledge_per_backer DESC;

-- 9) Query for each main_category for successful projects that had between 5 and 10 backers

SELECT main_category, COUNT(*)
FROM ksprojects
WHERE state = 'successful' AND backers BETWEEN 5 AND 10
GROUP BY main_category;

-- 10) A total of the amount 'pledged' for each type of currency grouped by its respective currency

SELECT currency, SUM(pledged)
FROM ksprojects
GROUP BY currency
ORDER BY SUM(pledged) DESC;

-- 11) The total of all backers for successful projects by main_category where the total was more than 100,000

SELECT main_category, SUM(backers)
FROM ksprojects
WHERE main_category NOT IN('Games', 'Technology') AND state = 'successful'
GROUP BY main_category
HAVING SUM(backers) > 100000
ORDER BY main_category;






