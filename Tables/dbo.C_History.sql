SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[C_History] (
		[h_c_id]       [int] NULL,
		[h_c_d_id]     [tinyint] NULL,
		[h_c_w_id]     [int] NULL,
		[h_d_id]       [tinyint] NULL,
		[h_w_id]       [int] NULL,
		[h_date]       [datetime] NULL,
		[h_amount]     [numeric](6, 2) NULL,
		[h_data]       [char](24) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[C_History] SET (LOCK_ESCALATION = TABLE)
GO
