--------------------------------
--Checking for distinct email
--------------------------------
SELECT DISTINCT
       [customer_email]
  FROM [stg_brightlearn_sales].[dbo].[clean_dim_email];
 

/* =========================================================================
   CREATE dwh_dim_email Table using the IF NOT EXISTS clause (SAFE RERUN)
   Database : dwh_brightlearn_sales
   Schema   : dbo
   ========================================================================= */

IF OBJECT_ID('[dwh_brightlearn_sales].[dbo].[dwh_dim_email]', 'U') IS NULL
BEGIN

    CREATE TABLE [dwh_brightlearn_sales].[dbo].[dwh_dim_email] (

        [email_key] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
        [customer_email] [nvarchar](50) NOT NULL,
        [created_date] DATETIME2(0) NOT NULL DEFAULT GETDATE(),
        [modified_date] DATETIME2(0) NOT NULL DEFAULT GETDATE()
    );

END;

/* ===================================================================
   INSERT INTO dwh_dim_email (SAFE RERUN)
   1.Used the SELECT DISTINCT Clause to return only unique values
   2.Then used the WHERE NOT EXISTS clause to avoid data duplication
   =================================================================== */

INSERT INTO [dwh_brightlearn_sales].[dbo].[dwh_dim_email]
(
        [customer_email]
)

SELECT DISTINCT
         [customer_email] 
        
FROM [stg_brightlearn_sales].[dbo].[clean_dim_email] c
WHERE NOT EXISTS
(
    SELECT 1
    FROM [dwh_brightlearn_sales].[dbo].[dwh_dim_email] dwh
    WHERE dwh.[customer_email] = c.[customer_email]
      
);
GO

-----------------------
--View dwh_dim_email
-----------------------

SELECT * FROM [dwh_brightlearn_sales].[dbo].[dwh_dim_email];