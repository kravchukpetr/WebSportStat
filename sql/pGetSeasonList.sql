USE [SportStat]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pGetSeasonList]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pGetSeasonList]
GO

create procedure pGetSeasonList
@IDSeasonType int = 1,
@Country varchar(100) = null
as
begin
	if @IDSeasonType is null and @Country is not null
	begin
		select @IDSeasonType = IDSeasonType from DimCountry where Country = @Country
	end
	
	select Season, IsCurrentSeason from DimSeason where IDSeasonType = @IDSeasonType
end

