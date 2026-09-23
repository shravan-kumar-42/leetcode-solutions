# Write your MySQL query statement below
SELECT MAX(num) AS num
FROM mynumbers n
WHERE num IN (SELECT num FROM mynumbers GROUP BY num HAVING COUNT(*) = 1);