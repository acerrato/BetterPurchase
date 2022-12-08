# Generating Data
To generate data for this project I will use the BestBuy API to gather product and store information to use as a starting point.  I will then generate synthetic data for sales transactions and customers related to those products / stores.

## Documentation
[BestBuy API](https://developer.bestbuy.com/)

[Faker](https://faker.readthedocs.io/en/master/)

## Python Scripts

### [bestBuyAPI.py](bestBuyAPI.py)
This file leverages the BestBuy API to download store and product information.

### [fakeData.py](fakeData.py)
This file uses the Faker library, combined with data collected from BestBuy to generate fake customer and transaction data.

### [generateData.py](generateData.py)
This is the main python script - it calls the bestBuyAPI and fakeData methods to generate our source files.

## Output Files
- Store Records
    - [stores.csv](Files/stores.csv)
- Product Records
    - [laptops.csv](Files/laptops.csv)
    - [cellPhones.csv](Files/cellPhones.csv)
    - [healthFitness.csv](Files/healthFitness.csv)
    - [homeAutomation.csv](Files/homeAutomation.csv)
- Synthetic data
    - [customers.csv](Files/customers.csv)
    - [transactions.csv](Files/transactions.csv)
