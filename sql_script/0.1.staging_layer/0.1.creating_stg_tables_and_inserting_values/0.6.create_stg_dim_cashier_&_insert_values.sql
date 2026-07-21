--------------------------------------
--Checking for distinct cashier_name
--------------------------------------
  SELECT DISTINCT [cashier_name]
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data];

/* =========================================================================
   CREATE stg_dim_cashier Table using the IF NOT EXISTS clause (SAFE RERUN)
   Database : stg_brightlearn_sales
   Schema   : dbo
   ========================================================================= */

IF OBJECT_ID('[stg_brightlearn_sales].[dbo].[stg_dim_cashier ]', 'U') IS NULL
BEGIN

    CREATE TABLE [stg_brightlearn_sales].[dbo].[stg_dim_cashier] (

        [cashier_name] [nvarchar](50) NOT NULL,
        [created_date] DATETIME2(0) NOT NULL DEFAULT GETDATE(),
        [modified_date] DATETIME2(0) NOT NULL DEFAULT GETDATE()
    );

END;

/* ===================================================================
   INSERT INTO stg_dim_cashier (SAFE RERUN)
   1.Used the SELECT DISTINCT Clause to return only unique values
   2.Then used the WHERE NOT EXISTS clause to avoid data duplication
   =================================================================== */

INSERT INTO [stg_brightlearn_sales].[dbo].[stg_dim_cashier]
(
        [cashier_name]
)


SELECT DISTINCT r.[cashier_name]

FROM [stg_brightlearn_sales].[dbo].[brightlearn_raw_data] r
WHERE NOT EXISTS
(
    SELECT 1
    FROM [stg_brightlearn_sales].[dbo].[stg_dim_cashier] c
    WHERE c.[cashier_name] = r.[cashier_name]
   
);
GO

----------------------
--View stg_dim_cashier 
----------------------

SELECT * FROM [stg_brightlearn_sales].[dbo].[stg_dim_cashier];


