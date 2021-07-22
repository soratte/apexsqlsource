SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AUDIT_LOG_DDL] (
		[LogId]             [int] IDENTITY(1, 1) NOT NULL,
		[DATABASE]          [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SCHEMA]            [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[OBJECT_TYPE]       [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[OBJECT_NAME]       [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ACTION]            [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[OLD_VALUE]         [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[NEW_VALUE]         [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[MODIFIED_BY]       [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MODIFIED_DATE]     [datetime] NULL,
		[APP_NAME]          [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[HOST_NAME]         [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DESCRIPTION]       [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK__AUDIT_LO__5E548648E175C1A3]
		PRIMARY KEY
		CLUSTERED
		([LogId])
	ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX1_AUDIT_LOG_DDL]
	ON [dbo].[AUDIT_LOG_DDL] ([LogId])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[AUDIT_LOG_DDL] SET (LOCK_ESCALATION = TABLE)
GO
