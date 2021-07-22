SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW dbo.AUDIT_UNDO AS
/* ------------------------------------------------------------
VIEW:          AUDIT_UNDO
DESCRIPTION:   Selects Audit Log records and returns all rows from the
               AUDIT_LOG_TRANSACTIONS ALT, with the matching rows in the AUDIT_LOG_DATA AD.
   ------------------------------------------------------------ */
SELECT    
	ALT.AUDIT_LOG_TRANSACTION_ID,    
	TABLE_NAME = ALT.TABLE_NAME,
	TABLE_SCHEMA = ALT.TABLE_SCHEMA,
	CASE    
		WHEN ALT.AUDIT_ACTION_ID = 3 THEN 'Delete' 
		WHEN ALT.AUDIT_ACTION_ID = 2 THEN 'Insert'
		WHEN ALT.AUDIT_ACTION_ID = 1 THEN 'Update'
	END AS ACTION_NAME,
	ALT.HOST_NAME,    
	ALT.APP_NAME,    
	ALT.MODIFIED_BY,    
	ALT.MODIFIED_DATE,    
	ALT.AFFECTED_ROWS,
	AUDIT_LOG_DATA_ID,  
	PRIMARY_KEY,  
	COL_NAME,  
	OLD_VALUE,  
	NEW_VALUE,
	DATA_TYPE      
FROM AUDIT_LOG_TRANSACTIONS ALT
	LEFT JOIN  AUDIT_LOG_DATA AD
		ON AD.AUDIT_LOG_TRANSACTION_ID = ALT.AUDIT_LOG_TRANSACTION_ID
GO
