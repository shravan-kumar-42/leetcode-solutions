# Write your MySQL query statement below
SELECT
    customer_id,
    COUNT(*) AS total_orders,
    ROUND(100 * AVG(TIME(order_timestamp) BETWEEN '11:00:00' AND '14:00:00'
        OR TIME(order_timestamp) BETWEEN '18:00:00' AND '21:00:00'), 0) AS peak_hour_percentage,
    ROUND(AVG(order_rating), 2) AS average_rating
FROM restaurant_orders
GROUP BY customer_id
HAVING
    COUNT(*) > 2
    AND AVG(order_rating) >= 4.0
    AND AVG(
        TIME(order_timestamp) BETWEEN '11:00:00' AND '14:00:00'
        OR TIME(order_timestamp) BETWEEN '18:00:00' AND '21:00:00') >= 0.60
    AND COUNT(order_rating) * 100 / COUNT(*) >= 50
ORDER BY average_rating DESC, customer_id DESC;