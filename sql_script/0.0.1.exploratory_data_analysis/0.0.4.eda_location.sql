/*========================================
  Exploratory Data Analysis: location info
 =========================================*/


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
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data];


  /*==========================
  Insight: 5 000 total records
  ===========================*/

  SELECT * FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data];


  -----------------------------
  --Checking distinct location
  -----------------------------

  SELECT DISTINCT 
         [customer_city]
        ,[customer_province]
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data];

  /*=============
  Insight:41 rows
  ===============*/

  -------------------------------------
  --Checking distinct individual values
  -------------------------------------

  SELECT DISTINCT [customer_city] FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data];

  SELECT DISTINCT [customer_province] FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data];

  /*===========================
  Inisght: 
  - 41 distnct cities
  - 6 distinct provinces with a
    NULL value
  ===========================*/

  -------------------------------
  --checking the number of counts
  -------------------------------
  SELECT [customer_city],[customer_province],
  COUNT(*) AS number_of_counts
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  GROUP BY [customer_city],[customer_province];

  /*=======================
  Insight: 253 nulls vaues
  =======================*/


  /*===================================================================================
  Note: If the original value is not equal to the same values after trimming, it means
  there are spaces. If there are no results after running the query, it means 
  there are no spaces
  =====================================================================================*/

 /*======================================================================
  -- Checking for unwanted space from customer_city and customer_province 
  =======================================================================*/

  SELECT [customer_city]
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [customer_city] != TRIM([customer_city]);

  
  SELECT [customer_province]
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [customer_province] != TRIM([customer_province]);

 /*==================================================
  Insight: there are no spaces from the above queries
  ===================================================*/