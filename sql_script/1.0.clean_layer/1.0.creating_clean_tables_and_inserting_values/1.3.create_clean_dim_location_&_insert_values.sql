--------------------------------
--Checking for distinct location
--------------------------------
SELECT DISTINCT
      [customer_city],
      [customer_province]
      
  FROM [stg_brightlearn_sales].[dbo].[stg_dim_location];
 

/* =========================================================================
   CREATE clean_dim_location Table using the IF NOT EXISTS clause (SAFE RERUN)
   Database : stg_brightlearn_sales
   Schema   : dbo
   ========================================================================= */

IF OBJECT_ID('[stg_brightlearn_sales].[dbo].[clean_dim_location]', 'U') IS NULL
BEGIN

    CREATE TABLE [stg_brightlearn_sales].[dbo].[clean_dim_location] (

        [customer_city] VARCHAR (100),
        [customer_province] VARCHAR (100),
        [created_date] DATETIME2(0) NOT NULL DEFAULT GETDATE(),
        [modified_date] DATETIME2(0) NOT NULL DEFAULT GETDATE()
    );

END;

/* ===================================================================
   INSERT INTO clean_dim_location (SAFE RERUN)
   1.Used the SELECT DISTINCT Clause to return only unique values
   2.Used the COALESCE function to replace the NULLs with the "Unknown"
   3.Then used the WHERE NOT EXISTS clause to avoid data duplication
   =================================================================== */

WITH cleaned_location AS (

    
    SELECT DISTINCT
           COALESCE(TRIM(UPPER(customer_city)),'UNKNOWN') AS customer_city,

           COALESCE(TRIM(UPPER(customer_province)),'UNKNOWN') AS customer_province

    FROM [stg_brightlearn_sales].[dbo].[stg_dim_location] 
)


INSERT INTO [stg_brightlearn_sales].[dbo].[clean_dim_location]
(
     [customer_city]
    ,[customer_province]
)

-- From the CTE query
SELECT * FROM cleaned_location c

WHERE NOT EXISTS
(
    SELECT 1
    FROM [stg_brightlearn_sales].[dbo].[clean_dim_location] l
    WHERE l.[customer_city] = [customer_city]
      AND l.[customer_province] = [customer_province] 
      
);
GO

-----------------------
--View stg_dim_location
-----------------------

SELECT * FROM [stg_brightlearn_sales].[dbo].[clean_dim_location];




