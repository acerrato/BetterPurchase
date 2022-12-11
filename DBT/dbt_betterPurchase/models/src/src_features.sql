WITH features as (
SELECT
    sku,
    trim(value:feature,'"') as feature
FROM {{source('aws','laptops')}},
    table(flatten(parse_json(features),''))

UNION ALL

SELECT
    sku,
    trim(value:feature,'"') as feature
FROM {{source('aws','cell_phones')}},
    table(flatten(parse_json(features),''))
    
UNION ALL

SELECT
    sku,
    trim(value:feature,'"') as feature
FROM {{source('aws','health_fitness')}},
    table(flatten(parse_json(features),''))
    
UNION ALL

SELECT
    sku,
    trim(value:feature,'"') as feature
FROM {{source('aws','home_automation')}},
    table(flatten(parse_json(features),''))
)

SELECT *
FROM features
WHERE ifNull(feature,'') <>''