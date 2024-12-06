SELECT *
FROM children C
INNER JOIN gifts G ON G.child_id = C.child_id
WHERE G.price > (SELECT AVG(price) FROM gifts)
ORDER BY G.price

-- Hobart
