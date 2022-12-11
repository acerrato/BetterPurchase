WITH src_transactions AS (
    SELECT * FROM {{ref('src_transactions')}}

)

SELECT 
    TRANS_ID, 
    CUST_ID, 
    STORE_ID, 
    TRANSACTION_DATE, 
    SALE_TOTAL, 
    TAX_TOTAL,
    GETDATE() as create_date,
    GETDATE() as modified_date
FROM src_transactions