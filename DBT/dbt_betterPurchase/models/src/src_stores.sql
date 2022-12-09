SELECT 
    ROW_NUMBER() OVER (ORDER BY storeid) as internal_id,
    storeid as store_id,
    name as store_name,
    storetype as store_type,
    phone as store_phone,
    address as store_address1,
    address2 as store_address2,
    city as store_city,
    region as store_region,
    full_postal_code as store_zip,
    country as store_country
FROM raw.stores