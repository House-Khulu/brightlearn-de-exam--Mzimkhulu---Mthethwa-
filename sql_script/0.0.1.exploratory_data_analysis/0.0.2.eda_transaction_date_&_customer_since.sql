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


  /*=========================================
  Exploratory Data Analysis: Transaction_date
  ==========================================*/


  -------------------------------------------------------
  -- Checking the number of transactions on purchase_date
  -------------------------------------------------------
  SELECT [transaction_date] 
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  ORDER BY [transaction_date];


  /*=================================================
  Insight: 5 000 rows
  Anomalies: The format of the date is not consistent
  Date Range: From 01-01-2024 to 30-06-2024
  ===================================================*/

  -------------------------------------------------------
  --Counting the number transactions per transaction_date
  -------------------------------------------------------
  SELECT [transaction_date], 
  COUNT(*) AS number_of_purchases
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  GROUP BY [transaction_date]
  HAVING COUNT(*) > 1;


  ------------------------------------------
  --Checking for nulls from transaction_date 
  ------------------------------------------
  SELECT COUNT(*) AS null_count
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [transaction_date] IS NULL;

  /*======================
  Insight: No NULL values
  ======================*/


  /*========================================
  Exploratory Data Analysis: customer_since
  ==========================================*/

  ---------------------------------------
  -- Checking the dates on customer_since
  ---------------------------------------
  SELECT [customer_since] 
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  ORDER BY [customer_since];

  /*====================================================================================
  Insight: 5 000 rows
  Anomalies: The customer_since dates does not correspond with the transaction_date
  and the difference in time is way too much. The customer_since range date is way older 
  than the transactional dates on the dataset.
  Date Range: From 01-09-2018 to 15-10-2023
  ======================================================================================*/


  ------------------------------------------------------------
  --Counting the number of engagement dates per customer_since
  ------------------------------------------------------------
  SELECT [customer_since], 
  COUNT(*) AS number_of_purchases
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  GROUP BY [customer_since]
  HAVING COUNT(*) > 1;

  /*======================
  Insight: 253 NULL values
  ======================*/



