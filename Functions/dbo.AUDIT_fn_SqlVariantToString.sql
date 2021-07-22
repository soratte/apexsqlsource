SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

create function dbo.AUDIT_fn_SqlVariantToString(@var sql_variant, @string bit)
returns nvarchar(4000)
as
begin
declare
@type varchar(20),
@result nvarchar(4000)
set @type = cast(SQL_VARIANT_PROPERTY(@var,'BaseType') as varchar(20))
if (@type='binary' or @type='varbinary')
	set @result = cast(dbo.AUDIT_fn_HexToStr(cast(@var as varbinary(8000))) as nvarchar(4000))
else if (@type='float' or @type='real')
	set @result = convert(nvarchar(4000), @var, 3)
else if (@type='int'
	or @type='tinyint'
	or @type='smallint'
	or @type='bigint'
	or @type='bit'
	or @type='decimal'
	or @type='numeric'
	)
	set @result = convert(nvarchar(4000), @var)
else if (@type='timestamp')
	set @result = convert(nvarchar(4000), convert(bigint, @var))
else if (@string = 1)
	set @result = 'N''' + convert(nvarchar(4000), @var) + ''''
else
	set @result = convert(nvarchar(4000), @var)
return @result
end
GO
