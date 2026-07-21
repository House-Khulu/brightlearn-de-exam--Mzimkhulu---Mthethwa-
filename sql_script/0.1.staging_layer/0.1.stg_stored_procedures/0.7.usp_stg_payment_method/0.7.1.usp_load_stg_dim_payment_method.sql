/* ==============================================================================================
   Stored Procedure : Load Data into the stg_dim_payment_method INSERT NEW DISTINCT RECORDS ONLY
   ============================================================================================== */

   CREATE OR ALTER PROCEDURE [usp_load_stg_dim_payment_method]
   AS
   BEGIN
        SET NOCOUNT ON;

/* ===================================================================
   INSERT INTO stg_dim_payment_method (SAFE RERUN)
   1.Used the SELECT DISTINCT Clause to return only unique values
   2.Then used the WHERE NOT EXISTS clause to avoid data duplication
   =================================================================== */
INSERT INTO [stg_brightlearn_sales].[dbo].[stg_dim_payment_method]
(
        [payment_method]
)


SELECT DISTINCT r.[payment_method]

FROM [stg_brightlearn_sales].[dbo].[brightlearn_raw_data] r
WHERE NOT EXISTS
(
    SELECT 1
    FROM [stg_brightlearn_sales].[dbo].[stg_dim_payment_method] p
    WHERE p.[payment_method] = r.[payment_method]
   
);
END;
GO

