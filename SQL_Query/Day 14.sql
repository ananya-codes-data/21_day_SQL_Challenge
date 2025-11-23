# Day-14:
-- 1. Show all staff members and their schedule information (including those with no schedule entries)
SELECT
	s.staff_id,
    s.staff_name,
    s.role,
    s.service,
    ss.present,
    ss.week
FROM staff AS s
LEFT JOIN staff_schedule AS ss
	ON s.staff_id = ss.staff_id;

-- 2. List all services from services_weekly and their corresponding staff (show services even if no staff assigned)
SELECT
	sw.month,
    sw.week,
	sw.service,
    s.staff_name,
    s.role,
    sw.event
FROM services_weekly AS sw
LEFT JOIN staff AS s
	ON sw.service = s.service;

-- 3. Display all patients and their service's weekly statistics (if available)
SELECT
	sw.week,
    sw.month,
	p.patient_id,
    p.name,
    p.age,
    p.arrival_date,
    p.departure_date,
    sw.event,
    sw.service,
    p.satisfaction
FROM patients AS p
LEFT JOIN services_weekly AS sw
	ON p.service = sw.service;
    
#Challenge:
/* Create a staff utilisation report showing all staff members (staff_id, staff_name, role, service) and
the count of weeks they were present (from staff_schedule)
Include staff members even if they have no schedule records
Order by weeks present descending */
SELECT
	s.staff_id,
    s.staff_name, 
    s.role, 
    s.service,
    COUNT(ss.present) AS weeks_present
FROM staff AS s
LEFT JOIN staff_schedule AS ss
	ON s.staff_id = ss.staff_id
GROUP BY
	s.staff_id,
    s.staff_name, 
    s.role, 
    s.service
ORDER BY 
	staff_present DESC;