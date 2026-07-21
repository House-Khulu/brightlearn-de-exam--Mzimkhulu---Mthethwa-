----------------------------------------
--Checking for distinct stg_dim_customer
---------------------------------------
SELECT DISTINCT
         [customer_first_name],
         [customer_last_name],
         [customer_phone],
         [customer_city],
         [customer_province],
         [customer_loyalty_tier]
  FROM [stg_brightlearn_sales].[dbo].[stg_dim_customer];
 

/* =========================================================================
   CREATE clean_dim_customer Table using the IF NOT EXISTS clause (SAFE RERUN)
   Database : stg_brightlearn_sales
   Schema   : dbo
   ========================================================================= */

IF OBJECT_ID('[stg_brightlearn_sales].[dbo].[clean_dim_customer]', 'U') IS NULL
BEGIN
     CREATE TABLE [stg_brightlearn_sales].[dbo].[clean_dim_customer] (
        
        [customer_key] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
        [customer_first_name] [nvarchar](50) NOT NULL,
        [customer_last_name] [nvarchar](50) NOT NULL,
        [customer_phone] [nvarchar](50) NOT NULL,
        [customer_city] [nvarchar](50) NULL,
	    [customer_province] [nvarchar](50) NULL,
        [customer_loyalty_tier] [nvarchar](50) NULL,
        [created_date] DATETIME2(0) NOT NULL DEFAULT GETDATE(),
        [modified_date] DATETIME2(0) NOT NULL DEFAULT GETDATE()

)
END;

/* ===================================================================
   INSERT INTO clean_dim_customer (SAFE RERUN)
   1.SELECT DISTINCT Clause to return only unique values
   2.COALESCE function to replace the NULLs with the "UNKNOWN"
   3.TRIM fucntion to remove unwanted spaces
   4.UPPER fucntion to Capitalize all the characters
   5.FORMAT fucntion to standardize the phone number
   6.WHERE NOT EXISTS clause to avoid data duplication
   =================================================================== */

INSERT INTO [stg_brightlearn_sales].[dbo].[clean_dim_customer]
(
         [customer_first_name],
         [customer_last_name],
         [customer_phone],
         [customer_city],
         [customer_province],
         [customer_loyalty_tier]
)


SELECT DISTINCT
    COALESCE(TRIM(UPPER(customer_first_name)),'UNKNOWN') AS customer_first_name,

    COALESCE(TRIM(UPPER(customer_last_name)),'UNKNOWN') AS customer_last_name,

    COALESCE(FORMAT(customer_phone, '0##-###-####'),'UNKNOWN') AS customer_phone, 

    COALESCE(TRIM(UPPER(customer_city)),'UNKNOWN') AS customer_city, 
    
    COALESCE(TRIM(UPPER(customer_province)),'UNKNOWN') AS customer_province, 
    
    COALESCE(TRIM(UPPER(customer_loyalty_tier)),'UNKNOWN') AS customer_loyalty_tier   

FROM [stg_brightlearn_sales].[dbo].[stg_dim_customer] d
WHERE NOT EXISTS
(
    SELECT 1
    FROM [stg_brightlearn_sales].[dbo].[clean_dim_customer] c
    WHERE c.[customer_first_name] = d.[customer_first_name]
      AND c.[customer_last_name] = d.[customer_last_name]
      AND c.[customer_phone] = d.[customer_phone]
      AND c.[customer_city] = d.[customer_city]
      AND c.[customer_province] = d.[customer_province]
      AND c.[customer_loyalty_tier] = d.[customer_loyalty_tier]
      
);
GO

--------------------------
--View clean_dim_customer
--------------------------

SELECT * FROM [stg_brightlearn_sales].[dbo].[clean_dim_customer];


  
         