--------------------------------------
--Checking for distinct cashier_name
--------------------------------------
  SELECT DISTINCT [cashier_name]
  FROM [stg_brightlearn_sales].[dbo].[stg_dim_cashier];
  
/* =========================================================================
   CREATE clean_dim_cashier Table using the IF NOT EXISTS clause (SAFE RERUN)
   Database : stg_brightlearn_sales
   Schema   : dbo
   ========================================================================= */

IF OBJECT_ID('[stg_brightlearn_sales].[dbo].[clean_dim_cashier ]', 'U') IS NULL
BEGIN

    CREATE TABLE [stg_brightlearn_sales].[dbo].[clean_dim_cashier] (

        [cashier_key] INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
        [cashier_name] [nvarchar](50) NOT NULL,
        [created_date] DATETIME2(0) NOT NULL DEFAULT GETDATE(),
        [modified_date] DATETIME2(0) NOT NULL DEFAULT GETDATE()
    );

END;

/* ===================================================================
   INSERT INTO clean_dim_cashier (SAFE RERUN)
   1.Used the SELECT DISTINCT Clause to return only unique values
   2.TRIM function to remove unwanted spaces
   3.UPPER fucntion to convert characters to UPPERCASE
   4.Then used the WHERE NOT EXISTS clause to avoid data duplication
   =================================================================== */

INSERT INTO [stg_brightlearn_sales].[dbo].[clean_dim_cashier]
(
        [cashier_name]
)


SELECT DISTINCT TRIM(UPPER(s.[cashier_name])) AS cashier_name

FROM [stg_brightlearn_sales].[dbo].[stg_dim_cashier] s
WHERE NOT EXISTS
(
    SELECT 1
    FROM [stg_brightlearn_sales].[dbo].[clean_dim_cashier] c
    WHERE c.[cashier_name] = s.[cashier_name]
   
);
GO

----------------------
--View clean_dim_cashier 
----------------------

SELECT * FROM [stg_brightlearn_sales].[dbo].[clean_dim_cashier];


