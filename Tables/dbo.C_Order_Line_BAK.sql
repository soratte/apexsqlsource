SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[C_Order_Line_BAK] (
		[ol_o_id]            [int] NULL,
		[ol_d_id]            [tinyint] NULL,
		[ol_w_id]            [int] NULL,
		[ol_number]          [tinyint] NULL,
		[ol_i_id]            [int] NULL,
		[ol_supply_w_id]     [int] NULL,
		[ol_delivery_d]      [datetime] NULL,
		[ol_quantity]        [smallint] NULL,
		[ol_amount]          [numeric](6, 2) NULL,
		[ol_dist_info]       [char](24) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[C_Order_Line_BAK] SET (LOCK_ESCALATION = TABLE)
GO
