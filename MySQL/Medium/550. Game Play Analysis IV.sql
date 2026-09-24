# Write your MySQL query statement below
WITH FirstLogin AS(select player_id,MIN(event_date) AS first_login FROM Activity GROUP BY player_id)
SELECT ROUND(AVG(EXISTS(SELECT 1 FROM Activity a WHERE a.player_id = f.player_id AND a.event_date = DATE_ADD(f.first_login, INTERVAL 1 DAY))), 2) AS fraction FROM FirstLogin f;