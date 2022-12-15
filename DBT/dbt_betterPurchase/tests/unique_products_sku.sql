select sku, count(*) from {{ref('src_products')}} group by sku having COUNT(*) > 1
