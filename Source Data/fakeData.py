from faker import Faker
from faker.providers import DynamicProvider
from datetime import datetime
import pandas as pd
import numpy as np
import random


# Cheating a bit here since I know something about the data, but this only exists because I am generating fake records 
num_customers = 1000
num_stores = 35
fake_ids_created = False
fake = Faker()

#Return a list of n random products
def multiple_products(n):
    products =[]
    for _ in range(n):
        products.append(fake.product_id())
    return products

def generate_customers():
    customers = []

    for _ in range(num_customers):
        customers.append(
            {
                'cust_name': fake.name(),
                'phone_number': fake.phone_number(),
                'email': fake.email(),
                'address':fake.address(),
                'birthday': fake.date_between_dates(datetime.strptime('1/1/1950','%m/%d/%Y'),datetime.strptime('12/31/2000','%m/%d/%Y'))
            })

    df_cust = pd.DataFrame.from_dict(customers)
    #create a customer id
    df_cust.reset_index(inplace=True)
    df_cust.rename({'index':'id'},axis='columns')
    df_cust.to_csv('Files/customers.csv',index=False)

def prep_fake_ids():
    # There is a bit of hard coded "cheating" here since I am creating fake data
    # Program expects that the files below have already been generated from the BestBuyAPI, since it will use those to create a reference of "valid" product and store ids
    # The id code below works only because I know once imported this is how the ids will be created in Snowflake, and the exact link isn't important here so long as the id is valid 

    try:
        laptop_ids = []
        laptops = pd.read_csv('Files/laptops.csv')
        for i in range(len(laptops)):
            laptop_ids.append('LAP-' + str(i).zfill(8) ) 


        fitness_ids = []
        fitness_products = pd.read_csv('Files/healthFitness.csv')
        for i in range(len(fitness_products)):
            fitness_ids.append('FIT-' + str(i).zfill(8) )


        automation_ids = []
        automation_products = pd.read_csv('Files/homeAutomation.csv')
        for i in range(len(automation_products)):
            automation_ids.append('AUT-' + str(i).zfill(8) )
            
        cell_ids = []
        cells = pd.read_csv('Files/cellPhones.csv')
        for i in range(len(cells)):
            cell_ids.append('CEL-' + str(i).zfill(8) )
            
        all_products = laptop_ids 

        all_products.extend(fitness_ids)
        all_products.extend(automation_ids)
        all_products.extend(cell_ids)
    except Exception:
        print("Error while attempting to build dimension ids - please ensure support files exist")
        quit()

    products_provider = DynamicProvider (
        provider_name='product_id',
        elements=all_products,
    )
    fake.add_provider(products_provider)
    fake_ids_created = True
    
def generate_transactions(num_records):
    if not fake_ids_created:
        prep_fake_ids()
        

    transactions = []
    #Generate fake transaction records, not exactly realistic since I don't have sales totals etc but I'll add additional info in Snowflake
    for i in range(num_records):
        transactions.append(
            {
                'cust_id': random.randrange(0,num_customers),
                'store_id': random.randrange(0,num_stores),
                'products': multiple_products(random.randrange(1,5)), #Random number of random products
                'transaction_date': fake.date_between_dates(datetime.strptime('1/1/1990','%m/%d/%Y'),datetime.strptime('12/31/2000','%m/%d/%Y'))
            })
    df_transactions = pd.DataFrame.from_dict(transactions)
    df_transactions.reset_index(inplace=True)
    df_transactions = df_transactions.rename({'index':'id'},axis='columns')
    df_transactions.to_csv('Files/transactions.csv',index=False)