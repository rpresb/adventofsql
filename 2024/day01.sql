SELECT A.*,
CASE T1.difficulty_to_make 
        WHEN 1 THEN 'Simple Gift' 
        WHEN 2 THEN 'Moderate Gift'
        ELSE 'Complex Gift'
END as gift_complexity,
CASE T1.category
        WHEN 'outdoor' THEN 'Outside Workshop'
        WHEN 'educational' THEN 'Learning Workshop'
        ELSE 'General Workshop'
END as workshop_assignment
FROM (
        SELECT C.child_id, W.list_id, C.name, trim('"' FROM (W.wishes::json->'first_choice')::text) as primary_wish, trim('"' FROM (W.wishes::json->'second_choice')::text) as backup_wish,
                trim('"' FROM (((W.wishes::json->'colors')::jsonb)[0])::text) as favorite_color,
                jsonb_array_length((W.wishes::json->'colors')::jsonb) as color_count
        FROM wish_lists W
        INNER JOIN children C ON C.child_id = W.child_id
) A
INNER JOIN toy_catalogue T1 ON T1.toy_name = A.primary_wish
INNER JOIN toy_catalogue T2 ON T2.toy_name = A.backup_wish
ORDER BY A.name, A.child_id, A.list_id;

/*
Abagail,Building sets,LEGO blocks,Blue,1,Complex Gift,Learning Workshop
Abbey,Toy trains,Toy trains,Pink,2,Complex Gift,General Workshop
Abbey,Yo-yos,Building blocks,Blue,5,Simple Gift,General Workshop
Abbey,Barbie dolls,Play-Doh,Purple,1,Moderate Gift,General Workshop
Abbey,Stuffed animals,Teddy bears,White,4,Complex Gift,General Workshop
*/