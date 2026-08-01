--------------------------------
--Checking for distinct location
--------------------------------
SELECT DISTINCT
      [customer_city],
      [customer_province]
      
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data];
 

/* =========================================================================
   CREATE stg_dim_location Table using the IF NOT EXISTS clause (SAFE RERUN)
   Database : stg_brightlearn_sales
   Schema   : dbo
   ========================================================================= */

IF OBJECT_ID('[stg_brightlearn_sales].[dbo].[stg_dim_location]', 'U') IS NULL
BEGIN

    CREATE TABLE [stg_brightlearn_sales].[dbo].[stg_dim_location] (

        [location_key] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
        [customer_city] VARCHAR (100) NOT NULL,
        [customer_province] VARCHAR (100) NOT NULL,
        [created_date] DATETIME2(0) NOT NULL DEFAULT GETDATE(),
        [modified_date] DATETIME2(0) NOT NULL DEFAULT GETDATE()
    );

END;

/* ===================================================================
   INSERT INTO stg_dim_location (SAFE RERUN)
   1.Used the SELECT DISTINCT Clause to return only unique values
   2.Used the COALESCE function to replace the NULLs with the "Unknown"
   3.Then used the WHERE NOT EXISTS clause to avoid data duplication
   =================================================================== */

INSERT INTO [stg_brightlearn_sales].[dbo].[stg_dim_location]
(
     [customer_city]
    ,[customer_province]
)


SELECT DISTINCT
      COALESCE (r.[customer_city],'Unknown'),
      COALESCE (r.[customer_province], 'Unknown')
FROM [stg_brightlearn_sales].[dbo].[brightlearn_raw_data] r
WHERE NOT EXISTS
(
    SELECT 1
    FROM [stg_brightlearn_sales].[dbo].[stg_dim_location] l
    WHERE l.[customer_city] = r.[customer_city]
      AND l.[customer_province] = r.[customer_province]
      
);
GO

-----------------------
--View stg_dim_location
-----------------------

SELECT * FROM [stg_brightlearn_sales].[dbo].[stg_dim_location];


