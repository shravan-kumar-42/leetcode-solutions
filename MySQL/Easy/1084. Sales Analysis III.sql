# Write your MySQL query statement below
SELECT P.product_id,P.product_name FROM Sales S 
JOIN Product P ON P.product_id=S.product_id
GROUP BY p.product_id,P.product_name
HAVING MIN(sale_date) >= '2019-01-01' AND
       MAX(sale_date) <= '2019-03-31'; 
