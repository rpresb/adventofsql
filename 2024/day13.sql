SELECT COUNT(1), split_part(unnest(email_addresses), '@', 2)
FROM contact_list
GROUP BY split_part(unnest(email_addresses), '@', 2)
ORDER BY 1 DESC

-- bells.org
