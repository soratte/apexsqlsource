SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE dbo.AUDIT_prc_DDLReport
(	@DATE_FROM 			nvarchar(50)	    = NULL,
	@DATE_TO 			  nvarchar(50)	    = NULL,
  @OLD_VALUE			nvarchar(4000)    = NULL,    
  @NEW_VALUE			nvarchar(4000)    = NULL,    
  @WHERE				  nvarchar(4000)    = NULL,
  @ROW_COUNT			int               = NULL)
AS
SET NOCOUNT ON;
DECLARE
@rowCount nchar(100),
@database nchar(1000),
@schema nchar(1000),
@action nchar(1000),
@oldValue nchar(1000),
@newValue nchar(1000),
@appName nchar(1000),
@hostName nchar(1000),
@modifiedBy nchar(1000),
@modifiedDate nchar(1000),
@dateFrom nchar(100),
@dateTo nchar(100),
@whereClause nchar(1000),
@query nchar(4000);
-- Set row count
IF @ROW_COUNT IS NULL
  BEGIN
    SET @rowCount = '99999';
  END
ELSE
  BEGIN
    SET @rowCount = CAST(@ROW_COUNT as nchar(100));
  END
-- Set new value
IF @NEW_VALUE IS NULL
  BEGIN
    SET @newValue = '%';
  END
ELSE
  BEGIN
    SET @newValue = '%' + RTRIM(@NEW_VALUE) + '%';
  END
-- Set new value
IF @OLD_VALUE IS NULL
  BEGIN
    SET @oldValue = '%';
  END
ELSE
  BEGIN
    SET @oldValue = '%' + RTRIM(@OLD_VALUE) + '%';
  END
-- Set WHERE clause
IF @WHERE IS NULL
  BEGIN
    SET @whereClause = '';
  END
ELSE
  BEGIN
    SET @whereClause = ' AND (' + RTRIM(@WHERE) + ')';
  END
-- Set date from
IF @DATE_FROM IS NULL
  BEGIN
    SET @dateFrom = '1/1/1900';
  END
ELSE
  BEGIN
    SET @dateFrom = CONVERT(nchar(100), @DATE_FROM, 120);
  END
-- Set date to
IF @DATE_TO IS NULL
  BEGIN
    SET @dateTo = '1/1/3900';
  END
ELSE
  BEGIN
    SET @dateTo = CONVERT(nchar(100), @DATE_TO, 120);
  END
DECLARE
@id int,
@value nchar(1000);
DECLARE
@counter int,
@filterValue nchar(1000);
-- Set filter for DATABASE
IF (select count(*) from ##Filter WHERE [index]='DATABASE') = 0
  BEGIN
	  SET @database = ' WHERE [DATABASE] LIKE ''%''';
  END
ELSE
  BEGIN
	  SET @database = ' WHERE [DATABASE] LIKE ''%''';
  END
  SET @database = RTRIM(@database);
-- Set filter for SCHEMA
CREATE TABLE ##FilterSchema
(
  id int identity(1,1) not null,
  value nchar(1000)
  primary key(id)
)
IF (select count(*) from ##Filter WHERE [index]='SCHEMA') = 0
  SET @schema = '';
ELSE
BEGIN
  INSERT INTO ##FilterSchema (value)
    SELECT [value] FROM ##Filter
    WHERE [index] = 'SCHEMA';
  SET @counter = 1;
  WHILE (@counter <= (SELECT MAX(id) FROM ##FilterSchema))
    BEGIN
      SET @filterValue = (SELECT value FROM ##FilterSchema WHERE id=@counter);
      IF @counter = 1
        BEGIN
          SET @schema = ' AND ([SCHEMA] LIKE ''' + RTRIM(@filterValue) + ''''
        END
      ELSE
        BEGIN
          SET @schema = RTRIM(@schema) + ' OR [SCHEMA] LIKE ''' + RTRIM(@filterValue) + ''''
        END
      SET @counter = @counter + 1
      SET @schema = RTRIM(@schema);
    END
    SET @schema = RTRIM(@schema) + ')';
END    
    DROP TABLE ##FilterSchema;
-- Set filter for ACTION
CREATE TABLE ##FilterAction
(
  id int identity(1,1) not null,
  value nchar(1000)
  primary key(id)
)
IF (select count(*) from ##Filter WHERE [index]='ACTION_ID') = 0
	SET @action = '';
ELSE
  INSERT INTO ##FilterAction (value)
    SELECT [value] FROM ##Filter
    WHERE [index] = 'ACTION_ID';
  SET @counter = 1;
  WHILE (@counter <= (SELECT MAX(id) FROM ##FilterAction))
    BEGIN
      SET @filterValue = (SELECT value FROM ##FilterAction WHERE id=@counter);
      IF @filterValue LIKE '%4%'
        BEGIN
          SET @filterValue = 'CREATE'
        END
      ELSE IF @filterValue LIKE '%5%'
        BEGIN
          SET @filterValue = 'ALTER'
        END
      ELSE IF @filterValue LIKE '%6%'
        BEGIN
          SET @filterValue = 'DROP'
        END
      ELSE
        BEGIN
          SET @filterValue = 'unknown'
        END
      IF @counter = 1
        BEGIN
          SET @action = ' AND (ACTION LIKE ''' + RTRIM(@filterValue) + ''''
        END
      ELSE
        BEGIN
          SET @action = RTRIM(@action) + ' OR ACTION LIKE ''' + RTRIM(@filterValue) + ''''
        END
      SET @counter = @counter + 1;
      SET @action = RTRIM(@action);
    END
    SET @action = RTRIM(@action) + ')';
    DROP TABLE ##FilterAction;
-- Set filter for OLD_VALUE
IF @OLD_VALUE IS NULL
  SET @oldValue = '';
ELSE
  SET @oldValue = ' AND (OLD_VALUE LIKE ''' + RTRIM(@oldValue) + ''')';
-- Set filter for NEW_VALUE
IF @NEW_VALUE IS NULL
  SET @newValue = '';
ELSE
  SET @newValue = ' AND (NEW_VALUE LIKE ''' + RTRIM(@newValue) + ''')';
-- Set filter for APP_NAME
CREATE TABLE ##FilterAppName
(
  id int identity(1,1) not null,
  value nchar(1000)
  primary key(id)
)
IF (select count(*) from ##Filter WHERE [index]='APP_NAME') = 0
	SET @appName = '';
ELSE
BEGIN
  INSERT INTO ##FilterAppName (value)
    SELECT [value] FROM ##Filter
    WHERE [index] = 'APP_NAME';
  SET @counter = 1;
  WHILE (@counter <= (SELECT MAX(id) FROM ##FilterAppName))
    BEGIN
      SET @filterValue = (SELECT value FROM ##FilterAppName WHERE id=@counter);
      IF @counter = 1
        BEGIN
          SET @appName = ' AND (APP_NAME LIKE ''' + RTRIM(@filterValue) + ''''
        END
      ELSE
        BEGIN
          SET @appName = RTRIM(@appName) + ' OR APP_NAME LIKE ''' + RTRIM(@filterValue) + ''''
        END
      SET @counter = @counter + 1;
      SET @appName = RTRIM(@appName);
    END
    SET @appName = RTRIM(@appName) + ')';
END    
    DROP TABLE ##FilterAppName;
-- Set filter for HOST_NAME
CREATE TABLE ##FilterHostName
(
  id int identity(1,1) not null,
  value nchar(1000)
  primary key(id)
)
IF (select count(*) from ##Filter WHERE [index]='HOST_NAME') = 0
	SET @hostName = '';
ELSE
BEGIN
	INSERT INTO ##FilterHostName (value)
    SELECT [value] FROM ##Filter
    WHERE [index] = 'HOST_NAME';
  SET @counter = 1;
  WHILE (@counter <= (SELECT MAX(id) FROM ##FilterHostName))
    BEGIN
      SET @filterValue = (SELECT value FROM ##FilterHostName WHERE id=@counter);
      IF @counter = 1
        BEGIN
          SET @hostName = ' AND (HOST_NAME LIKE ''' + RTRIM(@filterValue) + ''''
        END
      ELSE
        BEGIN
          SET @hostName = RTRIM(@hostName) + ' OR HOST_NAME LIKE ''' + RTRIM(@filterValue) + ''''
        END
      SET @counter = @counter + 1;
      SET @hostName = RTRIM(@hostName);
    END
    SET @hostName = RTRIM(@hostName) + ')';
END  
    DROP TABLE ##FilterHostName;
-- Set filter for MODIFIED_BY
CREATE TABLE ##FilterModifiedBy
(
  id int identity(1,1) not null,
  value nchar(1000)
  primary key(id)
)
IF (select count(*) from ##Filter WHERE [index]='USER_NAME') = 0
	SET @modifiedBy = '';
ELSE
BEGIN
	INSERT INTO ##FilterModifiedBy (value)
    SELECT [value] FROM ##Filter
    WHERE [index] = 'USER_NAME';
  SET @counter = 1;
  WHILE (@counter <= (SELECT MAX(id) FROM ##FilterModifiedBy))
    BEGIN
      SET @filterValue = (SELECT value FROM ##FilterModifiedBy WHERE id=@counter);
      IF @counter = 1
        BEGIN
          SET @modifiedBy = ' AND (MODIFIED_BY LIKE ''' + RTRIM(@filterValue) + ''''
        END
      ELSE
        BEGIN
          SET @modifiedBy = RTRIM(@modifiedBy) + ' OR MODIFIED_BY LIKE ''' + RTRIM(@filterValue) + ''''
        END
      SET @counter = @counter + 1;
      SET @modifiedBy = RTRIM(@modifiedBy);
    END
    SET @modifiedBy = RTRIM(@modifiedBy) + ')';
END    
    DROP TABLE ##FilterModifiedBy;
-- Set filter for MODIFIED_DATE
SET @modifiedDate = ' AND MODIFIED_DATE >= ''' + RTRIM(@dateFrom) + ''' AND MODIFIED_DATE <= ''' + RTRIM(@dateTo) + '''';
SET @query = 'SELECT TOP ' + RTRIM(@rowCount) + ' LogId as ''Log ID'', [DATABASE] as ''Database'', [SCHEMA] as ''Schema'', OBJECT_TYPE as ''Object type'', OBJECT_NAME as ''Object name'', ACTION as ''Action'', OLD_VALUE as ''Old value'', NEW_VALUE as ''New value'', DESCRIPTION as ''Description'', MODIFIED_BY as ''Modified by'', MODIFIED_DATE as ''Modified date'', APP_NAME as ''Application name'', HOST_NAME as ''Host name'' FROM AUDIT_LOG_DDL'
+ RTRIM(@database)
+ RTRIM(@whereClause)
+ RTRIM(@schema)
+ RTRIM(@action)
+ RTRIM(@oldValue)
+ RTRIM(@newValue)
+ RTRIM(@appName)
+ RTRIM(@hostName)
+ RTRIM(@modifiedBy)
+ RTRIM(@modifiedDate);
EXECUTE sp_executesql @query;
GO
