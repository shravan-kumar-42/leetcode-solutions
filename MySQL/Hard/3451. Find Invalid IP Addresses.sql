# Write your MySQL query statement below
SELECT ip,COUNT(*) AS invalid_count
FROM logs
WHERE
    ip NOT REGEXP '^([0-9]{1,3}\\.){3}[0-9]{1,3}$' 
    OR ip REGEXP '(^|\\.)0[0-9]' 
    OR ip REGEXP '(^|\\.)(25[6-9]|2[6-9][0-9]|[3-9][0-9][0-9])(\\.|$)'
GROUP BY ip
ORDER BY invalid_count DESC, ip DESC;