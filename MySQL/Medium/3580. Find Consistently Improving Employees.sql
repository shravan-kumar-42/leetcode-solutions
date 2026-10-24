# Write your MySQL query statement below
WITH recent_reviews AS (
    SELECT employee_id,review_date,rating,
        ROW_NUMBER() OVER (PARTITION BY employee_id ORDER BY review_date DESC) AS rn
    FROM performance_reviews
),
last_three AS (
    SELECT employee_id, review_date, rating
    FROM recent_reviews
    WHERE rn <= 3
),
rating_check AS (
    SELECT employee_id,rating,
        LEAD(rating) OVER (PARTITION BY employee_id ORDER BY review_date DESC) AS older_rating
    FROM last_three
)
SELECT e.employee_id,e.name,MAX(r.rating) - MIN(r.rating) AS improvement_score
FROM rating_check r
JOIN employees e ON r.employee_id = e.employee_id
GROUP BY e.employee_id, e.name
HAVING COUNT(*) = 3
   AND SUM(
       CASE
           WHEN older_rating IS NOT NULL AND rating <= older_rating
           THEN 1
           ELSE 0
       END
   ) = 0
ORDER BY improvement_score DESC, e.name ASC;

