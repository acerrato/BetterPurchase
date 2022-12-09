WITH prep AS (
    SELECT 
        id as cust_id,
        cust_name,
        ADDRESS as cust_address, -- TODO: Parse Address
        TRIM(split(phone_number,'x')[0],'"+ ') as phone,
        try_to_decimal(LEFT(regexp_replace(phone,'[^0-9]',''),LENGTH(regexp_replace(phone,'[^0-9]','')) - 10)) AS cust_country_code,
        LEFT(RIGHT(regexp_replace(phone,'[^0-9]',''),10),3) || '-' || LEFT(RIGHT(regexp_replace(phone,'[^0-9]',''),7),3) || '-' ||  RIGHT(regexp_replace(phone,'[^0-9]',''),4) AS cust_phone_number_clean,
        TRIM(split(phone_number,'x')[1] ,'"') as cust_phone_extension,
        email as cust_email,
        birthday
    FROM raw.customers

    )
    
SELECT 
    cust_id,
    cust_name,
    cust_address,
    cust_country_code,
    cust_phone_number_clean AS cust_phone_number,
    cust_phone_extension,
    cust_email,
    birthday
FROM prep