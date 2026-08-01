-----------------------------
--Checking for distinct store
-----------------------------
 SELECT DISTINCT 
        [store_name]
       ,[store_city]
       ,[store_province]
       ,[store_region]
       ,[store_manager]
  FROM [stg_brightlearn_sales].[dbo].[clean_dim_store];

/* =========================================================================
   CREATE dwh_dim_store Table using the IF NOT EXISTS clause (SAFE RERUN)
   Database : dwh_brightlearn_sales
   Schema   : dbo
   ========================================================================= */

IF OBJECT_ID('[dwh_brightlearn_sales].[dbo].[dwh_dim_store]', 'U') IS NULL
BEGIN

    CREATE TABLE [dwh_brightlearn_sales].[dbo].[dwh_dim_store] (

        [store_key] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
        [store_name] [nvarchar](50) NOT NULL,
	    [store_city] [nvarchar](50) NOT NULL,
	    [store_province] [nvarchar](50) NOT NULL,
	    [store_region] [nvarchar](50) NOT NULL,
	    [store_manager] [nvarchar](50) NOT NULL,
        [created_date] DATETIME2(0) NOT NULL DEFAULT GETDATE(),
        [modified_date] DATETIME2(0) NOT NULL DEFAULT GETDATE()
    );

END;

/* ===================================================================
   INSERT INTO dwh_dim_store (SAFE RERUN)
   1.Used the SELECT DISTINCT Clause to return only unique values
   2.Then used the WHERE NOT EXISTS clause to avoid data duplication
   =================================================================== */

INSERT INTO [dwh_brightlearn_sales].[dbo].[dwh_dim_store]
(
           [store_name]
          ,[store_city]
          ,[store_province]
          ,[store_region]
          ,[store_manager]
)


SELECT DISTINCT
           c.[store_name],
           c.[store_city],
           c.[store_province],
           c.[store_region],
           c.[store_manager]

FROM [stg_brightlearn_sales].[dbo].[clean_dim_store] c
WHERE NOT EXISTS
(
    SELECT 1
    FROM [dwh_brightlearn_sales].[dbo].[dwh_dim_store] dwh
    WHERE dwh.[store_name] = c.[store_name]
      AND dwh.[store_city] = c.[store_city]
      AND dwh.[store_province] = c.[store_province]
      AND dwh.[store_region] = c.[store_region]
      AND dwh.[store_manager] = c.[store_manager]
      
);
GO

--------------------
--View dwh_dim_store
--------------------

SELECT * FROM [dwh_brightlearn_sales].[dbo].[dwh_dim_store];



