-- TO CREATE A DATABASE:
CREATE DATABASE hospital
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

/* TO CREATE TABLE
AND ADD COLUMNS INSIDE IT: */

USE hospital;

-- 1. Patients Table
CREATE TABLE patients (
    patient_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    arrival_date DATE,
    departure_date DATE,
    service VARCHAR(50),
    satisfaction INT
);

-- 2. Services Weekly Table
CREATE TABLE services_weekly (
    week INT,
    month INT,
    service VARCHAR(50),
    available_beds INT,
    patients_request INT,
    patients_admitted INT,
    patients_refused INT,
    patient_satisfaction INT,
    staff_morale INT,
    event VARCHAR(100)
);

-- 3. Staff Table
CREATE TABLE staff (
    staff_id VARCHAR(50) PRIMARY KEY,
    staff_name VARCHAR(100),
    role VARCHAR(50),
    service VARCHAR(50)
);

-- 4. Staff Schedule Table
CREATE TABLE staff_schedule (
    week INT,
    staff_id VARCHAR(50),
    staff_name VARCHAR(100),
    role VARCHAR(50),
    service VARCHAR(50),
    present TINYINT(1),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

# Day-1:
-- 1. Retrieve all columns from the patients table 
SELECT * 
FROM patients; 

-- 2. Select only the patient_id, name, and age columns from the patients table
SELECT
	patient_id,
	name AS patient_name,
	age AS patient_age
FROM patients;

-- 3. Display the first 10 records from the services_weekly table
SELECT *
FROM services_weekly
LIMIT 10;

#Challenge:
-- List all unique hospital services available in the hospital
SELECT DISTINCT service
FROM services_weekly;

# Day-2:
-- 1. Find all patients who are older than 60 years
SELECT *
FROM patients
WHERE age > 60;

-- 2. Retrieve all staff members who work in the 'Emergency' service
SELECT *
FROM staff
WHERE service = 'Emergency';

-- 3. List all weeks where more than 100 patients requested admission in any service
SELECT *
FROM services_weekly
WHERE patients_request > 100;

#Challenge:
-- Find all patients admitted to 'Surgery' service with a satisfaction score below 70, showing their patient_id, name, age, and satisfaction score
SELECT
	patient_id,
    name AS patient_name,
    age AS patient_age,
    satisfaction
FROM patients
WHERE service = 'Surgery' AND satisfaction < 70;

# Day-3:
-- 1. List all patients sorted by age in descending order
SELECT *
FROM patients
ORDER BY age DESC;

-- 2. Show all services_weekly data sorted by week number ascending and patients_request descending
SELECT *
FROM services_weekly
ORDER BY week ASC, patients_request DESC;

-- 3. Display staff members sorted alphabetically by their names
SELECT *
FROM staff
ORDER BY staff_name ASC;

# Challenge
/* Retrieve the top 5 weeks with the highest patient refusals across all services, showing week, service, patients_refused, and patients_request
Sort by patients_refused in descending order */
SELECT
	week,
    service,
    patients_refused,
    patients_request
FROM services_weekly
ORDER BY patients_refused DESC
LIMIT 5;

# Day-4:
-- 1. Display the first 5 patients from the patients table
SELECT *
FROM patients
LIMIT 5;

-- 2. Show patients 11-20 using OFFSET
SELECT *
FROM patients
LIMIT 10
OFFSET 10;

-- 3. Get the 10 most recent patient admissions based on arrival_date
SELECT *
FROM patients
ORDER BY arrival_date DESC
LIMIT 10;

# Challenge:
/* Find the 3rd to 7th highest patient satisfaction scores from the patients table, showing patient_id, name, service, and satisfaction
Display only these 5 records */
SELECT
	patient_id,
    name,
    service,
    satisfaction
FROM patients
ORDER BY satisfaction DESC
LIMIT 5
OFFSET 2;

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

# Day-6:
-- 1. Count the number of patients by each service
SELECT
	service,
	COUNT(*) AS total_patients
FROM patients
GROUP BY service;
    
-- 2. Calculate the average age of patients grouped by service
SELECT
	service,
    ROUND(AVG(age),2) AS average_age
FROM patients
GROUP BY service;

-- 3. Find the total number of staff members per role
SELECT
	role,
    COUNT(staff_id) AS total_staff_members
FROM staff
GROUP BY role;

#Challenge:
/* For each hospital service, calculate the total number of patients admitted, total patients refused, 
and the admission rate (percentage of requests that were admitted) Order by admission rate descending */
SELECT
	service,
    SUM(patients_admitted) AS total_patients_admitted,
    SUM(patients_refused) AS total_patients_refused,
    ROUND((SUM(patients_admitted) / SUM(patients_request)) * 100, 2) AS admission_rate
FROM services_weekly
GROUP BY service
ORDER BY admission_rate DESC;

# Day-7:
-- 1. Find services that have admitted more than 500 patients in total
SELECT
	service,
    SUM(patients_admitted) AS total_patients_admitted
FROM services_weekly
GROUP BY service
HAVING SUM(patients_admitted) > 500;

-- 2. Show services where average patient satisfaction is below 75
SELECT
	service,
    ROUND(AVG(patient_satisfaction),2) AS avg_patient_satisfaction
FROM services_weekly
GROUP BY service
HAVING AVG(patient_satisfaction) < 75;

-- 3. List weeks where total staff presence across all services was less than 50
SELECT
	week,
    SUM(present) AS total_staff
FROM staff_schedule
GROUP BY week
HAVING total_staff < 50;

#Challenge:
/* Identify services that refused more than 100 patients in total and had an average patient satisfaction below 80
Show service name, total refused, and average satisfaction */
SELECT
	service,
    SUM(patients_refused) AS total_patients_refused,
    ROUND(AVG(patient_satisfaction),2) AS avg_patient_satisfaction
FROM services_weekly
GROUP BY service
HAVING (total_patients_refused > 100) AND (avg_patient_satisfaction < 80);

# Day-8:
-- 1. Convert all patient names to uppercase
SELECT
	UPPER(name) AS Name
FROM patients;

-- 2. Find the length of each staff member's name
SELECT
	staff_name,
    LENGTH(staff_name) AS name_length
FROM staff;

-- 3. Concatenate staff_id and staff_name with a hyphen separator
SELECT
	CONCAT(staff_id, ' - ' , staff_name) AS id_name
FROM staff;

#Challenge:
/* Create a patient summary that shows patient_id, full name in uppercase, service in lowercase,
age category (if age >= 65 then 'Senior', if age >= 18 then 'Adult', else 'Minor'), and name length
Only show patients whose name length is greater than 10 characters */
SELECT
	patient_id,
    UPPER(name) AS full_name,
    LOWER(service) AS service,
    CASE
		WHEN age >= 65 THEN 'Senior'
        WHEN age >= 18 THEN 'Adult'
        ELSE 'Minor'
	END AS age_category,
    LENGTH(name) AS name_length
FROM patients
WHERE LENGTH(name) > 10;