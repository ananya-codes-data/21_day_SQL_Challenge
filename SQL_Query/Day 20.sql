# Day-20:
/* 1. Calculate running total of patients admitted by week for each service.
for each service there is one week ie 1 row - no need of sum(patient_admitted) or group by */
SELECT
	week,
    service,
    patients_admitted,
    SUM(patients_admitted) OVER (
		PARTITION BY
			service
		ORDER BY
			week
	) AS running_total
FROM services_weekly;

-- 2. Find the moving average of patient satisfaction over 4-week periods.
SELECT
	week,
    month,
    service,
    patient_satisfaction,
    ROUND(
		AVG(patient_satisfaction) OVER (
			ORDER BY
				week
			ROWS BETWEEN 3 PRECEDING AND CURRENT ROW
		),
        2
	) AS 4_week_moving_avg
FROM services_weekly;

/* 3. Show cumulative patient refusals by week across all services.
 Here across all services mean there are multiple service for 1 week so first group by week then find cumlative */
SELECT
	week,
	SUM(patients_refused) AS weekly_refusals,
    SUM(
		SUM(patients_refused)
	) OVER (
		ORDER BY
			week
	) AS cumulative_patient_refusals
FROM services_weekly
GROUP BY
	week;

/* Challenge: 
Create a trend analysis showing for each service and week: week number, patients_admitted,
running total of patients admitted (cumulative), 3-week moving average of patient satisfaction (current week and
2 prior weeks), and the difference between current week admissions and the service average.
Filter for weeks 10-20 only */
SELECT
*
FROM (
	SELECT
		week,
		SUM(patients_admitted) AS weekly_patients_admitted,
		SUM(
			SUM(patients_admitted)
		) OVER (
			ORDER BY
				week
		) AS cumulative_patients_admitted,
		ROUND(
			AVG(
				SUM(patient_satisfaction)
				) OVER (
					ORDER BY
						week
					ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
			),
			2
		) AS 3_week_moving_avg,
		SUM(patients_admitted) 
			- ROUND(
				AVG(
					SUM(patient_satisfaction)
				) OVER (
					ORDER BY
						week
				),
				2
			) AS diff
	FROM services_weekly
	GROUP BY
		week
) AS t
WHERE
	week BETWEEN 10 AND 20;