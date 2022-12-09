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
FROM raw.laptops

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
FROM raw.cell_phones

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
FROM raw.home_automation

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
FROM raw.health_fitness