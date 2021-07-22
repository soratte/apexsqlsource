SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[C_New_Order] (
		[no_o_id]     [int] NULL,
		[no_d_id]     [tinyint] NULL,
		[no_w_id]     [int] NULL
) ON [PRIMARY]
GO
CREATE UNIQUE CLUSTERED INDEX [C_New_Order_I1]
	ON [dbo].[C_New_Order] ([no_w_id], [no_d_id], [no_o_id])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[C_New_Order] SET (LOCK_ESCALATION = TABLE)
GO
