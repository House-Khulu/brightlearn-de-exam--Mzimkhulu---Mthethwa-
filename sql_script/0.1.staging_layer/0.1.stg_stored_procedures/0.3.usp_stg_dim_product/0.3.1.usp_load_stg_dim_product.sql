/* =======================================================================================
   Stored Procedure : Load Data into the stg_dim_product INSERT NEW DISTINCT RECORDS ONLY
   ======================================================================================= */

   CREATE OR ALTER PROCEDURE [usp_load_stg_dim_product]
   AS
   BEGIN
        SET NOCOUNT ON;

/* ===================================================================
   INSERT INTO stg_dim_product (SAFE RERUN)
   1.Used the SELECT DISTINCT Clause to return only unique values
   2.Used the COALESCE function to replace the NULLs with the "Unknown"
   3.Then used the WHERE NOT EXISTS clause to avoid data duplication
   =================================================================== */

INSERT INTO [stg_brightlearn_sales].[dbo].[stg_dim_product]
(
          [product_name]
         ,[sub_category]
         ,[sku]
         ,[supplier]
)

SELECT DISTINCT
           r.[product_name],
           r.[sub_category],
           r.[sku],
           r.[supplier]

FROM [stg_brightlearn_sales].[dbo].[brightlearn_raw_data] r
WHERE NOT EXISTS
(
    SELECT 1
    FROM [stg_brightlearn_sales].[dbo].[stg_dim_product] p
    WHERE p.[product_name] = r.[product_name]
      AND p.[sub_category] = r.[sub_category]
      AND p.[sku] = r.[sku]
      AND p.[supplier] = r.[supplier]
      
);
END
GO