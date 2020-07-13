USE [SportStat]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pGetLeagueList]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pGetLeagueList]
GO

create procedure pGetLeagueList
@Country varchar(100),
@Lang int = 1
as
begin
	declare @IDCountry int

	select @IDCountry = IDCountry from DimCountry where Country = @Country

	select case when @Lang = 1 then League else LeagueEng end as League
	from DimLeague
	where IDCountry = @IDCountry
	order by  IDLeagueType, IsPrimary, case when @Lang = 1 then League else LeagueEng end

end