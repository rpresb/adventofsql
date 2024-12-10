SELECT *
FROM crosstab(
    $$
    SELECT 
        date,
        REPLACE(drink_name, ' ', '') as drink_name,
        SUM(quantity) AS total_quantity
    FROM Drinks
    WHERE drink_name IN ('Hot Cocoa', 'Eggnog', 'Peppermint Schnapps')
    GROUP BY date, REPLACE(drink_name, ' ', '')
    ORDER BY date, REPLACE(drink_name, ' ', '')
    $$
) AS pivot_table(
    date DATE,
    Eggnog BIGINT,
    HotCocoa BIGINT,
    PeppermintSchnapps BIGINT
)
WHERE HotCocoa = 38
;

-- 2024-03-14
