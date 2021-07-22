SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AUDIT_LOG_TRANSACTIONS] (
		[AUDIT_LOG_TRANSACTION_ID]     [int] IDENTITY(1, 1) NOT NULL,
		[DATABASE]                     [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TABLE_NAME]                   [nvarchar](261) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TABLE_SCHEMA]                 [nvarchar](261) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AUDIT_ACTION_ID]              [tinyint] NOT NULL,
		[HOST_NAME]                    [varchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[APP_NAME]                     [varchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MODIFIED_BY]                  [varchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MODIFIED_DATE]                [datetime] NOT NULL,
		[AFFECTED_ROWS]                [int] NOT NULL,
		[SYSOBJ_ID]                    AS (object_id([TABLE_NAME])),
		CONSTRAINT [PK__AUDIT_LO__EC2FB09BF799ADF5]
		PRIMARY KEY
		CLUSTERED
		([AUDIT_LOG_TRANSACTION_ID])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AUDIT_LOG_TRANSACTIONS]
	ADD
	CONSTRAINT [DF__AUDIT_LOG__DATAB__4D94879B]
	DEFAULT (db_name()) FOR [DATABASE]
GO
CREATE NONCLUSTERED INDEX [IDX1_AUDIT_LOG_TRANSACTIONS]
	ON [dbo].[AUDIT_LOG_TRANSACTIONS] ([TABLE_NAME], [AUDIT_ACTION_ID])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX2_AUDIT_LOG_TRANSACTIONS]
	ON [dbo].[AUDIT_LOG_TRANSACTIONS] ([MODIFIED_DATE])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX3_AUDIT_LOG_TRANSACTIONS]
	ON [dbo].[AUDIT_LOG_TRANSACTIONS] ([MODIFIED_BY])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX4_AUDIT_LOG_TRANSACTIONS]
	ON [dbo].[AUDIT_LOG_TRANSACTIONS] ([HOST_NAME])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[AUDIT_LOG_TRANSACTIONS] SET (LOCK_ESCALATION = TABLE)
GO
