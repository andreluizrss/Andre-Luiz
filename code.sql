1. GETTING FAMILIAR WITH COOLTSHIRTS



WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT ft.user_id,
    ft.first_touch_at,
    pv.utm_source,
		pv.utm_campaign
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp;

select utm_source, utm_campaign from page_visits group by 2;

select * from page_visits group by utm_campaign;

select distinct(page_name) from page_visits;




2. WHAT IS THE USER JOURNEY?



WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id),
ft_attr AS (
SELECT ft.user_id,
    ft.first_touch_at,
    pv.utm_source,
        pv.utm_campaign
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp)
    select ft_attr.utm_campaign, count(*) from ft_attr group by 1 order by 2 desc;

WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id),
  lt_attr AS (
  SELECT last_touch.user_id,
         last_touch.last_touch_at,
         page_visits.utm_source,
         page_visits.utm_campaign,
         page_visits.page_name
  FROM last_touch
  JOIN page_visits
    ON last_touch.user_id = page_visits.user_id
    AND last_touch.last_touch_at = page_visits.timestamp
)
SELECT utm_campaign,
       COUNT(*)
FROM lt_attr
GROUP BY 1 ORDER BY 2 DESC;

select count(distinct(user_id)) from page_visits where page_name = '4 - purchase';

WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id),
  lt_attr AS (
  SELECT last_touch.user_id,
         last_touch.last_touch_at,
         page_visits.utm_source,
         page_visits.utm_campaign,
         page_visits.page_name
  FROM last_touch
  JOIN page_visits
    ON last_touch.user_id = page_visits.user_id
    AND last_touch.last_touch_at = page_visits.timestamp
)
SELECT utm_campaign, count(last_touch_at) from lt_attr where page_name = '4 - purchase' group by 1 order by 2 desc;