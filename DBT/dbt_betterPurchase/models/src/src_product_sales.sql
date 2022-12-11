with products_sold AS (
SELECT 
    id as trans_id,
    trim("VALUE",'"[]') AS sku,
    transaction_date
FROM {{source('aws','transactions')}},
    table(flatten(split(products,','))) a
)
--Not realistic, but since transaction history is fake we need to generate sales numbers.  
--For the sake of this exercise I'm just using the current sale price, but in reality this would be historical data on the transaction
SELECT 
    ps.trans_id,
    ps.sku,
    p.saleprice,
    ROUND(p.saleprice *.07,2) AS tax
FROM products_sold ps
    LEFT JOIN {{ref('src_products')}} p on p.sku = ps.sku