# Write your MySQL query statement below
SELECT stock_name,
       SUM(IF(operation = 'Buy', -price, price)) AS capital_gain_loss
FROM Stocks
GROUP BY stock_name;


--or--

SELECT
    stock_name,
    SUM(
        CASE
            WHEN operation = 'Buy' THEN -price
            ELSE price
        END
    ) AS capital_gain_loss
FROM Stocks
GROUP BY stock_name;