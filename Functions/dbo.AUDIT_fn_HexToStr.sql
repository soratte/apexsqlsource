SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[AUDIT_fn_HexToStr](@hex varbinary(8000))
returns varchar(8000)
as
begin
declare 
	@len int,
	@counter int,
	@res varchar(8000),
	@string char(16),
	@byte binary(1)
	set @string = '0123456789ABCDEF'
	set @res = '0x'
	set @len = datalength(@hex)
	set @counter = 1
	while(@counter <= @len)
	begin
		set @byte = substring(@hex, @counter, 1)
		set @res = @res + substring(@string, 1 + @byte/16, 1) + substring(@string, 1 + @byte - (@byte/16)*16, 1)
		set @counter = @counter + 1
	end
	return @res
end
GO
