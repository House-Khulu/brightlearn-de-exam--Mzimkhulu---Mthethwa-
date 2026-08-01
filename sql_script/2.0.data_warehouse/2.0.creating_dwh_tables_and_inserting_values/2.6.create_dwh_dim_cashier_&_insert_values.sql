--------------------------------------
--Checking for distinct cashier_name
--------------------------------------
  SELECT DISTINCT [cashier_name]
  FROM [stg_brightlearn_sales].[dbo].[clean_dim_cashier];
  
/* =========================================================================
   CREATE dwh_dim_cashier Table using the IF NOT EXISTS clause (SAFE RERUN)
   Database : dwh_brightlearn_sales
   Schema   : dbo
   ========================================================================= */

IF OBJECT_ID('[dwh_brightlearn_sales].[dbo].[dwh_dim_cashier ]', 'U') IS NULL
BEGIN

    CREATE TABLE [dwh_brightlearn_sales].[dbo].[dwh_dim_cashier] (

        [cashier_key] INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
        [cashier_name] [nvarchar](50) NOT NULL,
        [created_date] DATETIME2(0) NOT NULL DEFAULT GETDATE(),
        [modified_date] DATETIME2(0) NOT NULL DEFAULT GETDATE()
    );

END;

/* ===================================================================
   INSERT INTO clean_dim_cashier (SAFE RERUN)
   1.Used the SELECT DISTINCT Clause to return only unique values
   2.Then used the WHERE NOT EXISTS clause to avoid data duplication
   =================================================================== */

INSERT INTO [dwh_brightlearn_sales].[dbo].[dwh_dim_cashier]
(
        [cashier_name]
)


SELECT DISTINCT 
        c.[cashier_name]

FROM [stg_brightlearn_sales].[dbo].[clean_dim_cashier] c
WHERE NOT EXISTS
(
    SELECT 1
    FROM [dwh_brightlearn_sales].[dbo].[dwh_dim_cashier] dwh
    WHERE c.[cashier_name] = dwh.[cashier_name]
   
);
GO

----------------------
--View dwh_dim_cashier 
----------------------

SELECT * FROM [dwh_brightlearn_sales].[dbo].[dwh_dim_cashier];


