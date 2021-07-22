SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TPC_C_LOAD_PROGRESS] (
		[TABLENAME]      [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VERSION]        [int] NOT NULL,
		[SETNUMBER]      [int] NOT NULL,
		[PROP_NAME]      [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PROP_VALUE]     [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__TPC_C_LO__05A2C37F7179B9C4]
		PRIMARY KEY
		CLUSTERED
		([TABLENAME], [VERSION], [SETNUMBER], [PROP_NAME])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TPC_C_LOAD_PROGRESS] SET (LOCK_ESCALATION = TABLE)
GO
