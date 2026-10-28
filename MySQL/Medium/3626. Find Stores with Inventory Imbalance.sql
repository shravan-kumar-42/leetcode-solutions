# Write your MySQL query statement below
WITH max_prices AS(
    SELECT store_id,MAX(price) AS max_price,MIN(price) AS min_price 
    FROM inventory
    GROUP BY store_id
    HAVING COUNT(DISTINCT product_name) >= 3
), maxmin_prod AS(
    SELECT i.store_id,i.product_name,i.quantity,i.price
    FROM inventory i
    JOIN max_prices mp 
        ON i.store_id = mp.store_id AND (i.price = mp.max_price OR i.price = mp.min_price)
)
SELECT s.store_id,s.store_name,s.location,map.product_name AS most_exp_product, 
       mip.product_name AS cheapest_product,ROUND(mip.quantity / map.quantity, 2) AS imbalance_ratio
FROM maxmin_prod map
JOIN maxmin_prod mip
    ON map.store_id = mip.store_id AND map.price > mip.price AND map.quantity < mip.quantity
JOIN stores s   
    ON s.store_id = map.store_id
ORDER  BY imbalance_ratio DESC,s.store_name ASC;