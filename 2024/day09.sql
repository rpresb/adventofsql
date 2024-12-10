SELECT T1.reindeer_name, MAX(avg_speed) top_speed
FROM (
        SELECT R.reindeer_name, AVG(speed_record) avg_speed, exercise_name
        FROM Training_Sessions T
        INNER JOIN Reindeers R ON R.reindeer_id = T.reindeer_id
        GROUP BY R.reindeer_name, exercise_name
) T1
WHERE reindeer_name <> 'Rudolph'
GROUP BY T1.reindeer_name
ORDER BY top_speed DESC

--Cupid,88.64
--Blitzen,88.38
--Vixen,88.01
