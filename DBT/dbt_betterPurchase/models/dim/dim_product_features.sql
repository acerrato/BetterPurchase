WITH src_features AS (
    SELECT * FROM {{ref('src_features')}}
)

SELECT 
    SKU, 
    FEATURE,
    GETDATE() as create_date,
    GETDATE() as modified_date
FROM src_features