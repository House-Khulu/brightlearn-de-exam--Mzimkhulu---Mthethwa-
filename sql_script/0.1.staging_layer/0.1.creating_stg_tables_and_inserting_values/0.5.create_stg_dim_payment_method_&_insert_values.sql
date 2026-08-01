--------------------------------------
--Checking for distinct payment method
--------------------------------------
  SELECT DISTINCT [payment_method]
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data];

/* =========================================================================
   CREATE stg_dim_payment_method Table using the IF NOT EXISTS clause (SAFE RERUN)
   Database : stg_brightlearn_sales
   Schema   : dbo
   ========================================================================= */

IF OBJECT_ID('[stg_brightlearn_sales].[dbo].[stg_dim_payment_method]', 'U') IS NULL
BEGIN

    CREATE TABLE [stg_brightlearn_sales].[dbo].[stg_dim_payment_method] (

        [payment_method_key] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
        [payment_method] VARCHAR (100) NOT NULL,
        [created_date] DATETIME2(0) NOT NULL DEFAULT GETDATE(),
        [modified_date] DATETIME2(0) NOT NULL DEFAULT GETDATE()
    );

END;

/* ===================================================================
   INSERT INTO stg_dim_payment_method (SAFE RERUN)
   1.Used the SELECT DISTINCT Clause to return only unique values
   2.Then used the WHERE NOT EXISTS clause to avoid data duplication
   =================================================================== */

INSERT INTO [stg_brightlearn_sales].[dbo].[stg_dim_payment_method]
(
        [payment_method]
)


SELECT DISTINCT r.[payment_method]

FROM [stg_brightlearn_sales].[dbo].[brightlearn_raw_data] r
WHERE NOT EXISTS
(
    SELECT 1
    FROM [stg_brightlearn_sales].[dbo].[stg_dim_payment_method] p
    WHERE p.[payment_method] = r.[payment_method]
   
);
GO

-----------------------------
--View stg_dim_payment_method
-----------------------------

SELECT * FROM [stg_brightlearn_sales].[dbo].[stg_dim_payment_method];


