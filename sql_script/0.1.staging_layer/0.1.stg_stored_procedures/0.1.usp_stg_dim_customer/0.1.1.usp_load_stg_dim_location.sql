/* =======================================================================================
   Stored Procedure : Load Data into the stg_dim_customer INSERT NEW DISTINCT RECORDS ONLY
   ======================================================================================= */

   CREATE OR ALTER PROCEDURE [usp_load_stg_dim_customer]
   AS
   BEGIN
        SET NOCOUNT ON;
   
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
END

