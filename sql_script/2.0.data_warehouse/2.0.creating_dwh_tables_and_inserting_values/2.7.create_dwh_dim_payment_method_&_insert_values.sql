--------------------------------------
--Checking for distinct payment method
--------------------------------------
  SELECT DISTINCT [payment_method]
  FROM [stg_brightlearn_sales].[dbo].[stg_dim_payment_method];

/* =========================================================================
   CREATE clean_dim_payment_method Table using the IF NOT EXISTS clause (SAFE RERUN)
   Database : stg_brightlearn_sales
   Schema   : dbo
   ========================================================================= */
  
IF OBJECT_ID('[stg_brightlearn_sales].[dbo].[clean_dim_payment_method]', 'U') IS NULL
BEGIN

    CREATE TABLE [stg_brightlearn_sales].[dbo].[clean_dim_payment_method] (
        
        [payment_method_key] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
        [payment_method] [nvarchar](50) NOT NULL,
        [created_date] DATETIME2(0) NOT NULL DEFAULT GETDATE(),
        [modified_date] DATETIME2(0) NOT NULL DEFAULT GETDATE()
    );

END;

/* ===================================================================
   INSERT INTO clean_dim_payment_method (SAFE RERUN)
   1.Used the SELECT DISTINCT Clause to return only unique values
   2.Used TRIM to remove unwanted space
   3.Used UPPER fucntion to convert the words in UPPERCASE
   4.Then used the WHERE NOT EXISTS clause to avoid data duplication
   =================================================================== */

INSERT INTO [stg_brightlearn_sales].[dbo].[clean_dim_payment_method]
(
        [payment_method]
)


SELECT DISTINCT TRIM(UPPER(s.[payment_method])) AS payment_method

FROM [stg_brightlearn_sales].[dbo].[stg_dim_payment_method] s
WHERE NOT EXISTS
(
    SELECT 1
    FROM [stg_brightlearn_sales].[dbo].[clean_dim_payment_method] c
    WHERE c.[payment_method] = s.[payment_method]
   
);
GO

-----------------------------
--View stg_clean_payment_method
-----------------------------

SELECT * FROM [stg_brightlearn_sales].[dbo].[clean_dim_payment_method];


