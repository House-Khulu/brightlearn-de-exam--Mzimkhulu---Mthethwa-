--------------------------------
--Checking for distinct customer
--------------------------------
SELECT DISTINCT
         [customer_first_name]
        ,[customer_last_name]
        ,[customer_email]
        ,[customer_phone]
         [customer_loyalty_tier]
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data];
 

/* =========================================================================
   CREATE stg_dim_location Table using the IF NOT EXISTS clause (SAFE RERUN)
   Database : stg_brightlearn_sales
   Schema   : dbo
   ========================================================================= */

IF OBJECT_ID('[stg_brightlearn_sales].[dbo].[stg_dim_customer]', 'U') IS NULL
BEGIN

    CREATE TABLE [stg_brightlearn_sales].[dbo].[stg_dim_customer] (

        [customer_key] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
        [customer_first_name] VARCHAR (100) NOT NULL,
        [customer_last_name] VARCHAR (100) NOT NULL,
        [customer_email] VARCHAR (100) NOT NULL,
        [customer_phone] INT,
        [customer_loyalty_tier] VARCHAR (100) NOT NULL,
        [created_date] DATETIME2(0) NOT NULL DEFAULT GETDATE(),
        [modified_date] DATETIME2(0) NOT NULL DEFAULT GETDATE()
    );

END;

/* ===================================================================
   INSERT INTO stg_dim_customer (SAFE RERUN)
   1.Used the SELECT DISTINCT Clause to return only unique values
   2.Used the COALESCE function to replace the NULLs with the "Unknown"
   for VARCHAR and "0" for INT data type
   3.Then used the WHERE NOT EXISTS clause to avoid data duplication
   =================================================================== */

INSERT INTO [stg_brightlearn_sales].[dbo].[stg_dim_customer]
(
         [customer_first_name],
         [customer_last_name],
         [customer_email],
         [customer_phone],
         [customer_loyalty_tier]
)

SELECT DISTINCT
      COALESCE (r.[customer_first_name],'Unknown'),
      COALESCE (r.[customer_last_name], 'Unknown'),
      COALESCE (r.[customer_email], 'Unknown'),
      COALESCE (r.[customer_phone], '0'),
      COALESCE (r.[customer_loyalty_tier], 'Unknown')

FROM [stg_brightlearn_sales].[dbo].[brightlearn_raw_data] r
WHERE NOT EXISTS
(
    SELECT 1
    FROM [stg_brightlearn_sales].[dbo].[stg_dim_customer] c
    WHERE c.[customer_first_name] = r.[customer_first_name]
      AND c.[customer_last_name] = r.[customer_last_name]
      AND c.[customer_email] = r.[customer_email]
      AND c.[customer_phone] = r.[customer_phone]
      AND c.[customer_loyalty_tier] = r.[customer_loyalty_tier]
      
);
GO

-----------------------
--View stg_dim_customer
-----------------------

SELECT * FROM [stg_brightlearn_sales].[dbo].[stg_dim_customer];



