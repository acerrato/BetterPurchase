SELECT 
    'Laptops' AS product_category,
    sku,
    upc,
    type,
    name,
    modelnumber,
    manufacturer,
    longdescription,
    color,
    regularprice,
    saleprice
FROM  {{source('aws','laptops')}} 

UNION ALL

SELECT 
    'Cell Phones' AS product_category,
    sku,
    upc,
    type,
    name,
    modelnumber,
    manufacturer,
    longdescription,
    color,
    regularprice,
    saleprice
FROM  {{source('aws','cell_phones')}} 

UNION ALL

SELECT 
    'Home Automation' AS product_category,
    sku,
    upc,
    type,
    name,
    modelnumber,
    manufacturer,
    longdescription,
    color,
    regularprice,
    saleprice
FROM  {{source('aws','home_automation')}} 

UNION ALL

SELECT 
    'Health & Fitness' AS product_category,
    sku,
    upc,
    type,
    name,
    modelnumber,
    manufacturer,
    longdescription,
    color,
    regularprice,
    saleprice
FROM  {{source('aws','health_fitness')}} 