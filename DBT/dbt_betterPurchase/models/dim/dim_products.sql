WITH src_products AS (

    SELECT * FROM {{ref('src_products')}}

)



SELECT 
    product_category,
    type,
    sku,
    upc,
    name as product_name,
    modelnumber as model_number,
    manufacturer,
    longdescription as product_description,
    color as product_color,
    regularprice as regular_price,
    saleprice as sale_price,
    GETDATE() as create_date,
    GETDATE() as modified_date
FROM src_products