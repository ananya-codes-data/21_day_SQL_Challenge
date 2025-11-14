# Day-9:
-- 1. Extract the year from all patient arrival dates
SELECT
	arrival_date,
    YEAR(arrival_date)
FROM patients;

-- 2. Calculate the length of stay for each patient (departure_date - arrival_date)
SELECT
	name,
    DATEDIFF(departure_date, arrival_date)
FROM patients;

-- 3. Find all patients who arrived in a specific month
SELECT *,
	MONTHNAME(arrival_date) AS month_name
FROM patients;

#Challenge:
/* Calculate the average length of stay (in days) for each service, showing only services where the average stay is more than 7 days
Also show the count of patients and order by average stay descending */
SELECT
	service,
	COUNT(*),
    ROUND(AVG(DATEDIFF(departure_date, arrival_date)),2) AS average_stay
FROM patients
GROUP BY service
HAVING average_stay > 7
ORDER BY average_stay DESC;