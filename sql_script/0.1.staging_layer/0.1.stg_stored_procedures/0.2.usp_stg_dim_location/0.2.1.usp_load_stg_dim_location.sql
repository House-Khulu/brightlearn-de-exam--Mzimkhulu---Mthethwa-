/* =======================================================================================
   Stored Procedure : Load Data into the stg_dim_location INSERT NEW DISTINCT RECORDS ONLY
   ======================================================================================= */

   CREATE OR ALTER PROCEDURE [usp_load_stg_dim_location]
   AS
   BEGIN
        SET NOCOUNT ON;

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
END
GO
