# BetterPurchase - Personal data project

This repository exists as a self-driven training project.  My objective is to get better aquainted with DBT, how it interfaces with Snowflake, and it's benefits around version control & documentation.

## Scenario

BetterPurchase is a fictional retail chain, looking to stand up a simple reporting environment in the cloud.  I will generate data, stage it on an AWS s3 bucket, pull it into Snowflake, then leverage DBT for data transformations, testing, and documentation.

## Data & Architecture

To keep things simple, this project will consist of store, product, customer, and sales data.  Data will be staged on an AWS s3 bucket, then loaded into Snowflake where DBT will take over.  Reporting will be built in Tableau.

DIAGRAM HERE


## Source Data Generation
See the [source data](./Source%20Data/) README file for documentation on how I gathered and generated data for this project.

## DBT
See the [DBT project](./DBT/dbt_betterPurchase/) for documentation on the various DBT components of this project.

## Tableau
placeholder - - Tableau not yet completed