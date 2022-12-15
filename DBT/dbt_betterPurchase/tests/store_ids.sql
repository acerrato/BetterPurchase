SELECT *
FROM {{ref('src_stores')}} 
WHERE store_id IS NULL