SELECT toy_id, cardinality(added_tags), cardinality(unchanged_tags), cardinality(removed_tags) FROM (
        SELECT (SELECT ARRAY(
                        SELECT unnest(previous_tags)
                        INTERSECT
                        SELECT unnest(new_tags)
                )) as unchanged_tags,
                ARRAY(
                        SELECT tag FROM (SELECT unnest(new_tags) as tag) WHERE NOT (tag = ANY(previous_tags))
                ) as added_tags,
                ARRAY(
                        SELECT tag FROM (SELECT unnest(previous_tags) as tag) WHERE NOT (tag = ANY(new_tags))
                ) as removed_tags,
                *
        FROM toy_production
) T
ORDER BY 2 DESC

-- 2726
-- 98
-- 2
-- 0
