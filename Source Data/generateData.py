import bestBuyAPI
import fakeData

if __name__ =='__main__':
    #bestBuy data must be pulled first
    bestBuyAPI.get_stores()
    bestBuyAPI.get_all_products()
    
    fakeData.generate_customers() 
    fakeData.generate_transactions(50_000) #May want to adjust the number of transactions