WITH features as (
SELECT
    sku,
    trim(value:feature,'"') as feature
FROM raw.laptops,
    table(flatten(parse_json(features),''))

UNION ALL

SELECT
    sku,
    trim(value:feature,'"') as feature
FROM raw.cell_phones,
    table(flatten(parse_json(features),''))
    
UNION ALL

SELECT
    sku,
    trim(value:feature,'"') as feature
FROM raw.health_fitness,
    table(flatten(parse_json(features),''))
    
UNION ALL

SELECT
    sku,
    trim(value:feature,'"') as feature
FROM raw.home_automation,
    table(flatten(parse_json(features),''))
)

SELECT *
FROM features
WHERE ifNull(feature,'') <>''