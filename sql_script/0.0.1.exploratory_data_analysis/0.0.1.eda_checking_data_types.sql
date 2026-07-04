USE [stg_brightlearn_sales]
GO

/****** Object:  Table [dbo].[brightLearn_raw_data]    Script Date: 7/1/2026 10:11:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[brightLearn_raw_data](
	[transaction_date] [nvarchar](50) NOT NULL,
	[payment_method] [nvarchar](50) NOT NULL,
	[cashier_name] [nvarchar](50) NOT NULL,
	[transaction_amount] [float] NOT NULL,
	[transaction_discount] [float] NOT NULL,
	[customer_first_name] [nvarchar](50) NULL,
	[customer_last_name] [nvarchar](50) NULL,
	[customer_email] [nvarchar](50) NULL,
	[customer_phone] [int] NULL,
	[customer_city] [nvarchar](50) NULL,
	[customer_province] [nvarchar](50) NULL,
	[customer_loyalty_tier] [nvarchar](50) NULL,
	[customer_since] [datetime2](7) NULL,
	[store_name] [nvarchar](50) NOT NULL,
	[store_city] [nvarchar](50) NOT NULL,
	[store_province] [nvarchar](50) NOT NULL,
	[store_region] [nvarchar](50) NOT NULL,
	[store_manager] [nvarchar](50) NOT NULL,
	[product_name] [nvarchar](50) NOT NULL,
	[category] [nvarchar](50) NULL,
	[sub_category] [nvarchar](50) NOT NULL,
	[sku] [nvarchar](50) NOT NULL,
	[unit_price] [float] NOT NULL,
	[cost_price] [float] NOT NULL,
	[supplier] [nvarchar](50) NOT NULL,
	[qty] [nvarchar](50) NOT NULL,
	[line_amount] [float] NOT NULL,
	[stock_on_hand] [int] NOT NULL,
	[reorder_threshold] [int] NOT NULL
) ON [PRIMARY]
GO

/*=============================================================================================
Insight: only the transaction_date and qty, the dataypes are of nvarchar, need to be converted
===============================================================================================
