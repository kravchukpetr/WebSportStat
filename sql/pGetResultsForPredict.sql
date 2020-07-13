USE [SportStat]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pGetResultsForPredict]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pGetResultsForPredict]
GO

create procedure pGetResultsForPredict
@TypeSelect int = 1,
@Country varchar(100),
@League varchar(100),
@Season varchar(100) = NULL,
@Tour int = NULL,
@DateFrom datetime = NULL,
@DateTO datetime = NULL,
@TeamList varchar(50) = NULL,
@DateDiff int = NULL
as
begin

set nocount on;
if @DateFrom is null select @DateFrom = convert(date, getdate())
if @DateTO is null select @DateTO =dateadd(DD, @DateDiff, @DateFrom) 
if @DateDiff is null select @DateDiff = 0
if (@Tour is not null and @DateTO is null) select @DateTo = min(MatchDate) from FactResult where Country = @Country and League =  @League   AND Season = @Season and Tour = @Tour 

if isnull(@League, 'NA') = 'NA'
begin
	select @League = L.League from DimLeague L
	join DimCountry C on L.IDCountry = C.IDCountry
	where C.Country = @Country
end

create table #TeamList(Team varchar(50))
insert into #TeamList 
select * from fSplit(@TeamList, ',')


	select Tour as 'T',  MatchDate as 'Dt', TeamHome as 'TH', GoalHome  as 'GH', GoalGuest as 'GG', TeamGuest as 'TG', Season, Country, League,
	case when TeamHome IN (select Team from #TeamList) AND GoalHome > GoalGuest then 1 
		 when TeamHome IN (select Team from #TeamList) AND GoalHome = GoalGuest then 0 
		 when TeamHome IN (select Team from #TeamList) AND GoalHome < GoalGuest then -1
		 when TeamGuest IN (select Team from #TeamList) AND GoalHome > GoalGuest then -1  
		 when TeamGuest IN (select Team from #TeamList) AND GoalHome = GoalGuest then 0
		 when TeamGuest IN (select Team from #TeamList) AND GoalHome < GoalGuest then 1	
	End as ResultColor 
	from FactResult 
	where ((Country = @Country and League =  @League) or @Country ='Все') AND
	(
		(@TypeSelect = 1 AND MatchDate < @DateFrom AND GoalHome is not null) OR 
		(@TypeSelect = 2 AND Season = @Season AND Tour = @Tour) OR 
		(@TypeSelect = 3 AND Season = @Season AND Tour = @Tour  AND GoalHome is null) OR 
		(@TypeSelect = 4 AND  MatchDate between @DateFrom AND @DateTO) OR
		(@TypeSelect = 5 AND  MatchDate < @DateTO AND GoalHome is not null) OR
		(@TypeSelect = 6 AND  MatchDate >= @DateTO AND GoalHome is not null) OR
		(@TypeSelect = 7 AND  Season = @Season AND (TeamHome IN (select Team from #TeamList) OR TeamGuest IN (select Team from #TeamList)) AND GoalHome is not null) OR
		(@TypeSelect = 8 AND  (TeamHome IN (select Team from #TeamList) AND TeamGuest IN (select Team from #TeamList)) AND GoalHome is not null)
	)
	order by Season, MatchDate desc

end

