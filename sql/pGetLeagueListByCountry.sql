USE [SportStat]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pGetLeagueListByCountry]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pGetLeagueListByCountry]
GO

create procedure pGetLeagueListByCountry
@Country varchar(100) = NULL,
@Lang int = 1
as
begin
	select case when @Lang = 1 then L.League else L.LeagueEng end as League, IDLeagueType
	from DimLeague L
	join DimCountry C on L.IDCountry = C.IDCountry
	where C.Country = @Country AND @Country is not null Or @Country is null
	order by  IDLeagueType, IsPrimary, case when @Lang = 1 then League else LeagueEng end
end

select * from DimLeague