# Day-15:
-- 1. Join patients, staff, and staff_schedule to show patient service and staff availability
SELECT
	p.patient_id,
    p.name,
    p.arrival_date,
    p.departure_date,
    p.satisfaction,
    s.*,
    ss.week,
    ss.present
FROM patients AS p
LEFT JOIN staff AS s
	ON p.service = s.service
LEFT JOIN staff_schedule AS ss
	ON p.service = ss.service;

-- 2. Combine services_weekly with staff and staff_schedule for comprehensive service analysis
SELECT
	sw.week,
	sw.month,
	sw.available_beds, 
	sw.patients_request,
	sw.patients_admitted,
	sw.patients_refused,
	sw.patient_satisfaction,
	sw.staff_morale,
	sw.event,
    s.staff_id,
    s.staff_name,
    ss.role,
    ss.service,
    ss.present
FROM services_weekly AS sw
LEFT JOIN staff AS s
	ON sw.service = s.service
LEFT JOIN staff_schedule AS ss
	ON sw.service = ss.service;

-- 3. Create a multi-table report showing patient admissions with staff information
SELECT
	sw.week,
    sw.month,
    p.patient_id,
    p.name,
    p.arrival_date,
    p.departure_date,
    p.satisfaction,
    sw.available_beds,
    sw.patients_admitted,
    ss.staff_name,
    ss.role,
    ss.service
FROM patients AS p
LEFT JOIN services_weekly AS sw
	ON p.service = sw.service
LEFT JOIN staff_schedule AS ss
	ON p.service = ss.service;

#Challenge:
/* Create a comprehensive service analysis report for week 20 showing:
service name, total patients admitted that week, total patients refused, average patient satisfaction,
count of staff assigned to service, and count of staff present that week
Order by patients admitted descending */
SELECT
	sw.service,
    sw.patients_admitted AS total_patient_admitted,
    sw.patients_refused AS total_patient_refused,
    ROUND(AVG(sw.patient_satisfaction),2) AS avg_patient_satisfaction,
    COUNT(s.staff_id) AS staff_assigned,
    COUNT(
		CASE
			WHEN ss.present = 1 THEN 1
		END
	) AS week_present
FROM services_weekly AS sw
LEFT JOIN staff AS s
	ON sw.service = s.service
LEFT JOIN staff_schedule AS ss
	ON sw.week = ss.week
    AND 
    ss.staff_id = s.staff_id
WHERE
	sw.week = 20
GROUP BY
	sw.service,
    sw.patients_admitted,
    sw.patients_refused
ORDER BY
	total_patient_admitted DESC;