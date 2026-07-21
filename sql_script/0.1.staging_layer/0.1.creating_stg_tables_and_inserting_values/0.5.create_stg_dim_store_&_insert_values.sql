-----------------------------
--Checking for distinct store
-----------------------------
 SELECT DISTINCT 
        [store_name]
       ,[store_city]
       ,[store_province]
       ,[store_region]
       ,[store_manager]
  FROM [stg_brightlearn_sales].[dbo].[brightLearn_raw_data];

/* =========================================================================
   CREATE stg_dim_store Table using the IF NOT EXISTS clause (SAFE RERUN)
   Database : stg_brightlearn_sales
   Schema   : dbo
   ========================================================================= */

IF OBJECT_ID('[stg_brightlearn_sales].[dbo].[stg_dim_store]', 'U') IS NULL
BEGIN

    CREATE TABLE [stg_brightlearn_sales].[dbo].[stg_dim_store] (

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
   INSERT INTO stg_dim_store (SAFE RERUN)
   1.Used the SELECT DISTINCT Clause to return only unique values
   2.Then used the WHERE NOT EXISTS clause to avoid data duplication
   =================================================================== */

INSERT INTO [stg_brightlearn_sales].[dbo].[stg_dim_store]
(
           [store_name]
          ,[store_city]
          ,[store_province]
          ,[store_region]
          ,[store_manager]
)


SELECT DISTINCT
           r.[store_name],
           r.[store_city],
           r.[store_province],
           r.[store_region],
           r.[store_manager]

FROM [stg_brightlearn_sales].[dbo].[brightlearn_raw_data] r
WHERE NOT EXISTS
(
    SELECT 1
    FROM [stg_brightlearn_sales].[dbo].[stg_dim_store] s
    WHERE s.[store_name] = r.[store_name]
      AND s.[store_city] = r.[store_city]
      AND s.[store_province] = r.[store_province]
      AND s.[store_region] = r.[store_region]
      AND s.[store_manager] = r.[store_manager]
      
);
GO

--------------------
--View stg_dim_store
--------------------

SELECT * FROM [stg_brightlearn_sales].[dbo].[stg_dim_store];



