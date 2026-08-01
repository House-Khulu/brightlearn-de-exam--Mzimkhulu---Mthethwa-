/* ===================================================================================
   Stored Procedure : Load Data into the clean_dim_store INSERT NEW DISTINCT RECORDS ONLY
   ==================================================================================== */

   CREATE OR ALTER PROCEDURE [usp_load_clean_dim_store]
   AS
   BEGIN
        SET NOCOUNT ON;

/* ===================================================================
   INSERT INTO clean_dim_store (SAFE RERUN)
   1.Used the SELECT DISTINCT Clause to return only unique values
   2.Then used the WHERE NOT EXISTS clause to avoid data duplication
   =================================================================== */

INSERT INTO [stg_brightlearn_sales].[dbo].[clean_dim_store]
(
           [store_name]
          ,[store_city]
          ,[store_province]
          ,[store_region]
          ,[store_manager]
)


SELECT DISTINCT
           TRIM(UPPER(s.[store_name])) AS store_name,
           TRIM(UPPER(s.[store_city])) AS store_city,
           TRIM(UPPER(s.[store_province])) AS store_province,
           TRIM(UPPER(s.[store_region])) AS store_region,
           TRIM(UPPER(s.[store_manager])) AS store_manager

FROM [stg_brightlearn_sales].[dbo].[stg_dim_store] s
WHERE NOT EXISTS
(
    SELECT 1
    FROM [stg_brightlearn_sales].[dbo].[clean_dim_store] c
    WHERE s.[store_name] = c.[store_name]
      AND s.[store_city] = c.[store_city]
      AND s.[store_province] = c.[store_province]
      AND s.[store_region] = c.[store_region]
      AND s.[store_manager] = c.[store_manager]
      
);
END;
GO