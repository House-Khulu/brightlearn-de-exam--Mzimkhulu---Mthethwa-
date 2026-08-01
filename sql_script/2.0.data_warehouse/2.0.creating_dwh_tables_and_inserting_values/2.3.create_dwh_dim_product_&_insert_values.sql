--------------------------------
--Checking for distinct product
--------------------------------
 SELECT DISTINCT 
       [product_name]
      ,[sub_category]
      ,[sku]
      ,[supplier]
  FROM [stg_brightlearn_sales].[dbo].[stg_dim_product];

/* =========================================================================
   CREATE clean_dim_product Table using the IF NOT EXISTS clause (SAFE RERUN)
   Database : stg_brightlearn_sales
   Schema   : dbo
   ========================================================================= */

IF OBJECT_ID('[stg_brightlearn_sales].[dbo].[cleandim_product]', 'U') IS NULL
BEGIN

    CREATE TABLE [stg_brightlearn_sales].[dbo].[clean_dim_product] (

        [product_key] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
        [product_name] [nvarchar](50) NOT NULL,
	    [sub_category] [nvarchar](50) NOT NULL,
	    [sku] [nvarchar](50) NOT NULL,
        [supplier] [nvarchar](50) NOT NULL,
        [created_date] DATETIME2(0) NOT NULL DEFAULT GETDATE(),
        [modified_date] DATETIME2(0) NOT NULL DEFAULT GETDATE()
    );

END;

/* ===================================================================
   INSERT INTO clean_dim_product (SAFE RERUN)
   1.SELECT DISTINCT Clause to return only unique values
   2.TRIM fucntion to remove unwanted spaces
   3.WHERE NOT EXISTS clause to avoid data duplication
   =================================================================== */

INSERT INTO [stg_brightlearn_sales].[dbo].[clean_dim_product]
(
          [product_name]
         ,[sub_category]
         ,[sku]
         ,[supplier]
)

SELECT DISTINCT
           TRIM(UPPER(r.[product_name])) AS product_name,
           TRIM(UPPER(r.[sub_category])) AS sub_category,
           TRIM(UPPER(r.[sku])) AS SKU,
           TRIM(UPPER(r.[supplier])) AS supplier

FROM [stg_brightlearn_sales].[dbo].[stg_dim_product] r
WHERE NOT EXISTS
(
    SELECT 1
    FROM [stg_brightlearn_sales].[dbo].[clean_dim_product] p
    WHERE p.[product_name] = r.[product_name]
      AND p.[sub_category] = r.[sub_category]
      AND p.[sku] = r.[sku]
      AND p.[supplier] = r.[supplier]
      
);
GO

-----------------------
--View clean_dim_product
-----------------------

SELECT * FROM [stg_brightlearn_sales].[dbo].[clean_dim_product];



