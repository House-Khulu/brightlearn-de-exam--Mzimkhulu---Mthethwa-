----------------------------------------------------------
-- create two databases only if they do not already exist
----------------------------------------------------------

---------------------------
--Creating staging database
---------------------------

IF DB_ID ('stg_brightlearn_sales') IS NULL
CREATE DATABASE [stg_brightlearn_sales];
GO

----------------------------------
--Creating data warehouse database
----------------------------------
IF DB_ID ('dwh_brightlearn_sales') IS NULL
CREATE DATABASE [dwh_brightlearn_sales];
GO
