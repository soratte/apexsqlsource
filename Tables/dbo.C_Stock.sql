SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[C_Stock] (
		[s_i_id]           [int] NULL,
		[s_w_id]           [int] NULL,
		[s_quantity]       [smallint] NULL,
		[s_dist_01]        [char](24) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[s_dist_02]        [char](24) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[s_dist_03]        [char](24) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[s_dist_04]        [char](24) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[s_dist_05]        [char](24) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[s_dist_06]        [char](24) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[s_dist_07]        [char](24) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[s_dist_08]        [char](24) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[s_dist_09]        [char](24) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[s_dist_10]        [char](24) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[s_ytd]            [int] NULL,
		[s_order_cnt]      [smallint] NULL,
		[s_remote_cnt]     [smallint] NULL,
		[s_data]           [char](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX [C_Stock_I1]
	ON [dbo].[C_Stock] ([s_i_id], [s_w_id])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[C_Stock] SET (LOCK_ESCALATION = TABLE)
GO
