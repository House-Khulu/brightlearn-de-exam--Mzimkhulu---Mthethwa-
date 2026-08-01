--------------------------------
--Checking for distinct email
--------------------------------
SELECT DISTINCT
       [customer_email]
  FROM [stg_brightlearn_sales].[dbo].[stg_dim_email];
 

/* =========================================================================
   CREATE clean_dim_email Table using the IF NOT EXISTS clause (SAFE RERUN)
   Database : stg_brightlearn_sales
   Schema   : dbo
   ========================================================================= */

IF OBJECT_ID('[stg_brightlearn_sales].[dbo].[clean_dim_email]', 'U') IS NULL
BEGIN

    CREATE TABLE [stg_brightlearn_sales].[dbo].[clean_dim_email] (

        [email_key] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
        [customer_email] [nvarchar](50) NOT NULL,
        [created_date] DATETIME2(0) NOT NULL DEFAULT GETDATE(),
        [modified_date] DATETIME2(0) NOT NULL DEFAULT GETDATE()
    );

END;

/* ===================================================================
   INSERT INTO clean_dim_email (SAFE RERUN)
   1.Used the SELECT DISTINCT Clause to return only unique values
   2.Then used the WHERE NOT EXISTS clause to avoid data duplication
   =================================================================== */

INSERT INTO [stg_brightlearn_sales].[dbo].[clean_dim_email]
(
        [customer_email]
)

SELECT DISTINCT
         COALESCE(TRIM(customer_email),'Unknown') AS customer_email 
        
FROM [stg_brightlearn_sales].[dbo].[stg_dim_email] e
WHERE NOT EXISTS
(
    SELECT 1
    FROM [stg_brightlearn_sales].[dbo].[clean_dim_email] c
    WHERE e.[customer_email] = c.[customer_email]
      
);
GO

-----------------------
--View clean_dim_email
-----------------------

SELECT * FROM [stg_brightlearn_sales].[dbo].[clean_dim_email];