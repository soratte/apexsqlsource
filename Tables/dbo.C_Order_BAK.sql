SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[C_Order_BAK] (
		[o_id]             [int] NULL,
		[o_d_id]           [tinyint] NULL,
		[o_w_id]           [int] NULL,
		[o_c_id]           [int] NULL,
		[o_entry_d]        [datetime] NULL,
		[o_carrier_id]     [tinyint] NULL,
		[o_ol_cnt]         [tinyint] NULL,
		[o_all_local]      [tinyint] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[C_Order_BAK] SET (LOCK_ESCALATION = TABLE)
GO
