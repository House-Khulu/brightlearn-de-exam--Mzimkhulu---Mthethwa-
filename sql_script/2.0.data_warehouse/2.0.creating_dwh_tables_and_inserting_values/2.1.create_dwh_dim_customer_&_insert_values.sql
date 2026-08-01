----------------------------------------
--Checking for distinct clean_dim_customer
---------------------------------------
SELECT DISTINCT
         [customer_first_name],
         [customer_last_name],
         [customer_phone],
         [customer_city],
         [customer_province],
         [customer_loyalty_tier]
  FROM [stg_brightlearn_sales].[dbo].[clean_dim_customer];
 

/* =========================================================================
   CREATE dwh_dim_customer Table using the IF NOT EXISTS clause (SAFE RERUN)
   Database : dwh_brightlearn_sales
   Schema   : dbo
   ========================================================================= */

IF OBJECT_ID('[dwh_brightlearn_sales].[dbo].[dwh_dim_customer]', 'U') IS NULL
BEGIN
     CREATE TABLE [dwh_brightlearn_sales].[dbo].[dwh_dim_customer] (
        
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
   INSERT INTO dwh_dim_customer (SAFE RERUN)
   1.SELECT DISTINCT Clause to return only unique values
   2.COALESCE function to replace the NULLs with the "UNKNOWN"
   3.FORMAT fucntion to standardize the phone number
   4.WHERE NOT EXISTS clause to avoid data duplication
   =================================================================== */
INSERT INTO [dwh_brightlearn_sales].[dbo].[dwh_dim_customer]
(
            [customer_first_name],
            [customer_last_name],
            [customer_phone],
            [customer_city],
            [customer_province],
            [customer_loyalty_tier]
)

SELECT DISTINCT 
     [customer_first_name],
     [customer_last_name],
     COALESCE(FORMAT(TRY_CONVERT(bigint, [customer_phone]), '0## ### ####'),'UNKNOWN') AS customer_phone,
     [customer_city],
     [customer_province],
     [customer_loyalty_tier]
FROM [stg_brightlearn_sales].[dbo].[clean_dim_customer] c
WHERE NOT EXISTS
(
    SELECT 1
    FROM [dwh_brightlearn_sales].[dbo].[dwh_dim_customer] dwh
    WHERE c.[customer_first_name] = dwh.customer_first_name 
      AND c.[customer_last_name] = dwh.customer_last_name
      AND c.[customer_phone] = COALESCE(FORMAT(TRY_CONVERT(bigint, [customer_phone]), '0## ### ####'),'UNKNOWN')
      AND c.[customer_city] = dwh.customer_city
      AND c.[customer_province] = dwh.customer_province 
      AND c.[customer_loyalty_tier] = dwh.customer_loyalty_tier
      
);

--------------------------
--View dwh_dim_customer
--------------------------

SELECT * FROM [dwh_brightlearn_sales].[dbo].[dwh_dim_customer];


  
         