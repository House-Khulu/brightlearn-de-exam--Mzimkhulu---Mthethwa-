/* ==============================================================================================
   Stored Procedure : Load Data into the clean_dim_payment_method INSERT NEW DISTINCT RECORDS ONLY
   ============================================================================================== */

   CREATE OR ALTER PROCEDURE [usp_load_clean_dim_payment_method]
   AS
   BEGIN
        SET NOCOUNT ON;

/* ===================================================================
   INSERT INTO clean_dim_payment_method (SAFE RERUN)
   1.Used the SELECT DISTINCT Clause to return only unique values
   2.Used TRIM to remove unwanted space
   3.Used UPPER fucntion to convert the words in UPPERCASE
   4.Then used the WHERE NOT EXISTS clause to avoid data duplication
   =================================================================== */

INSERT INTO [stg_brightlearn_sales].[dbo].[clean_dim_payment_method]
(
        [payment_method]
)


SELECT DISTINCT TRIM(UPPER(s.[payment_method])) AS payment_method

FROM [stg_brightlearn_sales].[dbo].[stg_dim_payment_method] s
WHERE NOT EXISTS
(
    SELECT 1
    FROM [stg_brightlearn_sales].[dbo].[clean_dim_payment_method] c
    WHERE c.[payment_method] = s.[payment_method]
   
);
END;
GO

