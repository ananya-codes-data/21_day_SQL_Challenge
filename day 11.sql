# Day-10:
-- 1. Categorise patients as 'High', 'Medium', or 'Low' satisfaction based on their scores
SELECT 
	name,
    service,
	CASE
		WHEN satisfaction >= 90 THEN 'High'
        WHEN satisfaction >= 75 THEN 'Medium'
        ELSE 'Low'
	END AS satisfaction_category
FROM patients;

-- 2. Label staff roles as 'Medical' or 'Support' based on role type
SELECT
	staff_name,
    service,
    CASE
		WHEN role IN ('doctor', 'nurse') THEN 'Medical'
        ELSE 'Support'
	END AS role_type
FROM staff;

-- 3. Create age groups for patients (0-18, 19-40, 41-65, 65+)
SELECT
	name,
    age,
    CASE
		WHEN age BETWEEN 0 AND 18 THEN 'Minor'
        WHEN age BETWEEN 19 AND 40 THEN 'Adult'
        WHEN age BETWEEN 41 AND 65 THEN 'Senior'
        ELSE 'Super Senior'
	END AS age_group
FROM patients;

#Challenge:
/* Create a service performance report showing service name, total patients admitted,
and a performance category based on the following: 'Excellent' if avg satisfaction >= 85, 'Good' if >= 75, 'Fair' if >= 65,
otherwise 'Needs Improvement'
Order by average satisfaction descending */
SELECT
	service,
    SUM(patients_admitted) AS total_patients_admitted,
    ROUND(AVG(patient_satisfaction),2) AS avg_satisfaction,
    CASE
		WHEN ROUND(AVG(patient_satisfaction),2) >= 85 THEN 'Excellent'
        WHEN ROUND(AVG(patient_satisfaction),2) >= 75 THEN 'Good'
        WHEN ROUND(AVG(patient_satisfaction),2) >= 65 THEN 'Fair'
        ELSE 'Needs Improvement'
	END AS performance_category
FROM services_weekly
GROUP BY service
ORDER BY avg_satisfaction DESC;