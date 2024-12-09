WITH RECURSIVE staff_hierarchy AS (
    SELECT 
        staff_id,
        staff_name,
        manager_id,
        ARRAY[]::INT[] || staff_id AS path
    FROM staff
    WHERE manager_id IS NULL

    UNION ALL

    SELECT 
        s.staff_id,
        s.staff_name,
        s.manager_id,
        sh.path || s.staff_id
    FROM staff s
    INNER JOIN staff_hierarchy sh
        ON s.manager_id = sh.staff_id
)
SELECT 
    staff_id,
    staff_name,
    manager_id,
    path,
    cardinality(path)
FROM staff_hierarchy
ORDER BY cardinality(path) DESC

-- 24