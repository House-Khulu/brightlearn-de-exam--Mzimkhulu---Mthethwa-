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


  /*=========================================
  Exploratory Data Analysis: payment_methodd
  ==========================================*/


  ----------------------------------
  --Checking distinct payment_method
  ----------------------------------

  SELECT DISTINCT [payment_method]
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data];

  /*=================================
  Insight: 5 distinct payment_methods
  ==================================*/

  ----------------------------------------
  --Checking for NULLS from Payment_method
  ----------------------------------------
  SELECT COUNT(*) AS null_count
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [payment_method] IS NULL;

  /*=====================================
  Insight:No NULLS from the above query
  =======================================*/


  /*===================================================================================
  Note: If the original value is not equal to the same values after trimming, it means
  there are spaces. If there are no results after running the query, it means 
  there are no spaces
  =====================================================================================*/

  ---------------------------------------------------
  -- Checking for unwanted space from Payment_method
  --------------------------------------------------

  SELECT [payment_method]
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [payment_method] != TRIM([payment_method]);

 /*================================================
  Insight: there are no spaces from the above query
  ================================================*/