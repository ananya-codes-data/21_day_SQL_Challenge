# Day-19:
-- 1. Rank patients by satisfaction score within each service.
SELECT
	patient_id,
    name,
    service,
    satisfaction,
    DENSE_RANK() OVER (
		PARTITION BY
			service
		ORDER BY
			satisfaction DESC
	) AS rank_by_satisfaction_score
FROM patients;

-- 2. Assign row numbers to staff ordered by their name.
SELECT
	ROW_NUMBER() OVER (
		ORDER BY
			staff_name ASC
	) AS unique_id,
    staff_id,
    staff_name
FROM staff;

-- 3. Rank services by total patients admitted.
SELECT
	service,
	SUM(patients_admitted) AS total_patients_admitted,
    DENSE_RANK() OVER (
		ORDER BY
			SUM(patients_admitted) DESC
	) AS service_rank
FROM services_weekly
GROUP BY
	service;

-- Challenge:
/* For each service, rank the weeks by patient satisfaction score (highest first).
Show service, week, patient_satisfaction, patients_admitted, and the rank. 
Include only the top 3 weeks per service. */
SELECT
*
FROM (
	SELECT
		week,
		service,
		patient_satisfaction,
		patients_admitted,
		ROW_NUMBER() OVER (
			PARTITION BY
				service
			ORDER BY
				patient_satisfaction DESC
		) AS rank_of_week
	FROM services_weekly
) AS t
WHERE
	rank_of_week <= 3;