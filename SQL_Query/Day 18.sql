# Day 18:
-- 1. Combine patient names and staff names into a single list.
SELECT
	'patients' AS Patient_name,
    name
FROM patients

UNION ALL

SELECT
	'staff' AS Staff_name,
    staff_name
FROM staff;

-- 2. Create a union of high satisfaction patients (>90) and low satisfaction patients (<50).
SELECT
	name,
    satisfaction
FROM patients
WHERE
	satisfaction > 90

UNION ALL

SELECT
	name,
    satisfaction
FROM patients
WHERE
	satisfaction < 50;

-- 3. List all unique names from both patients and staff tables.
SELECT
	'patients' AS Type,
    name
FROM patients

UNION

SELECT
	'staff' AS Type,
    staff_name
FROM staff;

# Challenge: 
/* Create a comprehensive personnel and patient list showing: identifier (patient_id or staff_id), 
full name, type ('Patient' or 'Staff'), and associated service. Include only those in 'surgery' or 'emergency'
services. Order by type, then service, then name. */
SELECT
	'patients' AS type,
	patient_id AS identifier,
    name AS Full_name,
    service
FROM patients
WHERE
	service IN ('Surgery', 'Emergency')

UNION ALL

SELECT
	'staff' AS type,
	staff_id AS identifier,
    staff_name AS Full_name,
    service
FROM staff
WHERE
	service IN ('Surgery', 'Emergency')
ORDER BY
	type ASC,
    service ASC,
    Full_name ASC;