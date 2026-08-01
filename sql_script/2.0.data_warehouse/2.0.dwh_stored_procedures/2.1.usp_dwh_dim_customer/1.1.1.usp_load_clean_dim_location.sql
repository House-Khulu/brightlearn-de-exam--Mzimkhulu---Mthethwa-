/* =======================================================================================
   Stored Procedure : Load Data into the clean_dim_customer INSERT NEW DISTINCT RECORDS ONLY
   ======================================================================================= */

   CREATE OR ALTER PROCEDURE [usp_load_clean_dim_customer]
   AS
   BEGIN
        SET NOCOUNT ON;

/* ================================================================================================
   INSERT INTO clean_dim_customer (SAFE RERUN)
   1.SELECT DISTINCT Clause to return only unique values
   2.COALESCE function to replace the NULLs with the "UNKNOWN"
   3.TRIM fucntion to remove unwanted spaces
   4.UPPER fucntion to Capitalize all the characters
   5.CONVERT fucntion to accomodate the "UNKNOWN" value while using COALESCE from the customer_phone
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

    COALESCE(CONVERT(nvarchar(50), customer_phone),'UNKNOWN') AS customer_phone, 

    COALESCE(TRIM(UPPER(customer_city)),'UNKNOWN') AS customer_city, 
    
    COALESCE(TRIM(UPPER(customer_province)),'UNKNOWN') AS customer_province, 
    
    COALESCE(TRIM(UPPER(customer_loyalty_tier)),'UNKNOWN') AS customer_loyalty_tier   

FROM [stg_brightlearn_sales].[dbo].[stg_dim_customer] 
WHERE NOT EXISTS
(
    SELECT 1
    FROM [stg_brightlearn_sales].[dbo].[clean_dim_customer] c
    WHERE c.[customer_first_name] = COALESCE(TRIM(UPPER(customer_first_name)),'UNKNOWN') 
      AND c.[customer_last_name] = COALESCE(TRIM(UPPER(customer_last_name)),'UNKNOWN') 
      AND c.[customer_phone] = COALESCE(CONVERT(nvarchar(50), customer_phone),'UNKNOWN') 
      AND c.[customer_city] = COALESCE(TRIM(UPPER(customer_city)),'UNKNOWN') 
      AND c.[customer_province] = COALESCE(TRIM(UPPER(customer_province)),'UNKNOWN') 
      AND c.[customer_loyalty_tier] = COALESCE(TRIM(UPPER(customer_loyalty_tier)),'UNKNOWN') 
      
);
END;
GO