# Day-2:
-- 1. Find all patients who are older than 60 years
SELECT 
    *
FROM patients
WHERE 
    age > 60;

-- 2. Retrieve all staff members who work in the 'Emergency' service
SELECT 
    *
FROM staff
WHERE 
    service = 'Emergency';

-- 3. List all weeks where more than 100 patients requested admission in any service
SELECT 
    *
FROM services_weekly
WHERE 
    patients_request > 100;

#Challenge:
-- Find all patients admitted to 'Surgery' service with a satisfaction score below 70, showing their patient_id, name, age, and satisfaction score
SELECT
	patient_id,
    name AS patient_name,
    age AS patient_age,
    satisfaction
FROM patients
WHERE 
    service = 'Surgery' 
    AND 
    satisfaction < 70;