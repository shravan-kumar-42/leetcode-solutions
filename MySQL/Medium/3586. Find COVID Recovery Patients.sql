# Write your MySQL query statement below
SELECT
    p.patient_id,
    p.patient_name,
    p.age,
    DATEDIFF(
        MIN(CASE WHEN t.result = 'Negative'
                 AND t.test_date > fp.first_positive_date
                 THEN t.test_date END),
        fp.first_positive_date
    ) AS recovery_time
FROM patients p
JOIN (
    SELECT patient_id, MIN(test_date) AS first_positive_date
    FROM covid_tests
    WHERE result = 'Positive'
    GROUP BY patient_id
) fp ON p.patient_id = fp.patient_id
JOIN covid_tests t ON t.patient_id = p.patient_id
GROUP BY p.patient_id, p.patient_name, p.age, fp.first_positive_date
HAVING recovery_time IS NOT NULL
ORDER BY recovery_time ASC, p.patient_name ASC;