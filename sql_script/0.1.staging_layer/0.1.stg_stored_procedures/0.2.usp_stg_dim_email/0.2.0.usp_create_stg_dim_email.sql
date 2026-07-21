-----------------------------------------------------------
--Stored Procedure : Create usp_stg_dim_email SAFE RERUN
-----------------------------------------------------------

CREATE OR ALTER PROCEDURE [usp_create_stg_dim_email]
AS
BEGIN
    SET NOCOUNT ON;

/* =========================================================================
   CREATE stg_dim_email Table using the IF NOT EXISTS clause (SAFE RERUN)
   Database : stg_brightlearn_sales
   Schema   : dbo
   ========================================================================= */

IF OBJECT_ID('[stg_brightlearn_sales].[dbo].[stg_dim_email]', 'U') IS NULL
BEGIN

    CREATE TABLE [stg_brightlearn_sales].[dbo].[stg_dim_email] (

        [customer_email] VARCHAR (100) NULL,
        [created_date] DATETIME2(0) NOT NULL DEFAULT GETDATE(),
        [modified_date] DATETIME2(0) NOT NULL DEFAULT GETDATE()
    );

END;
END