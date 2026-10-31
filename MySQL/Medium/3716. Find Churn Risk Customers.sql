# Write your MySQL query statement below
WITH subscriptions AS (
    SELECT
        *,
        DATEDIFF(
            MAX(event_date) OVER (PARTITION BY user_id),
            MIN(event_date) OVER (PARTITION BY user_id)
        ) AS days_as_subscriber,
        ROW_NUMBER() OVER (
            PARTITION BY user_id
            ORDER BY event_date DESC
        ) AS rnk
    FROM subscription_events
),

current_plan AS (
    SELECT
        user_id,
        plan_name,
        monthly_amount
    FROM subscriptions
    WHERE rnk = 1
      AND event_type != 'cancel'
),

historical_stats AS (
    SELECT DISTINCT
        user_id,
        MAX(monthly_amount) OVER (
            PARTITION BY user_id
        ) AS max_historical_amount
    FROM subscriptions
    WHERE rnk != 1
)

SELECT DISTINCT
    C.user_id,
    C.plan_name AS current_plan,
    C.monthly_amount AS current_monthly_amount,
    H.max_historical_amount,
    S.days_as_subscriber
FROM current_plan C
JOIN historical_stats H
    ON C.user_id = H.user_id
    AND C.monthly_amount < 0.5 * H.max_historical_amount
JOIN subscriptions S
    ON C.user_id = S.user_id
    AND S.days_as_subscriber >= 60
WHERE C.user_id IN (
    SELECT user_id
    FROM subscription_events
    WHERE event_type = 'downgrade'
)
ORDER BY
    S.days_as_subscriber DESC,
    C.user_id ASC;