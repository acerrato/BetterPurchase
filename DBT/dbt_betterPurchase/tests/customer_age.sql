SELECT * FROM {{ref('src_customers')}} WHERE birthday <= DATEADD(year,-100,GETDATE())