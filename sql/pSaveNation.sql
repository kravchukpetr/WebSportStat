USE [SportStat]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSaveNation]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pSaveNation]
GO

create procedure pSaveNation
--входящие параметры
 @Nation varchar(50)
,@NationUrl varchar(100)
,@NationImg varbinary(max)
as
begin

if not exists (select 1 from DimNation where Nation = @Nation)
begin

	insert into  DimNation(Nation, NationUrl, NationImg)
	select @Nation, @NationUrl, @NationImg

end

end