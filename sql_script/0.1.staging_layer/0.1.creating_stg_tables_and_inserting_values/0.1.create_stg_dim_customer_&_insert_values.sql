--------------------------------
--Checking for distinct customer
--------------------------------
SELECT DISTINCT
         [customer_first_name],
         [customer_last_name],
         [customer_phone],
         [customer_city],
         [customer_province],
         [customer_loyalty_tier]
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data];
 

/* =========================================================================
   CREATE stg_dim_customer Table using the IF NOT EXISTS clause (SAFE RERUN)
   Database : stg_brightlearn_sales
   Schema   : dbo
   ========================================================================= */

IF OBJECT_ID('[stg_brightlearn_sales].[dbo].[stg_dim_customer]', 'U') IS NULL
BEGIN

    CREATE TABLE [stg_brightlearn_sales].[dbo].[stg_dim_customer] (

        [customer_first_name] [nvarchar](50) NULL,
        [customer_last_name] [nvarchar](50) NULL,
        [customer_phone] INT NULL,
        [customer_city] [nvarchar](50) NULL,
	    [customer_province] [nvarchar](50) NULL,
        [customer_loyalty_tier] [nvarchar](50) NULL,
        [created_date] DATETIME2(0) NOT NULL DEFAULT GETDATE(),
        [modified_date] DATETIME2(0) NOT NULL DEFAULT GETDATE()
    );

END;

/* ===================================================================
   INSERT INTO stg_dim_customer (SAFE RERUN)
   1.Used the SELECT DISTINCT Clause to return only unique values
   2.Then used the WHERE NOT EXISTS clause to avoid data duplication
   =================================================================== */

INSERT INTO [stg_brightlearn_sales].[dbo].[stg_dim_customer]
(
         [customer_first_name],
         [customer_last_name],
         [customer_phone],
         [customer_city],
         [customer_province],
         [customer_loyalty_tier]
)

SELECT DISTINCT
         r.[customer_first_name],
         r.[customer_last_name], 
         r.[customer_phone],
         r.[customer_city],
         r.[customer_province],
         r.[customer_loyalty_tier]
FROM [stg_brightlearn_sales].[dbo].[brightlearn_raw_data] r
WHERE NOT EXISTS
(
    SELECT 1
    FROM [stg_brightlearn_sales].[dbo].[stg_dim_customer] c
    WHERE c.[customer_first_name] = r.[customer_first_name]
      AND c.[customer_last_name] = r.[customer_last_name]
      AND c.[customer_phone] = r.[customer_phone]
      AND c.[customer_city] = r.[customer_city]
      AND c.[customer_province] = r.[customer_province]
      AND c.[customer_loyalty_tier] = r.[customer_loyalty_tier]
);
GO

-----------------------
--View stg_dim_customer
-----------------------

SELECT * FROM [stg_brightlearn_sales].[dbo].[stg_dim_customer];




         