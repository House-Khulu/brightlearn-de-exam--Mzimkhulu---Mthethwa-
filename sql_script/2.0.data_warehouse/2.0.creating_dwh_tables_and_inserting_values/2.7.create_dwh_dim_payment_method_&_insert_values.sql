--------------------------------------
--Checking for distinct payment method
--------------------------------------
  SELECT DISTINCT [payment_method]
  FROM [stg_brightlearn_sales].[dbo].[clean_dim_payment_method];

/* =========================================================================
   CREATE dwh_dim_payment_method Table using the IF NOT EXISTS clause (SAFE RERUN)
   Database : dwh_brightlearn_sales
   Schema   : dbo
   ========================================================================= */
  
IF OBJECT_ID('[dwh_brightlearn_sales].[dbo].[dwh_dim_payment_method]', 'U') IS NULL
BEGIN

    CREATE TABLE [dwh_brightlearn_sales].[dbo].[dwh_dim_payment_method] (
        
        [payment_method_key] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
        [payment_method] [nvarchar](50) NOT NULL,
        [created_date] DATETIME2(0) NOT NULL DEFAULT GETDATE(),
        [modified_date] DATETIME2(0) NOT NULL DEFAULT GETDATE()
    );

END;

/* ===================================================================
   INSERT INTO clean_dim_payment_method (SAFE RERUN)
   1.Used the SELECT DISTINCT Clause to return only unique values
   2.Then used the WHERE NOT EXISTS clause to avoid data duplication
   =================================================================== */

INSERT INTO [dwh_brightlearn_sales].[dbo].[dwh_dim_payment_method]
(
        [payment_method]
)


SELECT DISTINCT c.[payment_method]

FROM [stg_brightlearn_sales].[dbo].[clean_dim_payment_method] c
WHERE NOT EXISTS
(
    SELECT 1
    FROM [dwh_brightlearn_sales].[dbo].[dwh_dim_payment_method] dwh
    WHERE c.[payment_method] = dwh.[payment_method]
   
);
GO

-------------------------
--View dwh_payment_method
-------------------------

SELECT * FROM [dwh_brightlearn_sales].[dbo].[dwh_dim_payment_method];


