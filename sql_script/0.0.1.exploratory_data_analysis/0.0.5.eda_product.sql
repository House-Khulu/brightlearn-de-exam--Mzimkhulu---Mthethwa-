/*========================================
  Exploratory Data Analysis: product info
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
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]


  /*==========================
  Insight: 5 000 total records
  ===========================*/

  SELECT * FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data];


  ------------------------------
  --Checking for distinct values
  ------------------------------

  SELECT DISTINCT 
       [product_name]
      ,[category]
      ,[sub_category]
      ,[sku]
      ,[supplier]
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data];


 /*=============
 Insight:68 rows
 ==============*/

 --------------------------------------
 --Check for distinct individual values
 --------------------------------------

 SELECT DISTINCT [product_name] FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data];

 SELECT DISTINCT [category] FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data];

 SELECT DISTINCT [sub_category] FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data];

 SELECT DISTINCT [sku] FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data];

 SELECT DISTINCT [supplier] FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data];

 /*======================================
 Insight:
 - 44 distinct products
 - 5 distinct categories and a null value
 - 28 distinct subcategories
 - 44 distinct SKUs
 - 41 distinct suppliers
 =======================================*/

  --------------------------
  --CHECKING for NULL values
  --------------------------
  SELECT COUNT(*) AS null_count
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [product_name] IS NULL;


  SELECT COUNT(*) AS null_count
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [category] IS NULL;


  SELECT COUNT(*) AS null_count
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [sub_category] IS NULL;


  SELECT COUNT(*) AS null_count
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [sku] IS NULL;


  SELECT COUNT(*) AS null_count
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [supplier] IS NULL;

  /*=====================================================
  Insight:
  - Only the category has 132 NULL values
  - The rest of the the values does not have NULL values
  ======================================================*/


  /*===================================================================================
  Note: If the original value is not equal to the same values after trimming, it means
  there are spaces. If there are no results after running the query, it means 
  there are no spaces
  =====================================================================================*/

  ----------------------------------------------------------------------------------------
  -- Checking for unwanted space from product_name, category, sub_category, sku & supplier
  ----------------------------------------------------------------------------------------

  SELECT [product_name]
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [product_name] != TRIM([product_name]);


  SELECT [category]
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [category] != TRIM([category]);


  SELECT [sku]
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [sku] != TRIM([sku]);


  SELECT [payment_method]
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [payment_method] != TRIM([payment_method]);


  SELECT [supplier]
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data]
  WHERE [supplier] != TRIM([supplier]);

 /*==================================================
  Insight: there are no spaces from the above queries
  ===================================================*/


