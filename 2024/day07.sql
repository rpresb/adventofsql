WITH skill_experience_ranked AS (
    SELECT 
        primary_skill,
        elf_id,
        years_experience,
        RANK() OVER (PARTITION BY primary_skill ORDER BY years_experience DESC) AS rank_desc,
        RANK() OVER (PARTITION BY primary_skill ORDER BY years_experience ASC) AS rank_asc
    FROM workshop_elves
)
SELECT 
    MIN(max_experience.elf_id) AS elf_1_id,
    MIN(min_experience.elf_id) AS elf_2_id,
    max_experience.primary_skill
FROM skill_experience_ranked max_experience
JOIN skill_experience_ranked min_experience
    ON max_experience.primary_skill = min_experience.primary_skill
WHERE max_experience.rank_desc = 1 AND min_experience.rank_asc = 1
GROUP BY max_experience.primary_skill

/*
4153,3611,Gift sorting
10497,1016,Gift wrapping
50,13551,Toy making
*/