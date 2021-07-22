SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[C_Warehouse_BAK] (
		[w_id]           [int] NULL,
		[w_name]         [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[w_street_1]     [char](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[w_street_2]     [char](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[w_city]         [char](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[w_state]        [char](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[w_zip]          [char](9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[w_tax]          [numeric](4, 4) NULL,
		[w_ytd]          [numeric](12, 2) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[C_Warehouse_BAK] SET (LOCK_ESCALATION = TABLE)
GO
