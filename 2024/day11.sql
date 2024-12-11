SELECT * FROM (
SELECT
        field_name,
        harvest_year,
        season,
        trees_harvested,
        AVG(trees_harvested) OVER (
                ORDER BY field_name,
                CASE season WHEN 'Winter' THEN 1 WHEN 'Fall' THEN 2 WHEN 'Summer' THEN 3 ELSE 4 END
                ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING
        ) AS avg_trees
FROM TreeHarvests
ORDER BY 
field_name,
CASE season WHEN 'Winter' THEN 1 WHEN 'Fall' THEN 2 WHEN 'Summer' THEN 3 ELSE 4 END
) T
WHERE season = 'Winter'
ORDER BY avg_trees DESC

-- 327.6666666666666667
-- 327.67
