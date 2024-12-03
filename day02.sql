SELECT string_agg(letter, '') FROM (
        SELECT * FROM (
                SELECT id, value, CHR(value) as letter, 'a' as tb FROM letters_a
        ) UNION (
                SELECT id, value, CHR(value) as letter, 'b' as tb FROM letters_b
        )
        ORDER BY id, tb
)
WHERE value BETWEEN 97 AND 122
OR value BETWEEN 65 AND 90
OR value BETWEEN 48 AND 57
OR value IN (32, 33, 39, 58, 63, 46, 44)

-- Dear Santa, I hope this letter finds you well in the North Pole! I want a SQL course for Christmas!
