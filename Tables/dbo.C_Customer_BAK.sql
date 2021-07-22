SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[C_Customer_BAK] (
		[c_id]               [int] NULL,
		[c_d_id]             [tinyint] NULL,
		[c_w_id]             [int] NULL,
		[c_first]            [char](16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[c_middle]           [char](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[c_last]             [char](16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[c_street_1]         [char](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[c_street_2]         [char](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[c_city]             [char](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[c_state]            [char](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[c_zip]              [char](9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[c_phone]            [char](16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[c_since]            [datetime] NULL,
		[c_credit]           [char](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[c_credit_lim]       [numeric](12, 2) NULL,
		[c_discount]         [numeric](4, 4) NULL,
		[c_balance]          [numeric](12, 2) NULL,
		[c_ytd_payment]      [numeric](12, 2) NULL,
		[c_payment_cnt]      [smallint] NULL,
		[c_delivery_cnt]     [smallint] NULL,
		[c_data1]            [char](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[c_data2]            [char](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[C_Customer_BAK] SET (LOCK_ESCALATION = TABLE)
GO
