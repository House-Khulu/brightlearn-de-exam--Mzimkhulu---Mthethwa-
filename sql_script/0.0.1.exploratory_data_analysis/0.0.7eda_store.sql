 /*====================================
  Exploratory Data Analysis: store info
  =====================================*/

/*=================================
 View All Records From The Dataset
 =================================*/

 SELECT [transaction_date]
      ,[payment_method]
      ,[cashier_name]
      ,[transaction_amount]
      ,[transaction_discount]
      ,[customer_first_name]
      ,[customer_last_name]
      ,[customer_email]
      ,[customer_phone]
      ,[customer_city]
      ,[customer_province]
      ,[customer_loyalty_tier]
      ,[customer_since]
      ,[store_name]
      ,[store_city]
      ,[store_province]
      ,[store_region]
      ,[store_manager]
      ,[product_name]
      ,[category]
      ,[sub_category]
      ,[sku]
      ,[unit_price]
      ,[cost_price]
      ,[supplier]
      ,[qty]
      ,[line_amount]
      ,[stock_on_hand]
      ,[reorder_threshold]
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]


  /*==========================
  Insight: 5 000 total records
  ===========================*/

  SELECT * FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data];


  -----------------------------
  --Checking distinct customers
  -----------------------------

  SELECT DISTINCT [cashier_name]
       ,[store_name]
       ,[store_city]
       ,[store_province]
       ,[store_region]
       ,[store_manager]
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data];

  /*===============
  Insight: 25 rows
  ================*/

  /*============================================================================
  Checking individual distinct records from cashier_name, store_name, store_city,
  store_region and store_manager
  ==============================================================================*/

  SELECT DISTINCT [store_name] FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data];


  SELECT DISTINCT [cashier_name] FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data];


  SELECT DISTINCT [store_city] FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data];


  SELECT DISTINCT [store_region] FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data];


  SELECT DISTINCT [store_manager] FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data];

  /*========================
  Insight:
  - 25 distinct cashier_name
  - 5 distinct store_name 
  - 5 distinct store_city
  - 3 distinct store_region
  - 5 distinct store_manager
  ==========================*/


  /*=============================================================
  --Checking for NULLS from cashier_name, store_name, store_city,
  store_region and store_manager
  ==============================================================*/

  SELECT COUNT(*) AS null_count
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [cashier_name] IS NULL;
  
  
  SELECT COUNT(*) AS null_count
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [store_name] IS NULL;


  SELECT COUNT(*) AS null_count
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [store_city] IS NULL;
  

  SELECT COUNT(*) AS null_count
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [store_region] IS NULL;
  

  SELECT COUNT(*) AS null_count
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [store_manager] IS NULL;
  
  /*=====================================
  Insight:No NULLS from the above queries
  =======================================*/


  /*===================================================================================
  Note: If the original value is not equal to the same values after trimming, it means
  there are spaces. If there are no results after running the query, it means 
  there are no spaces
  =====================================================================================*/

  /*======================================================================
  -- Checking for unwanted space from cashier_name, store_name, store_city,
  store_region and store_manager
  =======================================================================*/

  SELECT [cashier_name]
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [cashier_name] != TRIM([cashier_name]);

  
  SELECT [store_name]
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [store_name] != TRIM([store_name]);


  SELECT [store_city]
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [store_city] != TRIM([store_city]);


  SELECT [store_region]
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [store_region] != TRIM([store_region]);


  SELECT [store_manager]
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [store_manager] != TRIM([store_manager]);

 /*==================================================
  Insight: there are no spaces from the above queries
  ===================================================*/





