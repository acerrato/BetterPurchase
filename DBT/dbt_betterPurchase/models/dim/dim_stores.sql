

WITH src_stores AS (
    SELECT *  
    FROM {{ref('src_stores')}} 
)

SELECT 
    * exclude internal_id
FROM src_stores