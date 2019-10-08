-- 1) Inspecting the schema of the naep table

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'naep';

SELECT *
FROM naep
WHERE year = 2000;

-- 2) The first 50 records of the naep table

SELECT *
FROM naep
LIMIT 50;

-- 3) Summary statistics for avg_math_4_score by state and sorting the results alphabetically by the state name

SELECT COUNT(avg_math_4_score) AS count_avg_math_4_score, AVG(avg_math_4_score) AS avg_avg_math_4_score, 
SUM(avg_math_4_score) AS sum_avg_math_4_score, MAX(avg_math_4_score) AS max_avg_math_4_score, 
MIN(avg_math_4_score) AS min_avg_math_4_score, state
FROM naep
GROUP BY state
ORDER BY state;

-- 4) Summary statistics for avg_math_4_score by state with with differences in max and min values that are greater than 30

SELECT COUNT(avg_math_4_score) AS count_avg_math_4_score, AVG(avg_math_4_score) AS avg_avg_math_4_score, 
SUM(avg_math_4_score) AS sum_avg_math_4_score, MAX(avg_math_4_score) AS max_avg_math_4_score, 
MIN(avg_math_4_score) AS min_avg_math_4_score, (MAX(avg_math_4_score) - MIN(avg_math_4_score)) AS diff_max_min_avg_math_4_score, state
FROM naep
GROUP BY state
HAVING (MAX(avg_math_4_score) - MIN(avg_math_4_score)) > 30
ORDER BY state;

-- 5) Bottom_10_states lists the states in the bottom 10 for avg_math_4_score in the year 2000

SELECT state AS bottom_10_states
FROM naep
WHERE year = 2000
ORDER BY avg_math_4_score DESC
LIMIT 10;

-- 6) Calculating the average avg_math_4_score rounded to the nearest 2 decimal places over all states in the year 2000

SELECT ROUND(AVG(avg_math_4_score), 2) AS avg_avg_math_4_score
FROM naep
WHERE year = 2000;

-- 7) Below_average_states_y2000 lists all states with an avg_math_4_score less than the average over all states in the year 2000

SELECT state AS below_average_states_y2000
FROM naep
WHERE year = 2000 AND avg_math_4_score < 224.80;

-- 8) Scores_missing_y2000 lists any states with missing values in the avg_math_4_score column of the naep data table for the year 2000

SELECT state AS scores_missing_y2000
FROM naep
WHERE year = 2000 AND avg_math_4_score IS NULL;

-- 9) The state, avg_math_4_score, and total expenditure from the naep table left outer joined with the finance table, 
-- using id as the key and ordered by total_expenditure greatest to least

SELECT naep.state, ROUND(avg_math_4_score, 2), total_expenditure
FROM naep LEFT OUTER JOIN finance
ON naep.id = finance.id
WHERE naep.year = 2000 AND avg_math_4_score IS NOT NULL
GROUP BY naep.state, avg_math_4_score, total_expenditure
ORDER BY total_expenditure DESC;
