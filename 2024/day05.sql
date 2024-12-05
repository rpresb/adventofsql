SELECT *,
        toys_produced - previous_day_production as production_change, 
        ROUND(CAST(FLOAT8 ((toys_produced - previous_day_production) * 100 / previous_day_production::float)::text AS NUMERIC),2) as production_change_percentage
FROM (
        SELECT *, LAG(toys_produced) OVER(ORDER BY production_date) as previous_day_production
        FROM toy_production T
) T1
ORDER BY production_change_percentage DESC NULLS LAST
LIMIT 1

-- 2017-03-20
