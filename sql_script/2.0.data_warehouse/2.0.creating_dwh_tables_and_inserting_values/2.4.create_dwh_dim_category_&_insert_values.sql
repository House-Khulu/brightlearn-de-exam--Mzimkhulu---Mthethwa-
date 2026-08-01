--------------------------------
--Checking for distinct category
--------------------------------
  SELECT DISTINCT [category]
  FROM [stg_brightlearn_sales].[dbo].[clean_dim_category];

/* =========================================================================
   CREATE dwh_dim_category Table using the IF NOT EXISTS clause (SAFE RERUN)
   Database : dwh_brightlearn_sales
   Schema   : dbo
   ========================================================================= */

IF OBJECT_ID('[dwh_brightlearn_sales].[dbo].[dwh_dim_category]', 'U') IS NULL
BEGIN

    CREATE TABLE [dwh_brightlearn_sales].[dbo].[dwh_dim_category] (

        [category_key] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
        [category] [nvarchar](50) NOT NULL,
        [created_date] DATETIME2(0) NOT NULL DEFAULT GETDATE(),
        [modified_date] DATETIME2(0) NOT NULL DEFAULT GETDATE()
    );

END;

/* ===================================================================
   INSERT INTO dwh_dim_category (SAFE RERUN)
   1.Used the SELECT DISTINCT Clause to return only unique values
   2.Then used the WHERE NOT EXISTS clause to avoid data duplication
   =================================================================== */

INSERT INTO [dwh_brightlearn_sales].[dbo].[dwh_dim_category]
(
        [category]
)


SELECT DISTINCT [category]  

FROM [stg_brightlearn_sales].[dbo].[clean_dim_category] c
WHERE NOT EXISTS
(
    SELECT 1
    FROM [dwh_brightlearn_sales].[dbo].[dwh_dim_category] dwh
    WHERE c.[category] = dwh.[category]
   
);
GO

-----------------------
--View dwh_dim_category
-----------------------

SELECT * FROM [dwh_brightlearn_sales].[dbo].[dwh_dim_category];


