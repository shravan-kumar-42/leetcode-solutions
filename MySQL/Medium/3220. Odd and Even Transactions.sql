# Write your MySQL query statement below
SELECT
    transaction_date,
    IFNULL(SUM(CASE WHEN amount % 2 != 0 THEN amount ELSE 0 END), 0) AS odd_sum,
    IFNULL(SUM(CASE WHEN amount % 2 = 0 THEN amount ELSE 0 END), 0) AS even_sum
FROM transactions
GROUP BY transaction_date
ORDER BY transaction_date ASC;
