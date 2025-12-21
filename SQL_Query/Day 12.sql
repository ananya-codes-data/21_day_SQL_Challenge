# Day-12:
-- 1. Find all weeks in services_weekly where no special event occurred
SELECT
	week,
    event
FROM services_weekly
WHERE
	event IS NULL
    OR
    event = 'none';
    
-- 2. Count how many records have null or empty event values
SELECT
	COUNT(event) AS records_without_events
FROM services_weekly
WHERE
	event IS NULL
    OR
    event = 'none';

-- 3. List all services that had at least one week with a special event
SELECT DISTINCT
	service
FROM services_weekly
WHERE 
	event IS NOT NULL
    OR
	event != 'none'
    OR
    event != ' ';

#Challenge:
/* Analyze the event impact by comparing weeks with events vs weeks without events
Show: event status ('With Event' or 'No Event'), count of weeks, average patient satisfaction, and average staff morale
Order by average patient satisfaction descending */
SELECT
	CASE
		WHEN event IS NULL
			OR
            event = 'none'
            OR
            event = ' ' THEN 'without_event'
		ELSE 'with_event'
	END AS event_status,
	COUNT(*) AS number_of_weeks,
	ROUND(AVG(patient_satisfaction), 2) AS avg_patient_satisfaction,
    ROUND(AVG(staff_morale), 2) AS avg_staff_morale
FROM services_weekly
GROUP BY
	event_status
ORDER BY
	avg_patient_satisfaction DESC;