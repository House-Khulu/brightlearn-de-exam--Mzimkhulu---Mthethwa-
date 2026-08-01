--------------------------------
--Checking for distinct product
--------------------------------
 SELECT DISTINCT 
       [product_name]
      ,[sub_category]
      ,[sku]
      ,[supplier]
  FROM [stg_brightlearn_sales].[dbo].[clean_dim_product];

/* =========================================================================
   CREATE dwh_dim_product Table using the IF NOT EXISTS clause (SAFE RERUN)
   Database : dwh_brightlearn_sales
   Schema   : dbo
   ========================================================================= */

IF OBJECT_ID('[dwh_brightlearn_sales].[dbo].[dwh_dim_product]', 'U') IS NULL
BEGIN

    CREATE TABLE [dwh_brightlearn_sales].[dbo].[dwh_dim_product] (

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
   INSERT INTO dwh_dim_product (SAFE RERUN)
   1.SELECT DISTINCT Clause to return only unique values
   2.WHERE NOT EXISTS clause to avoid data duplication
   =================================================================== */

INSERT INTO [dwh_brightlearn_sales].[dbo].[dwh_dim_product]
(
          [product_name]
         ,[sub_category]
         ,[sku]
         ,[supplier]
)

SELECT DISTINCT
           c.[product_name],
           c.[sub_category],
           c.[sku],
           c.[supplier]

FROM [stg_brightlearn_sales].[dbo].[clean_dim_product] c
WHERE NOT EXISTS
(
    SELECT 1
    FROM [dwh_brightlearn_sales].[dbo].[dwh_dim_product] dwh
    WHERE dwh.[product_name] = c.[product_name]
      AND dwh.[sub_category] = c.[sub_category]
      AND dwh.[sku] = c.[sku]
      AND dwh.[supplier] = c.[supplier]
      
);
GO

-----------------------
--View dwh_dim_product
-----------------------

SELECT * FROM [dwh_brightlearn_sales].[dbo].[dwh_dim_product];



