-----------------------------------------------------------
--Stored Procedure : Create usp_stg_dim_product SAFE RERUN
-----------------------------------------------------------

CREATE OR ALTER PROCEDURE [usp_create_stg_dim_product]
AS
BEGIN
    SET NOCOUNT ON;

/* =========================================================================
   CREATE stg_dim_product Table using the IF NOT EXISTS clause (SAFE RERUN)
   Database : stg_brightlearn_sales
   Schema   : dbo
   ========================================================================= */


IF OBJECT_ID('[stg_brightlearn_sales].[dbo].[stg_dim_product]', 'U') IS NULL
BEGIN

    CREATE TABLE [stg_brightlearn_sales].[dbo].[stg_dim_product] (

        [product_key] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
        [product_name] VARCHAR (100) NOT NULL, 
        [category] VARCHAR (100) NOT NULL,
        [sub_category] VARCHAR (100) NOT NULL,
        [sku] VARCHAR (100) NOT NULL,
        [supplier] VARCHAR (100) NOT NULL,
        [created_date] DATETIME2(0) NOT NULL DEFAULT GETDATE(),
        [modified_date] DATETIME2(0) NOT NULL DEFAULT GETDATE()
    );
END
END;    