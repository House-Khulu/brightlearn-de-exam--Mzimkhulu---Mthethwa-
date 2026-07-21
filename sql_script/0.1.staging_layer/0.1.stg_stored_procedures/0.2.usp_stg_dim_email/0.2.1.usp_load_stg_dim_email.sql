/* ====================================================================================
   Stored Procedure : Load Data into the stg_dim_email INSERT NEW DISTINCT RECORDS ONLY
   ==================================================================================== */

CREATE OR ALTER PROCEDURE [usp_load_stg_dim_email]
AS
BEGIN
    SET NOCOUNT ON;

/* ===================================================================
   INSERT INTO stg_dim_email (SAFE RERUN)
   1.Used the SELECT DISTINCT Clause to return only unique values
   2.Then used the WHERE NOT EXISTS clause to avoid data duplication
   =================================================================== */

INSERT INTO [stg_brightlearn_sales].[dbo].[stg_dim_email]
(
        [customer_email]
)

SELECT DISTINCT
         r.[customer_email]
        
FROM [stg_brightlearn_sales].[dbo].[brightlearn_raw_data] r
WHERE NOT EXISTS
(
    SELECT 1
    FROM [stg_brightlearn_sales].[dbo].[stg_dim_email] e
    WHERE e.[customer_email] = r.[customer_email]
      
);
END
GO
