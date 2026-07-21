/* =======================================================================================
   Stored Procedure : Load Data into the stg_dim_category INSERT NEW DISTINCT RECORDS ONLY
   ======================================================================================= */

   CREATE OR ALTER PROCEDURE [usp_load_stg_dim_category]
   AS
   BEGIN
        SET NOCOUNT ON;

/* ===================================================================
   INSERT INTO stg_dim_category (SAFE RERUN)
   1.Used the SELECT DISTINCT Clause to return only unique values
   2.Then used the WHERE NOT EXISTS clause to avoid data duplication
   =================================================================== */


INSERT INTO [stg_brightlearn_sales].[dbo].[stg_dim_category]
(
        [category]
)


SELECT DISTINCT r.[category]

FROM [stg_brightlearn_sales].[dbo].[brightlearn_raw_data] r
WHERE NOT EXISTS
(
    SELECT 1
    FROM [stg_brightlearn_sales].[dbo].[stg_dim_category] c
    WHERE c.[category] = r.[category]
   
);
END;
GO

