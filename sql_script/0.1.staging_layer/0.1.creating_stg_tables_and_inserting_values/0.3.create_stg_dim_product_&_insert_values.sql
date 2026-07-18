--------------------------------
--Checking for distinct product
--------------------------------
 SELECT DISTINCT 
       [product_name]
      ,[category]
      ,[sub_category]
      ,[sku]
      ,[supplier]
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data];

/* =========================================================================
   CREATE stg_dim_product Table using the IF NOT EXISTS clause (SAFE RERUN)
   Database : stg_brightlearn_sales
   Schema   : dbo
   ========================================================================= */

IF OBJECT_ID('[stg_brightlearn_sales].[dbo].[stg_dim_product]', 'U') IS NULL
BEGIN

    CREATE TABLE [stg_brightlearn_sales].[dbo].[stg_dim_product] (

        [product_key] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
        [product_name] VARCHAR (100) NOT NULL, 
        [category] VARCHAR (100) NOT NULL,
        [sub_category] VARCHAR (100) NOT NULL,
        [sku] VARCHAR (100) NOT NULL,
        [supplier] VARCHAR (100) NOT NULL,
        [created_date] DATETIME2(0) NOT NULL DEFAULT GETDATE(),
        [modified_date] DATETIME2(0) NOT NULL DEFAULT GETDATE()
    );

END;

/* ===================================================================
   INSERT INTO stg_dim_product (SAFE RERUN)
   1.Used the SELECT DISTINCT Clause to return only unique values
   2.Used the COALESCE function to replace the NULLs with the "Unknown"
   3.Then used the WHERE NOT EXISTS clause to avoid data duplication
   =================================================================== */

INSERT INTO [stg_brightlearn_sales].[dbo].[stg_dim_product]
(
          [product_name]
         ,[category]
         ,[sub_category]
         ,[sku]
         ,[supplier]
)

SELECT DISTINCT
           r.[product_name],
  COALESCE(r.[category], 'Unknown'),
           r.[sub_category],
           r.[sku],
           r.[supplier]

FROM [stg_brightlearn_sales].[dbo].[brightlearn_raw_data] r
WHERE NOT EXISTS
(
    SELECT 1
    FROM [stg_brightlearn_sales].[dbo].[stg_dim_product] p
    WHERE p.[product_name] = r.[product_name]
      AND p.[category] = r.[category]
      AND p.[sub_category] = r.[sub_category]
      AND p.[sku] = r.[sku]
      AND p.[supplier] = r.[supplier]
      
);
GO

-----------------------
--View stg_dim_product
-----------------------

SELECT * FROM [stg_brightlearn_sales].[dbo].[stg_dim_product];



