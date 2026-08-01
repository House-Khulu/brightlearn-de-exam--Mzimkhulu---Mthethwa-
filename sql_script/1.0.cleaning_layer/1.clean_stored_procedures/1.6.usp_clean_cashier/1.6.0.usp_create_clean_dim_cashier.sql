----------------------------------------------------------
--Stored Procedure : Create usp_clean_dim_cashier SAFE RERUN
----------------------------------------------------------

CREATE OR ALTER PROCEDURE [usp_create_clean_dim_cashier]
AS
BEGIN
    SET NOCOUNT ON;

/* =========================================================================
   CREATE clean_dim_cashierTable using the IF NOT EXISTS clause (SAFE RERUN)
   Database : stg_brightlearn_sales
   Schema   : dbo
   ========================================================================= */

IF OBJECT_ID('[stg_brightlearn_sales].[dbo].[clean_dim_cashier ]', 'U') IS NULL
BEGIN
    CREATE TABLE [stg_brightlearn_sales].[dbo].[clean_dim_cashier] (

        [cashier_key] INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
        [cashier_name] [nvarchar](50) NOT NULL,
        [created_date] DATETIME2(0) NOT NULL DEFAULT GETDATE(),
        [modified_date] DATETIME2(0) NOT NULL DEFAULT GETDATE()
    );

END;
END;