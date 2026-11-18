--------------------------------
--Checking for distinct product
--------------------------------
 SELECT DISTINCT 
        [product_name],
        [category],
        [sub_category],
        [sku],
        [supplier]
  FROM [stg_brightlearn_sales].[dbo].[stg_dim_product];

/* =========================================================================
   CREATE clean_dim_product Table using the IF NOT EXISTS clause (SAFE RERUN)
   Database : stg_brightlearn_sales
   Schema   : dbo
   ========================================================================= */

IF OBJECT_ID('[stg_brightlearn_sales].[dbo].[clean_dim_product]', 'U') IS NULL
BEGIN

    CREATE TABLE [stg_brightlearn_sales].[dbo].[clean_dim_product] (

        [product_name] [nvarchar](50),
        [category] [nvarchar](50),
	    [sub_category] [nvarchar](50),
	    [sku] [nvarchar](50),
        [supplier] [nvarchar](50),
        [date_loaded] DATETIME2(0) NOT NULL DEFAULT GETDATE()
    );

END;

/* ===================================================================
   INSERT INTO clean_dim_product (SAFE RERUN)
   1.SELECT DISTINCT Clause to return only unique values
   2.TRIM fucntion to remove unwanted spaces
   3.WHERE NOT EXISTS clause to avoid data duplication
   =================================================================== */

WITH product_cte AS (

        SELECT DISTINCT

        TRIM(UPPER(product_name)) AS product_name,

        COALESCE(TRIM(UPPER(category)), 'UNKNOWN') AS category,

        TRIM(UPPER(sub_category)) AS sub_category,

        TRIM(UPPER(sku)) AS sku, 

        TRIM(UPPER(supplier)) AS supplier

        FROM [stg_brightlearn_sales].[dbo].[stg_dim_product] 
)   

INSERT INTO [stg_brightlearn_sales].[dbo].[clean_dim_product]
(
        [product_name],
        [category],
        [sub_category],
        [sku],
        [supplier]
)

-- From the CTE query
SELECT * FROM product_cte


WHERE NOT EXISTS
(
    SELECT 1
    FROM [stg_brightlearn_sales].[dbo].[clean_dim_product] p
    WHERE p.[product_name] = [product_name]
      AND p.[category] = [category]
      AND p.[sub_category] = [sub_category]
      AND p.[sku] = [sku]
      AND p.[supplier] = [supplier]
      
);
GO

-----------------------
--View clean_dim_product
-----------------------

SELECT * FROM [stg_brightlearn_sales].[dbo].[clean_dim_product];





