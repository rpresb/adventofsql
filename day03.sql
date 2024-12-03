SELECT food_item_id, COUNT(1) as frequency
FROM (
        SELECT (unnest(xpath('.//food_item_id/text()', menu_data::xml)))::text::int as food_item_id
        FROM (
                SELECT 
                        CASE (xpath('.//@version', menu_data::xml))[1]::text 
                                WHEN '1.0' THEN (xpath('.//total_count/text()', menu_data::xml))[1]::text::int
                                WHEN '2.0' THEN (xpath('.//total_guests/text()', menu_data::xml))[1]::text::int
                                WHEN 'beta' THEN (xpath('.//guestCount/text()', menu_data::xml))[1]::text::int
                        END as guest_count, *
                FROM christmas_menus
        ) WHERE guest_count >= 78
)
GROUP BY food_item_id
ORDER BY frequency DESC
LIMIT 1

-- 493