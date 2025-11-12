# Day-5:
-- 1. Count the total number of patients in the hospital
SELECT
    COUNT(patient_id)
FROM patients;

-- 2. Calculate the average satisfaction score of all patients
SELECT
	AVG(satisfaction) AS avg_satisfaction_score
FROM patients;

-- 3. Find the minimum and maximum age of patients
SELECT
	MAX(age) AS oldest,
    MIN(age) AS youngest
FROM patients;

#Challenge:
/* Calculate the total number of patients admitted, total patients refused, and the average patient satisfaction across all services and weeks
Round the average satisfaction to 2 decimal places */
SELECT
	SUM(patients_admitted),
    SUM(patients_refused),
    ROUND(AVG(patient_satisfaction),2) AS avg_satisfaction_score
FROM services_weekly;