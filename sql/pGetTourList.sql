USE [SportStat]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pGetTourList]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pGetTourList]
GO

create procedure pGetTourList
@Country varchar(100),
@League varchar(100),
@Season varchar(100)
as
begin
	if isnull(@League, 'NA') = 'NA'
	begin
		select @League = L.League from DimLeague L
		join DimCountry C on L.IDCountry = C.IDCountry
		where C.Country = @Country
	end

	if isnull(@Season, 'NA') = 'NA'
	begin
		select @Season = S.Season from DimSeason S where IsCurrentSeason = 1
	end

	select 'Все' as Tour, 0 as TourNumber
	union all
	select distinct convert(varchar, Tour) as Tour, Tour as TourNumber
	from FactResult 
	where (Country = @Country and League =  @League AND Season = @Season) 
	order by TourNumber ASC
end

