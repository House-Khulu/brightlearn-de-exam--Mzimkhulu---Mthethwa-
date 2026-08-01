--------------------------------
--Checking for distinct category
--------------------------------
  SELECT DISTINCT [category]
  FROM [stg_brightlearn_sales].[dbo].[stg_dim_category];

/* =========================================================================
   CREATE clean_dim_category Table using the IF NOT EXISTS clause (SAFE RERUN)
   Database : stg_brightlearn_sales
   Schema   : dbo
   ========================================================================= */

IF OBJECT_ID('[stg_brightlearn_sales].[dbo].[clean_dim_category]', 'U') IS NULL
BEGIN

    CREATE TABLE [stg_brightlearn_sales].[dbo].[clean_dim_category] (
        [category_key] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
        [category] [nvarchar](50) NOT NULL,
        [created_date] DATETIME2(0) NOT NULL DEFAULT GETDATE(),
        [modified_date] DATETIME2(0) NOT NULL DEFAULT GETDATE()
    );

END;

/* ===================================================================
   INSERT INTO clean_dim_category (SAFE RERUN)
   1.Used the SELECT DISTINCT Clause to return only unique values
   2.COALESCE to replace NULL value with "Unknown"
   3.Then used the WHERE NOT EXISTS clause to avoid data duplication
   =================================================================== */

INSERT INTO [stg_brightlearn_sales].[dbo].[clean_dim_category]
(
        [category]
)


SELECT DISTINCT COALESCE(TRIM(UPPER(category)),'UNKNOWN') AS category  

FROM [stg_brightlearn_sales].[dbo].[stg_dim_category] s
WHERE NOT EXISTS
(
    SELECT 1
    FROM [stg_brightlearn_sales].[dbo].[clean_dim_category] c
    WHERE c.[category] = s.[category]
   
);
GO

-----------------------
--View clean_dim_category
-----------------------

SELECT * FROM [stg_brightlearn_sales].[dbo].[clean_dim_category];


