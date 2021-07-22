SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[C_District] (
		[d_id]            [tinyint] NULL,
		[d_w_id]          [int] NULL,
		[d_name]          [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[d_street_1]      [char](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[d_street_2]      [char](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[d_city]          [char](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[d_state]         [char](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[d_zip]           [char](9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[d_tax]           [numeric](4, 4) NULL,
		[d_ytd]           [numeric](12, 2) NULL,
		[d_next_o_id]     [int] NULL
) ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX [C_District_I1]
	ON [dbo].[C_District] ([d_w_id], [d_id])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[C_District] SET (LOCK_ESCALATION = TABLE)
GO
