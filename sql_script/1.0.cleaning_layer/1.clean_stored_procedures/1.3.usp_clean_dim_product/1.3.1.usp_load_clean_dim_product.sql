/* =======================================================================================
   Stored Procedure : Load Data into the clean_dim_product INSERT NEW DISTINCT RECORDS ONLY
   ======================================================================================= */

   CREATE OR ALTER PROCEDURE [usp_load_clean_dim_product]
   AS
   BEGIN
        SET NOCOUNT ON;

/* ===================================================================
   INSERT INTO clean_dim_product (SAFE RERUN)
   1.SELECT DISTINCT Clause to return only unique values
   2.TRIM fucntion to remove unwanted spaces
   3.WHERE NOT EXISTS clause to avoid data duplication
   =================================================================== */

INSERT INTO [stg_brightlearn_sales].[dbo].[clean_dim_product]
(
          [product_name]
         ,[sub_category]
         ,[sku]
         ,[supplier]
)

SELECT DISTINCT
           TRIM(UPPER(r.[product_name])) AS product_name,
           TRIM(UPPER(r.[sub_category])) AS sub_category,
           TRIM(UPPER(r.[sku])) AS SKU,
           TRIM(UPPER(r.[supplier])) AS supplier

FROM [stg_brightlearn_sales].[dbo].[stg_dim_product] r
WHERE NOT EXISTS
(
    SELECT 1
    FROM [stg_brightlearn_sales].[dbo].[clean_dim_product] p
    WHERE p.[product_name] = r.[product_name]
      AND p.[sub_category] = r.[sub_category]
      AND p.[sku] = r.[sku]
      AND p.[supplier] = r.[supplier]
      
);
END;
GO