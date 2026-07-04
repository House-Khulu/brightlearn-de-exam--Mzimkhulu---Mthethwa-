/*=====================================================
  Exploratory Data Analysis: customer_loyalty_tier info
  ====================================================*/
/* ======================================
   Exploratory Data Analysis on : Metrics
   ====================================== */

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


  ------------------------------------------
  --Retrieving columns consisting of metrics
  ------------------------------------------

  SELECT [transaction_amount]
        ,[transaction_discount]
        ,[unit_price]
        ,[cost_price]
        ,[qty]
        ,[line_amount]
        ,[stock_on_hand]
        ,[reorder_threshold]
  
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data];


  /*=================================================================
  Checking for NULLS or negative numbers on the following columns:
  - transaction_amount
  - transaction_discount
  - unit_price
  - cost_price
  - qty
  - line_amount
  - stock_on_hand
  - reorder_threshold
  ===================================================================*/

  SELECT [transaction_amount]
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [transaction_amount] < 0 OR [transaction_amount] IS NULL;


  SELECT [transaction_discount]
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [transaction_discount] < 0 OR [transaction_discount] IS NULL;

 
  SELECT [unit_price]
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [unit_price] < 0 OR [unit_price] IS NULL;


  SELECT [cost_price]
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [cost_price] < 0 OR [cost_price] IS NULL;


  SELECT [qty]
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [qty] < 0 OR [qty] IS NULL;


  SELECT [line_amount]
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [line_amount] < 0 OR [line_amount] IS NULL;


  SELECT [stock_on_hand]
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [stock_on_hand] < 0 OR [stock_on_hand] IS NULL;


  SELECT [reorder_threshold]
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [reorder_threshold] < 0 OR [reorder_threshold] IS NULL;

  /*===========================================================================
  Insight:No NULLS nor negative values from the above queries,
  except for transaction_amount with **435 rows consisting of negative values**
  =============================================================================*/


  ----------------------------------------------------------------
  --Counting the number of negative values from transaction_amount
  ----------------------------------------------------------------
  SELECT [transaction_amount],
  COUNT(*) AS number_of_negative_values
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [transaction_amount] <= 0
  GROUP BY [transaction_amount];



  -----------------------------------------------------------------------
  --On transaction_amount Calculating average, minimum and maximum amount
  -----------------------------------------------------------------------

  SELECT SUM([transaction_amount]) AS total_revenue,
         AVG([transaction_amount]) AS average_amount,
         MIN([transaction_amount]) AS min_amount,
         MAX([transaction_amount]) AS max_amount
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data];

  /*==================
  Insight:
  - sum 4 603 787.99
  - average 920. 75
  - minimum -477.01
  - maximum 17 464.97
  ===================*/



  ----------------------------------------
  --Sum negative transaction_amount values
  ----------------------------------------

  SELECT SUM([transaction_amount]) AS total_revenue
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [transaction_amount] < 0;

  /*=================
  Insight: 61 785.21
  ===================*/



  -----------------------------------------------------------------------------
  -- On transaction_discount calculate sum, average, minimum and maximum amount
  -----------------------------------------------------------------------------

  SELECT SUM([transaction_discount]) AS total_discount,
         AVG([transaction_discount]) AS average_discount,
         MIN([transaction_discount]) AS min_discount,
         MAX([transaction_discount]) AS max_discount
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data];

  /*==============
  Insight:
  - sum 466 685
  - average 93.33
  - minimum 0
  - maximum 500
  ================*/



  -------------------------------------------------------------------
  -- On cost_price calculate sum, average, minimum and maximum amount
  -------------------------------------------------------------------
  SELECT SUM([cost_price]) AS total_cost_price,
         AVG([cost_price]) AS average_cost_price,
         MIN([cost_price]) AS min_cost_price,
         MAX([cost_price]) AS max_cost_price
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data];

  /*==============
  Insight:
  - sum 977 619.5
  - average 195.52
  - minimum 9.5
  - maximum 2800
  ================*/

  -----------------
  --Count total qty
  -----------------
  SELECT SUM(CAST(qty AS INT)) AS total_number_of_qty, --**I am using CAST because the source data came as nvarchar datatype for qty**
         AVG(CAST(qty AS INT)) AS average_number_of_qty,
         MIN(CAST(qty AS INT)) AS min_number_of_qty,
         MAX(CAST(qty AS INT)) AS max_number_of_qty
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data];

  /*=========
  Insight:
  - sum 8982
  - average 1
  - minimum 1
  - maximum 5
  ===========*/


  --------------------------------------------------------------------
  -- On line_amount calculate sum, average, minimum and maximum amount
  --------------------------------------------------------------------
  SELECT SUM([line_amount]) AS total_line_amount,
         AVG([line_amount]) AS average_line_amount,
         MIN([line_amount]) AS min_line_amount,
         MAX([line_amount]) AS max_line_amount
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data];

  /*==============
  Insight:
  - sum 2 231 806.03
  - average 446.36
  - minimum 15.99
  - maximum 17 495
  ================*/


  ----------------------------------------------------------------------
  -- On stock_on_hand calculate sum, average, minimum and maximum amount
  ----------------------------------------------------------------------
  SELECT SUM([stock_on_hand]) AS total_stock_on_hand,
         AVG([stock_on_hand]) AS average_stock_on_hand,
         MIN([stock_on_hand]) AS min_stock_on_hand,
         MAX([stock_on_hand]) AS max_stock_on_hand
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data];

  /*===========
  Insight:
  - sum 110 217
  - average 22
  - minimum 6
  - maximum 50
  =============*/


  --------------------------------------------------------------------------
  -- On reorder_threshold calculate sum, average, minimum and maximum amount
  --------------------------------------------------------------------------
  SELECT SUM([reorder_threshold]) AS total_reorder_threshold,
         AVG([reorder_threshold]) AS average_reorder_threshold,
         MIN([reorder_threshold]) AS min_reorder_threshold,
         MAX([reorder_threshold]) AS max_reorder_threshold
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data];

  /*===========
  Insight:
  - sum 42 904
  - average 8
  - minimum 3
  - maximum 20
  =============*/




