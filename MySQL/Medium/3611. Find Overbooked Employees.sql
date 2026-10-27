# Write your MySQL query statement below
WITH process1 AS (
    SELECT employee_id, YEAR(meeting_date) AS meeting_year, WEEKOFYEAR(meeting_date) AS meeting_week, SUM(duration_hours) AS duration_total
    FROM meetings
    GROUP BY employee_id, YEAR(meeting_date), WEEKOFYEAR(meeting_date)
)
SELECT p.employee_id, e.employee_name, e.department, COUNT(*) AS meeting_heavy_weeks
FROM process1 p
INNER JOIN employees e
    ON p.employee_id = e.employee_id
WHERE p.duration_total > 20
GROUP BY p.employee_id, e.employee_name, e.department
HAVING COUNT(*) > 1
ORDER BY meeting_heavy_weeks DESC, employee_name ASC;