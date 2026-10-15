# Write your MySQL query statement below

-- WITH product_format  AS(
--     SELECT pp.user_id,p1.category FROM ProductPurchases pp
--     INNER JOIN ProductInfo P1  ON pp.product_id = p1.product_id
-- ), main_Process AS(
--     SELECT fp.category AS category1, fp1.category AS category2, COUNT(DISTINCT fp.user_id) customer_count
--     FROM product_format fp INNER JOIN product_format fp1  ON fp.category < fp1.category AND fp.user_id = fp1.user_id
--     GROUP BY fp.category,fp1.category
--     HAVING(COUNT(DISTINCT fp.user_id)) > 2
-- )
-- SELECT category1,category2,customer_count
-- FROM main_process mp
-- ORDER BY customer_count DESC,category1,category2;

WITH UserCategories AS (
    SELECT DISTINCT 
        p.user_id, 
        i.category
    FROM ProductPurchases p
    JOIN ProductInfo i 
      ON p.product_id = i.product_id
)
SELECT 
    uc1.category AS category1,
    uc2.category AS category2,
    COUNT(DISTINCT uc1.user_id) AS customer_count
FROM UserCategories uc1
JOIN UserCategories uc2 
  ON uc1.user_id = uc2.user_id 
 AND uc1.category < uc2.category
GROUP BY 
    uc1.category, 
    uc2.category
HAVING 
    COUNT(DISTINCT uc1.user_id) >= 3
ORDER BY 
    customer_count DESC,
    category1 ASC,
    category2 ASC;