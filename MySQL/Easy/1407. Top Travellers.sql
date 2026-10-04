# Write your MySQL query statement below
SELECT U.name, CASE
    WHEN R.distance IS NOT NULL THEN  SUM(R.distance) 
    WHEN R.distance IS NULL THEN 0
    END AS travelled_distance 
FROM Users U LEFT JOIN Rides R ON U.id=R.user_id
GROUP BY U.id
ORDER BY travelled_distance DESC, name ASC;