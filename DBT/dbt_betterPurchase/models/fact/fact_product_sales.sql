WITH src_product_sales AS (
    SELECT * FROM {{ref('src_product_sales')}}
)

SELECT 
    TRANS_ID, 
    SKU, 
    SALEPRICE as SALE_PRICE, 
    TAX,
    GETDATE() as create_date,
    GETDATE() as modified_date
FROM src_product_sales