USE [dwh_brightlearn_sales];
GO

/* ==========================================
   CREATE DIM_DATE
   ========================================== */

IF OBJECT_ID('[dbo].[dim_date]', 'U') IS NULL
BEGIN

    CREATE TABLE [dbo].[dim_date]
    (
        date_key        INT PRIMARY KEY,     -- YYYYMMDD
        full_date       DATE,
        year            INT,
        quarter         INT,
        month           INT,
        month_name      VARCHAR(20),
        day             INT,
        day_name        VARCHAR(20),
        day_of_week     INT,
        is_weekend      BIT
    );

END;
GO

/* ==========================================
   LOAD DATE DIMENSION (2018 - 2028)
   ========================================== */

WITH date_cte AS
(
    SELECT CAST('2018-01-01' AS DATE) AS d

    UNION ALL

    SELECT DATEADD(DAY, 1, d)
    FROM date_cte
    WHERE d < '2028-12-31'
)

INSERT INTO [dwh_brightlearn_sales].[dbo].[dim_date]
(
    date_key,
    full_date,
    year,
    quarter,
    month,
    month_name,
    day,
    day_name,
    day_of_week,
    is_weekend
)

SELECT
    CAST(CONVERT(VARCHAR(8), c.d, 112) AS INT) AS date_key,
    c.d AS full_date,
    YEAR(c.d) AS year,
    DATEPART(QUARTER, c.d) AS quarter,
    MONTH(c.d) AS month,
    DATENAME(MONTH, c.d) AS month_name,
    DAY(c.d) AS day,
    DATENAME(WEEKDAY, c.d) AS day_name,
    DATEPART(WEEKDAY, c.d) AS day_of_week,
    CASE
        WHEN DATEPART(WEEKDAY, c.d) IN (1, 7) THEN 1
        ELSE 0
    END AS is_weekend
FROM date_cte AS c
WHERE NOT EXISTS
(
    SELECT 1
    FROM [dwh_brightlearn_sales].[dbo].[dim_date] AS d
    WHERE d.date_key = CAST(CONVERT(VARCHAR(8), c.d, 112) AS INT)
)
OPTION (MAXRECURSION 0);
GO

/* ==========================================
   VERIFY
   ========================================== */

SELECT *
FROM [dwh_brightlearn_sales].[dbo].[dim_date]
ORDER BY full_date;