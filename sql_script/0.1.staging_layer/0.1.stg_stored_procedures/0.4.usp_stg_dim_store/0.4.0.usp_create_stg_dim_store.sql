--------------------------------------------------------
--Stored Procedure : Create usp_stg_dim_store SAFE RERUN
--------------------------------------------------------

CREATE OR ALTER PROCEDURE [usp_create_stg_dim_store]
AS
BEGIN
    SET NOCOUNT ON;

/* =========================================================================
   CREATE stg_dim_store Table using the IF NOT EXISTS clause (SAFE RERUN)
   Database : stg_brightlearn_sales
   Schema   : dbo
   ========================================================================= */

IF OBJECT_ID('[stg_brightlearn_sales].[dbo].[stg_dim_store]', 'U') IS NULL
BEGIN

    CREATE TABLE [stg_brightlearn_sales].[dbo].[stg_dim_store] (

        [store_key] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
        [cashier_name] VARCHAR (100) NOT NULL, 
        [store_name] VARCHAR (100) NOT NULL,
        [store_city] VARCHAR (100) NOT NULL,
        [store_province] VARCHAR (100) NOT NULL,
        [store_region] VARCHAR (100) NOT NULL,
        [store_manager] VARCHAR (100) NOT NULL,
        [created_date] DATETIME2(0) NOT NULL DEFAULT GETDATE(),
        [modified_date] DATETIME2(0) NOT NULL DEFAULT GETDATE()
    );
END
END;