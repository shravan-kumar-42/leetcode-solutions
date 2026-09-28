# Write your MySQL query statement below
WITH top_3 AS (
    SELECT 
    d.name AS Department,
    e.name AS Employee,
    e.salary AS Salary,
    DENSE_RANK() OVER(
        PARTITION BY d.name ORDER BY e.salary DESC
    ) AS Ranking
    FROM Employee e
    JOIN Department d ON e.departmentId = d.id
)
SELECT Department,Employee,Salary FROM top_3
WHERE Ranking <= 3;