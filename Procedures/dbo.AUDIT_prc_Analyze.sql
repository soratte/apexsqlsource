SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE dbo.AUDIT_prc_Analyze
	@DDL	  	bit	output,
	@Identity 	bit	output,
	@View	  	bit	output,
	@standard 	bit	output,
	@aggregate 	bit	output,
	@ddl_report	bit	output,
	@purge	  	bit	output,
  @undo	  	bit	output, -- Retained for compatibility with previous architecture 
	@Delete		bit	output,
	@Analyze	bit	output
as
	declare @cmptlvl int
    set @Identity=1 --now always
	Select @cmptlvl = t1.cmptlevel 
		from master.dbo.sysdatabases t1
		where t1.[name]=DB_NAME()
	--	DDL
	set @DDL=1	
		if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AUDIT_prc_ReportingEnd]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
		BEGIN
			set @standard  = 0
			PRINT '     AUDIT_prc_ReportingEnd is Missing'
		END
		if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AUDIT_prc_ReportingStart]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
		BEGIN
			set @standard  = 0
			PRINT '     AUDIT_prc_ReportingStart is Missing'
		END
		if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AUDIT_prc_ReportingAddFilterValue]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
		BEGIN
			set @standard  = 0
			PRINT '     AUDIT_prc_ReportingAddFilterValue is Missing'
		END
		if NOT EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[AUDIT_LOG_DATA]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
		BEGIN
			set @DDL = 0
			PRINT '     AUDIT_LOG_DATA is Missing'
		END
		if NOT EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[AUDIT_LOG_TRANSACTIONS]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
		BEGIN
			set @DDL = 0
			PRINT '     AUDIT_LOG_TRANSACTIONS is Missing'
		END
		IF @cmptlvl > 70
		BEGIN
		IF OBJECTPROPERTY(OBJECT_ID('dbo.AUDIT_fn_HexToStr'), 'IsScalarFunction') IS NULL 
		BEGIN
			set @DDL = 0
			PRINT '     dbo.AUDIT_fn_HexToStr is Missing'
		END
		IF OBJECTPROPERTY(OBJECT_ID('dbo.AUDIT_fn_SqlVariantToString'), 'IsScalarFunction') IS NULL
		BEGIN
			set @DDL = 0
			PRINT '     dbo.AUDIT_fn_SqlVariantToString is Missing'
		END
		END
				IF @DDL = 0 
				BEGIN
					PRINT 'Internal DDL Script(s) Missing or Incomplete'
				END
				ELSE
				BEGIN
					PRINT 'Internal DDL Script(s) OK'
				END
	--	Indentity
	set @View = 1
		if NOT EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[AUDIT_VIEW]') and OBJECTPROPERTY(id, N'IsView') = 1)
		BEGIN
			set @View = 0
			PRINT '     AUDIT_VIEW is Missing'
		END
					IF @View = 0 
					BEGIN
						PRINT 'Audit View Script(s) Missing or Incomplete'
					END
					ELSE
					BEGIN
						PRINT 'Audit View Script(s) OK'
					END
	set @aggregate = 1
		if NOT EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[AUDIT_prc_AggregateReport]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
		BEGIN
			set @aggregate  = 0
			PRINT '     AUDIT_prc_AggregateReport is Missing'
		END
		if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AUDIT_prc_ReportingStart]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
		BEGIN
			set @aggregate  = 0
			PRINT '     AUDIT_prc_ReportingStart is Missing'
		END
		if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AUDIT_prc_ReportingEnd]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
		BEGIN
			set @aggregate  = 0
			PRINT '     AUDIT_prc_ReportingEnd is Missing'
		END
		if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AUDIT_prc_ReportingAddFilterValue]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
		BEGIN
			set @aggregate  = 0
			PRINT '     AUDIT_prc_ReportingAddFilterValue is Missing'
		END
				IF @aggregate = 0 
				BEGIN
					PRINT 'Aggregate Reporting Script(s) Missing or Incomplete'
				END
				ELSE
				BEGIN
					PRINT 'Aggregate Reporting Script(s) OK'
				END
	set @standard = 1
		if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AUDIT_prc_StandardReport]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
		BEGIN
			set @standard = 0
			PRINT '     AUDIT_prc_StandardReport is Missing'
		END
		if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AUDIT_prc_ReportingEnd]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
		BEGIN
			set @standard  = 0
			PRINT '     AUDIT_prc_ReportingEnd is Missing'
		END
		if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AUDIT_prc_ReportingStart]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
		BEGIN
			set @standard  = 0
			PRINT '     AUDIT_prc_ReportingStart is Missing'
		END
		if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AUDIT_prc_ReportingAddFilterValue]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
		BEGIN
			set @standard  = 0
			PRINT '     AUDIT_prc_ReportingAddFilterValue is Missing'
		END
				IF @standard = 0 
				BEGIN
					PRINT 'Standard Reporting Script(s) Missing or Incomplete'
				END
				ELSE
				BEGIN
					PRINT 'Standard Reporting Script(s) OK'
				END
	set @ddl_report = 1
		if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AUDIT_prc_DDLReport]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
		BEGIN
			set @ddl_report = 0
			PRINT '     AUDIT_prc_DDLReport is Missing'
		END
		if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AUDIT_prc_ReportingEnd]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
		BEGIN
			set @ddl_report  = 0
			PRINT '     AUDIT_prc_ReportingEnd is Missing'
		END
		if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AUDIT_prc_ReportingStart]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
		BEGIN
			set @ddl_report  = 0
			PRINT '     AUDIT_prc_ReportingStart is Missing'
		END
		if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AUDIT_prc_ReportingAddFilterValue]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
		BEGIN
			set @ddl_report  = 0
			PRINT '     AUDIT_prc_ReportingAddFilterValue is Missing'
		END
				IF @ddl_report = 0 
				BEGIN
					PRINT 'DDL Reporting Script(s) Missing or Incomplete'
				END
				ELSE
				BEGIN
					PRINT 'DDL Reporting Script(s) OK'
				END
	set @purge = 1
		if NOT exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AUDIT_prc_Purge_AUDIT_LOG]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
		BEGIN
			set @purge = 0
			PRINT '     AUDIT_prc_Purge_AUDIT_LOG'
		END
				IF @purge = 0 
				BEGIN
					PRINT 'Audit Data Purge Script(s) Missing or Incomplete'
				END
				ELSE
				BEGIN
					PRINT 'Audit Data Purge Script(s) OK'
				END
	set @Delete = 1
		if NOT EXISTS (select * from dbo.sysobjects where name = 'AUDIT_prc_DeleteArchitecture')
		BEGIN			
			set @Delete = 0
			PRINT '     AUDIT_prc_DeleteArchitecture is Missing'
		END
				IF @Delete = 0 
				BEGIN
					PRINT 'Delete Architecture Script(s) Missing or Incomplete'
				END
				ELSE
				BEGIN
					PRINT 'Delete Architecture Script(s) OK'
				END
	set @Analyze = 1
		if NOT EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[AUDIT_prc_Analyze]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
		BEGIN
			set @Delete = 0
			PRINT '     AUDIT_prc_Analyze is Missing'
		END
				IF @Analyze = 0 
				BEGIN
					PRINT 'Analyze Script(s) Missing or Incomplete'
				END
				ELSE
				BEGIN
					PRINT 'Analyze Script(s) OK'
				END
GO
