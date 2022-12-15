import bestBuyAPI
import fakeData
import logging

#clear / start a new log file
logging.basicConfig(level=logging.DEBUG, filename='logs/generate_data.log',filemode="w",
                    format="%(levelname)s - %(message)s - %(asctime)s")

if __name__ =='__main__':
    #bestBuy data must be pulled first
    bestBuyAPI.get_stores()
    bestBuyAPI.get_all_products()
    
    fakeData.generate_customers() 
    fakeData.generate_transactions(50_000) #May want to adjust the number of transactions

# Add copy to S3?
# import boto3

# def copy_csv_to_s3(csv_file_path, s3_bucket_name, s3_file_path):
#     # Create an S3 client
#     s3 = boto3.client('s3')

#     # Upload the CSV file to the S3 bucket
#     s3.upload_file(csv_file_path, s3_bucket_name, s3_file_path)
