--CREATE STAGING TABLES

CREATE TRANSIENT TABLE stores (
    address VARCHAR,
    address2 VARCHAR,
    city VARCHAR,
    country VARCHAR,
    lat FLOAT,
    long FLOAT,
    name VARCHAR,
    long_name VARCHAR,
    phone varchar,
    full_postal_code VARCHAR,
    region VARCHAR,
    storeid INT,
    storeType VARCHAR
);


CREATE TRANSIENT TABLE cell_phones (
    color VARCHAR,    
    condition VARCHAR,
    customerReviewAverage FLOAT,
    customerReviewCount INT,
    description  VARCHAR,
    features VARIANT,
    longDescription VARCHAR,
    manufacturer VARCHAR,
    modelNumber VARCHAR,
    name VARCHAR,
    regularPrice FLOAT,
    salePrice FLOAT,
    shortDescription VARCHAR,
    sku VARCHAR,
    type VARCHAR,
    upc VARCHAR
    
);

CREATE TABLE laptops like cell_phones; 
CREATE TABLE home_automation like cell_phones; 
CREATE TABLE health_fitness like cell_phones; 

CREATE TRANSIENT TABLE customers (
    id INT,
    cust_name VARCHAR,
    phone_number VARCHAR,
    email VARCHAR,
    address VARCHAR,
    birthday date
);

CREATE TRANSIENT TABLE transactions (
    id INT,
    cust_id int,
    store_id int,
    products VARIANT,
    transaction_date date
);

--CREATE AWS INTEGRATION OBJECT
CREATE OR REPLACE STORAGE INTEGRATION aws_integration
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = 'S3'
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = '<arn>'
  STORAGE_ALLOWED_LOCATIONS = ('s3://better-purchase/');
  

DESC INTEGRATION aws_integration;
  
  
--DEFAULT FILE FORMAT  
CREATE OR REPLACE FILE FORMAT CSV_OptionalDoubleQuotes_WithHeader
    TYPE = CSV
    FIELD_DELIMITER = ','
    FIELD_OPTIONALLY_ENCLOSED_BY='"'
    SKIP_HEADER = 1;

--CREATE STAGE OBJECT
CREATE STAGE aws_stage
  storage_integration = aws_integration
  url = 's3://better-purchase/'
  file_format = CSV_OptionalDoubleQuotes_WithHeader;
  
  
LIST @aws_stage;


--DATA LOAD

COPY INTO cell_phones
FROM @aws_stage/raw_files
PATTERN = '.*cellPhone.*'
FILE_FORMAT = (
    TYPE = CSV
    FIELD_DELIMITER = ','
    FIELD_OPTIONALLY_ENCLOSED_BY='"'
    SKIP_HEADER = 1
);

COPY INTO laptops
FROM @aws_stage/raw_files
PATTERN = '.*laptop.*'
FILE_FORMAT = (
    TYPE = CSV
    FIELD_DELIMITER = ','
    FIELD_OPTIONALLY_ENCLOSED_BY='"'
    SKIP_HEADER = 1
);

COPY INTO health_fitness
FROM @aws_stage/raw_files
PATTERN = '.*health.*'
FILE_FORMAT = (
    TYPE = CSV
    FIELD_DELIMITER = ','
    FIELD_OPTIONALLY_ENCLOSED_BY='"'
    SKIP_HEADER = 1
);

COPY INTO home_automation
FROM @aws_stage/raw_files
PATTERN = '.*home.*'
FILE_FORMAT = (
    TYPE = CSV
    FIELD_DELIMITER = ','
    FIELD_OPTIONALLY_ENCLOSED_BY='"'
    SKIP_HEADER = 1
);

COPY INTO customers
FROM @aws_stage/raw_files
PATTERN = '.*customer.*'
FILE_FORMAT = (
    TYPE = CSV
    FIELD_DELIMITER = ','
    FIELD_OPTIONALLY_ENCLOSED_BY='"'
    SKIP_HEADER = 1
);

COPY INTO stores
FROM @aws_stage/raw_files
PATTERN = '.*store.*'
FILE_FORMAT = (
    TYPE = CSV
    FIELD_DELIMITER = ','
    FIELD_OPTIONALLY_ENCLOSED_BY='"'
    SKIP_HEADER = 1
);

COPY INTO transactions
FROM @aws_stage/raw_files
PATTERN = '.*transaction.*'
FILE_FORMAT = (
    TYPE = CSV
    FIELD_DELIMITER = ','
    FIELD_OPTIONALLY_ENCLOSED_BY='"'
    SKIP_HEADER = 1
);