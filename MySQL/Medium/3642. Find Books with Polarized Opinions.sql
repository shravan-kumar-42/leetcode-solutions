# Write your MySQL query statement below
WITH prerequisites AS (
    SELECT book_id,MAX(session_rating) AS max_rating,MIN(session_rating) AS min_rating,COUNT(*) AS total_sessions,SUM(session_rating >= 4) AS max_extreme_rating,SUM(session_rating <= 2) AS min_extreme_rating
    FROM reading_sessions
    GROUP BY book_id
),
polarized_opinions AS (
    SELECT book_id,max_rating - min_rating AS rating_spread,(max_extreme_rating + min_extreme_rating) / total_sessions AS polarization_score
    FROM prerequisites
    WHERE max_extreme_rating >= 1 AND min_extreme_rating >= 1 AND total_sessions >= 5 AND (max_extreme_rating + min_extreme_rating) / total_sessions >= 0.6
)
SELECT b.*,p.rating_spread,ROUND(p.polarization_score, 2) AS polarization_score
FROM polarized_opinions AS p
JOIN books AS b ON p.book_id = b.book_id
ORDER BY p.polarization_score DESC,b.title DESC;