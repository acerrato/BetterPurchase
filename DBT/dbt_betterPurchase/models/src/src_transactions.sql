SELECT 
    id as trans_id,
    cust_id,
    store_id,
    transaction_date,
    SUM(saleprice) AS sale_total,
    SUM(tax) AS tax_total
FROM {{source('aws','transactions')}} t
    LEFT JOIN {{ref('src_product_sales')}} ps ON ps.trans_id = t.id
GROUP BY id,
    cust_id,
    store_id,
    transaction_date