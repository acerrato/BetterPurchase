import requests
import time
import pandas as pd
import sensitive 
import logging

logging.basicConfig(level=logging.DEBUG, filename='logs/generate_data.log',filemode="a",
                    format="%(levelname)s - %(message)s - %(asctime)s")

product_categories = {
        'laptops': 'abcat0502000',
        'healthFitness': 'pcmcat242800050021',
        'cellPhones': 'pcmcat209400050001',
        'homeAutomation': 'pcmcat254000050002'
    }


#TODO: change the pandas.append() to concat to get rid of deprecation warnings 

def get_stores():
    logging.info("Gathering store data")
    #TODO: Don't need this so broken out, make this URL building consistent across methods
    base_url = "https://api.bestbuy.com/v1/stores((region=PA))"
    try:
        api_key = 'apiKey=' + sensitive['apiKey'] 
    except KeyError:
        logging.exception("Failure while referencing API key - ensure 'sensitive.py' file exists with the key value needed")
        quit()
        
    fields = "show=address,address2,city,country,lat,location,lng,name,longName,phone,fullPostalCode,region,storeId,storeType"
    page = 1 
    format = "&format=json"


    url = base_url + "?" + api_key + "&" + fields + "&page=" + str(page) + format

    payload={}
    headers = {}
    
    allowed_retries = 10
    attempts = 0
    
    while attempts <= allowed_retries:
        response = requests.request("GET", url, headers=headers, data=payload)
        try:
            df_stores = pd.DataFrame.from_dict(response.json()['stores'])
            attempts = allowed_retries + 1
        except KeyError:
            logging.debug("Failure in parsing API response - expected key 'stores' ")
            logging.debug(response.json())
            
        
    

    for _ in range(response.json()['totalPages']- 1) :
        time.sleep(1) #So we won't exceed the calls per second limit
        page = page + 1
        url = base_url + "?" + api_key + "&" + fields + "&page=" + str(page) + format
        response = requests.request("GET", url, headers=headers, data=payload)
        try:
            df_stores = df_stores.append(pd.DataFrame.from_dict(response.json()['stores']))
        except KeyError:
            logging.exception("Failure in parsing API response - expected key 'stores' ")
            logging.debug(response.json())
            page = page - 1
            time.sleep(5) #wait an extra 5s if we hit an error
    df_stores.to_csv("Files/stores.csv",index=False)

def get_product_categories():
    return product_categories

def get_product_category_code(category):
    category_code = ''
    try:
        category_code = product_categories[category]
    except KeyError:
        logging.exception('Category {} not found - aborting'.format(category))
        quit()
    
    return category_code

#Pull everything at once
def get_all_products():
    for category in get_product_categories():
        logging.debug('Collecting {} data'.format(category))
        try:
            get_products(category)
        except Exception:
            logging.debug('Pausing for API limits')
            time.sleep(5) #So we won't exceed the API call limits
            get_products(category)

#Allow for pulling a specific category on demand 
def get_products(category):
    
    category_code = get_product_category_code(category)
    
    base_url = "https://api.bestbuy.com/v1/products((categoryPath.id=" + category_code + "))?apiKey=" + sensitive['apiKey']  + "w&sort=color.asc&show=color,condition,customerReviewAverage,customerReviewCount,description,features.feature,longDescription,manufacturer,modelNumber,name,regularPrice,salePrice,shortDescription,sku,type,upc&pageSize=100"
    page = 1 
    format = "&format=json"


    url = base_url + "&page=" + str(page) + format

    payload={}
    headers = {}

    response = requests.request("GET", url, headers=headers, data=payload)

    df_products = pd.DataFrame.from_dict(response.json()['products'])

    for _ in range(response.json()['totalPages']- 1) :
        time.sleep(1) #So we won't exceed the calls per second limit
        page = page + 1
        url = base_url + "&page=" + str(page) + format
        response = requests.request("GET", url, headers=headers, data=payload)
        df_products = df_products.append(pd.DataFrame.from_dict(response.json()['products']))
        
    df_products.to_csv('Files/' + category + ".csv",index=False)
    
