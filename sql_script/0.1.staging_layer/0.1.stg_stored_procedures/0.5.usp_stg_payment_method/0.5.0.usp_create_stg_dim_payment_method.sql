--------------------------------------------------------
--Stored Procedure : Create usp_stg_dim_payment_method SAFE RERUN
--------------------------------------------------------

CREATE OR ALTER PROCEDURE [usp_create_stg_dim_payment_method]
AS
BEGIN
    SET NOCOUNT ON;

/* ================================================================================
   CREATE stg_dim_payment_method Table using the IF NOT EXISTS clause (SAFE RERUN)
   Database : stg_brightlearn_sales
   Schema   : dbo
   ================================================================================*/
IF OBJECT_ID('[stg_brightlearn_sales].[dbo].[stg_dim_payment_method]', 'U') IS NULL
BEGIN

    CREATE TABLE [stg_brightlearn_sales].[dbo].[stg_dim_payment_method] (

        [payment_method_key] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
        [payment_method] VARCHAR (100) NOT NULL,
        [created_date] DATETIME2(0) NOT NULL DEFAULT GETDATE(),
        [modified_date] DATETIME2(0) NOT NULL DEFAULT GETDATE()
    );
END
END;