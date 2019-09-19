-- 1) Records in the vehicles table

SELECT COUNT(*)
FROM vehicles;

-- Answer is 33,442

-- 2) Query for all the records in the vehicles table

SELECT *
FROM vehicles;

-- 3) Query for id, make, and model fields for all records for 2010 vehicles

SELECT id, make, model
FROM vehicles
WHERE year = 2010;

-- 4) Query for count of vehicles from 2010

SELECT COUNT(*)
FROM vehicles
WHERE year = 2010;

Answer is 1,109

-- 5) Query for the count of vehicles in the vehicles table from 2010 to 2015, inclusive

SELECT COUNT(*)
FROM vehicles
WHERE year BETWEEN 2010 AND 2015;

Answer is 5,995

-- 6) Query for the count of vehicles from 1990, 2000, and 2010

SELECT COUNT(*)
FROM vehicles
WHERE year IN(1990, 2000, 2010);

-- 7) Query for the count of all records between 1987 and 2005, exclusive of 1990 and 2000

SELECT COUNT(*)
FROM vehicles
WHERE year BETWEEN 1987 AND 2005
AND year NOT IN(1990, 2000);

Answer is 17,235

-- 8) Query for year, make, model, and average_mpg

SELECT year, make, model, (hwy + cty) / 2 AS average_mpg
FROM vehicles

-- 9) Query for year, make, model, and mpg_info

SELECT year, make, model, CONCAT(hwy, 'highway', cty, ' city;') AS mpg_info
FROM vehicles;

-- 10) Query for the id, make, model, and year for all records that have NULL for either the cyl or displ fields

SELECT id, make, model, year
FROM vehicles
WHERE cyl IS NULL OR displ IS NULL;

-- 11) Query for all fields for records with rear-wheel drive, diesel vehicles since 2000, inclusive, 
-- and sort by year and highway mileage, both descending 

SELECT *
FROM vehicles
WHERE drive = 'Rear-Wheel Drive' AND fuel = 'Diesel' AND year >= 2000
ORDER BY year DESC, hwy DESC;

-- 12) Query for the number of vehicles that are either Fords or Chevrolets and either 'Compact Cars' or 'Two Seaters'

SELECT COUNT(*)
FROM vehicles
WHERE make IN('Ford', 'Chevrolet') AND class IN('Compact Cars', 'Two Seaters');

Answer is 612

-- 13) Query for records of 10 vehicles with the highest highway fuel mileage

SELECT *
FROM vehicles
ORDER BY hwy DESC
LIMIT 10;

-- 14) Query for all records of vehicles since 2000 whose model name starts with a (capital) X

SELECT *
FROM vehicles
WHERE model LIKE 'X%' AND year >= 2000
ORDER BY make;

-- vs.

SELECT *
FROM vehicles
WHERE model LIKE 'x%' AND year year >= 2000
ORDER BY make;

-- In second case, you get different results -- a lot of Scions

-- 15) Query for the count of records where the "cyl" field is NULL

SELECT COUNT(*)
FROM vehicles
WHERE cyl IS NULL;

Answer is 58

-- 16) Query for the count of all records before 2000 that got more than 
-- 20 mpg hwy and had greater than 3 liters displacement ("displ" field) 

SELECT COUNT(*)
FROM vehicles
WHERE year < 2000 AND hwy > 20 AND displ > 3;

Answer is 1,964

-- 17) Query for all records whose model name has a (capital) X in its third position

SELECT *
FROM vehicles
WHERE model LIKE '_X%';

