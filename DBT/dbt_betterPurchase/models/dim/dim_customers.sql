WITH src_customers AS (
    SELECT * FROM {{ref('src_customers')}}
)


SELECT 
    CUST_ID, 
    CUST_NAME, 
    CUST_ADDRESS, 
    CUST_COUNTRY_CODE, 
    CUST_PHONE_NUMBER, 
    CUST_PHONE_EXTENSION, 
    CUST_EMAIL, 
    BIRTHDAY,
    GETDATE() as create_date,
    GETDATE() as modified_date
FROM src_customers