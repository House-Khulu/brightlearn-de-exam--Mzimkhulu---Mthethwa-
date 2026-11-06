/* ========================================================================================
   Stored Procedure : Load Data into the clean_dim_cashier INSERT NEW DISTINCT RECORDS ONLY
   ======================================================================================== */

   CREATE OR ALTER PROCEDURE [usp_load_clean_dim_cashier]
   AS
   BEGIN
        SET NOCOUNT ON;
/* ===================================================================
   INSERT INTO clean_dim_cashier (SAFE RERUN)
   1.Used the SELECT DISTINCT Clause to return only unique values
   2.TRIM function to remove unwanted spaces
   3.UPPER fucntion to convert characters to UPPERCASE
   4.Then used the WHERE NOT EXISTS clause to avoid data duplication
   =================================================================== */

INSERT INTO [stg_brightlearn_sales].[dbo].[clean_dim_cashier]
(
        [cashier_name]
)


SELECT DISTINCT TRIM(UPPER(s.[cashier_name])) AS cashier_name

FROM [stg_brightlearn_sales].[dbo].[stg_dim_cashier] s
WHERE NOT EXISTS
(
    SELECT 1
    FROM [stg_brightlearn_sales].[dbo].[clean_dim_cashier] c
    WHERE c.[cashier_name] = s.[cashier_name]
   
);
END;
GO
