import requests
import time
import pandas as pd

product_categories = {
        'laptops': 'abcat0502000',
        'healthFitness': 'pcmcat242800050021',
        'cellPhones': 'pcmcat209400050001',
        'homeAutomation': 'pcmcat254000050002'
    }


#TODO: change the pandas.append() to concat to get rid of deprecation warnings 

def get_stores():
    print('Collecting Store Data')
    #TODO: Don't need this so broken out, make this URL building consistent across methods
    base_url = "https://api.bestbuy.com/v1/stores((region=PA))"
    api_key = 'apiKey=pb7B47pWwTo1wViwiKAYQq2w' 
    fields = "show=address,address2,city,country,lat,location,lng,name,longName,phone,fullPostalCode,region,storeId,storeType"
    page = 1 
    format = "&format=json"


    url = base_url + "?" + api_key + "&" + fields + "&page=" + str(page) + format

    payload={}
    headers = {}

    response = requests.request("GET", url, headers=headers, data=payload)
    try:
        df_stores = pd.DataFrame.from_dict(response.json()['stores'])
    except KeyError:
        print("Key Error")
        print(response.json())
    

    for _ in range(response.json()['totalPages']- 1) :
        page = page + 1
        url = base_url + "?" + api_key + "&" + fields + "&page=" + str(page) + format
        response = requests.request("GET", url, headers=headers, data=payload)
        df_stores = df_stores.append(pd.DataFrame.from_dict(response.json()['stores']))
        time.sleep(1) #So we won't exceed the calls per second limit
    df_stores.to_csv("Files/stores.csv",index=False)

def get_product_categories():
    return product_categories

def get_product_category_code(category):
    category_code = ''
    try:
        category_code = product_categories[category]
    except KeyError:
        print('Category {} not found - aborting'.format(category))
        quit()
    
    return category_code

#Pull everything at once
def get_all_products():
    for category in get_product_categories():
        print('Collecting {} data'.format(category))
        try:
            get_products(category)
        except Exception:
            print('Pausing for API limits')
            time.sleep(5) #So we won't exceed the API call limits
            get_products(category)

#Allow for pulling a specific category on demand 
def get_products(category):
    
    category_code = get_product_category_code(category)
    
    base_url = "https://api.bestbuy.com/v1/products((categoryPath.id=" + category_code + "))?apiKey=pb7B47pWwTo1wViwiKAYQq2w&sort=color.asc&show=color,condition,customerReviewAverage,customerReviewCount,description,features.feature,longDescription,manufacturer,modelNumber,name,regularPrice,salePrice,shortDescription,sku,type,upc&pageSize=100"
    page = 1 
    format = "&format=json"


    url = base_url + "&page=" + str(page) + format

    payload={}
    headers = {}

    response = requests.request("GET", url, headers=headers, data=payload)

    df_products = pd.DataFrame.from_dict(response.json()['products'])

    for _ in range(response.json()['totalPages']- 1) :
        page = page + 1
        url = base_url + "&page=" + str(page) + format
        response = requests.request("GET", url, headers=headers, data=payload)
        df_products = df_products.append(pd.DataFrame.from_dict(response.json()['products']))
        time.sleep(1) #So we won't exceed the calls per second limit
    df_products.to_csv('Files/' + category + ".csv",index=False)
    
