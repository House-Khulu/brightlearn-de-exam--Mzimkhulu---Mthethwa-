/* ====================================================================================
   Stored Procedure : Load Data into the clean_dim_email INSERT NEW DISTINCT RECORDS ONLY
   ==================================================================================== */

CREATE OR ALTER PROCEDURE [usp_load_clean_dim_email]
AS
BEGIN
    SET NOCOUNT ON;

/* ===================================================================
   INSERT INTO stg_dim_email (SAFE RERUN)
   1.Used the SELECT DISTINCT Clause to return only unique values
   2.WHERE NOT EXISTS clause to avoid data duplication
   3.TRIM fucntion to remove unwanted spaces
   =================================================================== */

INSERT INTO [stg_brightlearn_sales].[dbo].[clean_dim_email]
(
        [customer_email]
)

SELECT DISTINCT
         COALESCE(TRIM(customer_email),'UNKNOWN') AS customer_email 
        
FROM [stg_brightlearn_sales].[dbo].[stg_dim_email] e
WHERE NOT EXISTS
(
    SELECT 1
    FROM [stg_brightlearn_sales].[dbo].[clean_dim_email] c
    WHERE c.[customer_email] = COALESCE(TRIM(customer_email),'UNKNOWN')
      
);
END;
GO
