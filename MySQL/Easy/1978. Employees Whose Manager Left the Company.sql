# Write your MySQL query statement below
SElECT employee_id
FROM Employees
WHERE salary < 30000 and manager_id NOT IN(
    SELECT employee_id
    FROM Employees
)
ORDER BY employee_id;