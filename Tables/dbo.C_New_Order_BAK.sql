SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[C_New_Order_BAK] (
		[no_o_id]     [int] NULL,
		[no_d_id]     [tinyint] NULL,
		[no_w_id]     [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[C_New_Order_BAK] SET (LOCK_ESCALATION = TABLE)
GO
