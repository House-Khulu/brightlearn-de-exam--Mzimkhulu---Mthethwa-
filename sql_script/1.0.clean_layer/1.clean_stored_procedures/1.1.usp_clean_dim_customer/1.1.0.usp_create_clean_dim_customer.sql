-----------------------------------------------------------
--Stored Procedure : Create usp_clean_dim_customer SAFE RERUN
-----------------------------------------------------------

CREATE OR ALTER PROCEDURE [usp_create_clean_dim_customer]
AS
BEGIN
    SET NOCOUNT ON;

/* =========================================================================
   CREATE clean_dim_customer Table using the IF NOT EXISTS clause (SAFE RERUN)
   Database : stg_brightlearn_sales
   Schema   : dbo
   ========================================================================= */
IF OBJECT_ID('[stg_brightlearn_sales].[dbo].[clean_dim_customer]', 'U') IS NULL
BEGIN

     CREATE TABLE [stg_brightlearn_sales].[dbo].[clean_dim_customer] (
        
        [customer_key] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
        [customer_first_name] [nvarchar](50) NOT NULL,
        [customer_last_name] [nvarchar](50) NOT NULL,
        [customer_phone] [nvarchar](50) NOT NULL,
        [customer_city] [nvarchar](50) NULL,
	    [customer_province] [nvarchar](50) NULL,
        [customer_loyalty_tier] [nvarchar](50) NULL,
        [created_date] DATETIME2(0) NOT NULL DEFAULT GETDATE(),
        [modified_date] DATETIME2(0) NOT NULL DEFAULT GETDATE()

)
END;
END