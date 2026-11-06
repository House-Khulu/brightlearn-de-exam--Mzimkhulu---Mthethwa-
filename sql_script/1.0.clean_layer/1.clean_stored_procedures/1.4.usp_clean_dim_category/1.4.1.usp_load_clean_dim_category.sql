/* =======================================================================================
   Stored Procedure : Load Data into the clean_dim_category INSERT NEW DISTINCT RECORDS ONLY
   ======================================================================================= */

   CREATE OR ALTER PROCEDURE [usp_load_clean_dim_category]
   AS
   BEGIN
        SET NOCOUNT ON;

/* ===================================================================
   INSERT INTO clean_dim_category (SAFE RERUN)
   1.Used the SELECT DISTINCT Clause to return only unique values
   2.COALESCE to replace NULL value with "Unknown"
   3.Then used the WHERE NOT EXISTS clause to avoid data duplication
   =================================================================== */

INSERT INTO [stg_brightlearn_sales].[dbo].[clean_dim_category]
(
        [category]
)


SELECT DISTINCT COALESCE(TRIM(UPPER(category)),'UNKNOWN') AS category  

FROM [stg_brightlearn_sales].[dbo].[stg_dim_category] s
WHERE NOT EXISTS
(
    SELECT 1
    FROM [stg_brightlearn_sales].[dbo].[clean_dim_category] c
    WHERE c.[category] = COALESCE(TRIM(UPPER(category)),'UNKNOWN')
   
);
END;
GO

