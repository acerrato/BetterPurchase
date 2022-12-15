SELECT *
FROM {{ref('src_transactions')}} t
    LEFT JOIN {{ref('src_stores')}} st ON st.store_id =t.store_id
    LEFT JOIN {{ref('src_customers')}} cust ON cust.cust_id = t.cust_id
WHERE st.store_id IS NULL OR
    cust.cust_id IS NULL