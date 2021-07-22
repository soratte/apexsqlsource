SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW dbo.AUDIT_VIEW AS
/* ------------------------------------------------------------
VIEW:          AUDIT_VIEW
DESCRIPTION:   Selects Audit Log records and groups by MODIFIED_DATE and PK
               effectively grouping audit data by Audit transaction
   ------------------------------------------------------------ */
SELECT MAX(t.TABLE_NAME) AS TABLE_NAME,
    CASE MAX(t.AUDIT_ACTION_ID) 
    WHEN 1 THEN 'UPDATE' 
    WHEN 2 THEN 'INSERT' 
    WHEN 3 THEN 'DELETE' 
    END AS ACTION, 
    MAX(t.MODIFIED_BY) AS MODIFIED_BY, 
    MAX(PRIMARY_KEY_DATA) AS PRIMARY_KEY,
    COUNT(DISTINCT PRIMARY_KEY_DATA) AS REC_COUNT,
    CONVERT(varchar(20), MODIFIED_DATE, 113) AS MODIFIED_DATE,
    Max(HOST_NAME) AS COMPUTER,
    Max(APP_NAME) as APPLICATION
FROM dbo.AUDIT_LOG_TRANSACTIONS t
INNER JOIN dbo.AUDIT_LOG_DATA r ON r.AUDIT_LOG_TRANSACTION_ID = t.AUDIT_LOG_TRANSACTION_ID
GROUP BY MODIFIED_DATE, PRIMARY_KEY_DATA
GO
