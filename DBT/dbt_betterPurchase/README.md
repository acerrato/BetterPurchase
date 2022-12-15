# DBT BetterPurchase

For this project I'm using DBT to take my source data on Snowflake and bring it into a simplified warehouse to support reporting.

## Models

### [Sources](./models/sources.yaml)
- raw.customers
- raw.stores
- raw.cell_phones
- raw.laptops
- raw.health_fitness
- raw.home_automation
- raw.transactions


### Views
- [src_customers](./models/src/src_customers.sql)
    - Customer records with cleansed phone data
- [src_stores](./models/src/src_stores.sql)
    - Store records trimmed to only the relevant fields
- [src_products](./models/src/src_products.sql)
    - Product records combined into one view trimmed to only the relevant fields
- [src_features](./models/src/src_features.sql)
    - Feature data extracted from product source tables and stored in a seperate view to support a 1:M relationship
- [src_product_sales](./models/src/src_product_sales.sql)
    - Derived from transaction data.  Since transaction data was "generated" we have no historical price information.  To bridge that gap for this exercise I used current product sales prices and a fixed placeholder of 7% sales tax.
- [src_transactions](./models/src/src_transactions.sql)
    - Summary transaction data

### Tables

- [dim_Customers](./models/dim/dim_customers.sql)
    - Customer dimension table
- [dim_Products](./models/dim/dim_products.sql)
    - Product dimension table
- [dim_Product_Features](./models/dim/dim_product_features.sql)
    - Product features dimension table, a 1:M relationship with dim_Products
- [dim_Stores](./models/dim/dim_stores.sql)
    - Store dimension table
- [fact_Product_Sales](./models/fact/fact_product_sales.sql)
    - Transaction detail records containing product-level sales
- [fact_Transactions](./models/fact/fact_transactions.sql)
    - Summary transaction data

## Tests
For this project I am only including a handful of tests.  A production environment would of course include a far more exhaustive list. 

- [customer_age](./tests/customer_age.sql)
    - Check to make sure customers are between 10 and 99 years old
- [store_ids](./tests/store_ids.sql)
    - Check to ensure store_id is populated on every record
- [transaction_validStore_validCust](./tests/transaction_validStore_validCust.sql)
    - Check to ensure transaction records are referencing valid customer and store records
- [unique_products_sku](./tests/unique_products_sku.sql)
    - Check to ensure product SKUs are unique

## Seeds
This project does not currently leverage any seed data

## Analyses
This project does not currently leverage any scripts for analysis

## Generated Documentation
Execute the command below to bring up the DBT generated documenation
```
dbt docs serve
```

Helpful DBT Commands
```
dbt run
```
```
dbt test
```
```
dbt compile
```

[Official DBT Documentaion](https://docs.getdbt.com/docs/introduction)

### TODO:
- Convert dim tables to SCDs
- Setup fact tables as incremental updates
- Create an analyses script
- Make use of a local seed file
