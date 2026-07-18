/* ===================================================================================
   Stored Procedure : Load Data into the stg_dim_store INSERT NEW DISTINCT RECORDS ONLY
   ==================================================================================== */

   CREATE OR ALTER PROCEDURE [usp_load_stg_dim_store]
   AS
   BEGIN
        SET NOCOUNT ON;

/* ===================================================================
   INSERT INTO stg_dim_store (SAFE RERUN)
   1.Used the SELECT DISTINCT Clause to return only unique values
   2.Then used the WHERE NOT EXISTS clause to avoid data duplication
   =================================================================== */

INSERT INTO [stg_brightlearn_sales].[dbo].[stg_dim_store]
(
           [cashier_name]
          ,[store_name]
          ,[store_city]
          ,[store_province]
          ,[store_region]
          ,[store_manager]
)


SELECT DISTINCT
           r.[cashier_name],
           r.[store_name],
           r.[store_city],
           r.[store_province],
           r.[store_region],
           r.[store_manager]

FROM [stg_brightlearn_sales].[dbo].[brightlearn_raw_data] r
WHERE NOT EXISTS
(
    SELECT 1
    FROM [stg_brightlearn_sales].[dbo].[stg_dim_store] s
    WHERE s.[cashier_name] = r.[cashier_name]
      AND s.[store_name] = r.[store_name]
      AND s.[store_city] = r.[store_city]
      AND s.[store_province] = r.[store_province]
      AND s.[store_region] = r.[store_region]
      AND s.[store_manager] = r.[store_manager]
      
);
END
GO