 /*=========================================
  Exploratory Data Analysis: customer info
  ==========================================*/

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

  SELECT DISTINCT
         [customer_first_name]
        ,[customer_last_name]
        ,[customer_email]
        ,[customer_phone]
         [customer_loyalty_tier]
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data];


  /*===============
  89 Distinct rows
  ================*/


  /*==================================================================================
  NOTE: customer_first_name and customer_last_name, were done separately due to the 
  results from the above query, by merely looking at the results I noticed the count 
  is > 1 for the combinations of (customer_first_name and customer_last_name).
  Instead of running the distinct query on (customer_first_name and customer_last_name),
  I ran the count to check how many same combinations appear on (customer_first_name 
  and customer_last_name)
  ====================================================================================*/

  SELECT DISTINCT [customer_first_name],
         [customer_last_name],
  COUNT(*) AS number_of_counts
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  GROUP BY [customer_first_name],
           [customer_last_name];

  /*===============
  Insight: 51 rows
  ================*/

  

  /*
  ===========================================================================
  Checking individual distinct records from customer_email, customer_phone 
  and customer_loyalty_tier
  ===========================================================================
  */


  SELECT DISTINCT [customer_email] FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data];
  
  
  SELECT [customer_email],
  COUNT(*) AS number_of_emails
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  GROUP BY [customer_email];

  /*==============
  Insight: 46 Rows
  ===============*/

  SELECT DISTINCT [customer_phone] FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data];

  SELECT [customer_phone],
  COUNT(*) AS number_of_cell_numbers
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  GROUP BY [customer_phone];

  /*==============
  Insight: 51 Rows
  ===============*/


  SELECT DISTINCT [customer_loyalty_tier] FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data];


  SELECT [customer_loyalty_tier],
  COUNT(*) AS number_of_cell_numbers
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  GROUP BY [customer_loyalty_tier];

  /*==============
  Insight: 4 Rows
  ===============*/


  -----------------------------------------------
  --Counting the number transactions per customer
  -----------------------------------------------

  SELECT [customer_first_name],
         [customer_last_name],
         [customer_email],
         [customer_phone],
         [customer_loyalty_tier],
  COUNT(*) AS number_of_purchases
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  GROUP BY [customer_first_name],
           [customer_last_name],
           [customer_email],
           [customer_phone],
           [customer_loyalty_tier]
  HAVING COUNT(*) > 1;

  
  /*======================
  Insight: 
  - 85 ROWS
  - 253 NULL values
  ======================*/


  
  -------------------------------------------------------------------------------------------------------------------------
  --Checking for NULLS from customer_first_name, customer_last_name, customer_phone, Customer_email & customer_loyalty_tier
  -------------------------------------------------------------------------------------------------------------------------
  SELECT COUNT(*) AS null_count
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [customer_first_name] IS NULL;
  /*======================
  Insight: 253 NULL values
  ======================*/



  SELECT COUNT(*) AS null_count
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [customer_last_name] IS NULL;
  /*======================
  Insight: 253 NULL values
  ======================*/


  SELECT COUNT(*) AS null_count
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [customer_phone] IS NULL;
  /*======================
  Insight: 253 NULL values
  ======================*/


  SELECT COUNT(*) AS null_count
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [Customer_email] IS NULL;
  /*======================
  Insight: 811 NULL values
  ======================*/


  SELECT COUNT(*) AS null_count
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [customer_loyalty_tier] IS NULL;
  /*======================
  Insight: 253 NULL values
  ======================*/

  /*===================================================================================
  Note: If the original value is not equal to the same values after trimming, it means
  there are spaces. If there are no results after running the query, it means 
  there are no spaces
  =====================================================================================*/



  /*==============================================================================
  -- Checking for unwanted space from customer_first_name, customer_last_name and
  Customer_email 
  ================================================================================*/

  SELECT [customer_first_name]
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [customer_first_name] != TRIM([customer_first_name]);


  SELECT [customer_last_name]
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [customer_last_name] != TRIM([customer_last_name]);


  SELECT [Customer_email]
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [Customer_email] != TRIM([Customer_email]);


  SELECT [customer_loyalty_tier]
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [customer_loyalty_tier] != TRIM([customer_loyalty_tier]);

  /*==================================================
  Insight: there are no spaces from the above queries
  ====================================================*/
