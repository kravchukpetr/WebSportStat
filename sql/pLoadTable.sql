USE [SportStat]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLoadTable]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pLoadTable]
GO

create procedure pLoadTable
--входящие параметры
 @Season varchar(50)
,@Country varchar(50)
,@League varchar(50)
,@TypeTable varchar(50)
,@IsDetailTable int 
,@TypeTour varchar(20)
,@LastTours int = NULL
,@TourNumber int = NULL
,@TourDate date = NULL
,@IDSport int = 1
,@TypeReturn int = 1
,@Sport  varchar(50) = 'Футбол'
as
begin

--значения входящих параметров
--select @Season = '2014-2015'
--select @Country = 'Италия'
--select @League = 'Серия A'
--select @TypeTable = 'Всего'--Всего/Дома/В гостях
--select @IsDetailTable =  1 --нужно ли выводить детализацию дома/в гостях: 1 - да; 0 - нет
--select @TypeTour = 'Full'  -- тип турнироной таблицы на тур/дау: 'Full' - на текущий момент; 
--                                                               --'LastTours' - за последние @LastTours туров; 
--                                                               --'OnTour' - на @TourNumber тур
--                                                               --'OnDate' - на @TourDate дату
                                                                 --'LastGames' - за последние @LastGames туров; 
--select @LastTours = NULL
--select @TourNumber = NULL
--select @TourDate = NULL
--select @TypeReturn = 1 --1 - возвращаем результат; 2 - записываем в таблицу

--объявление переменных
set nocount on;
declare @LastTour int
declare @Query varchar(max)
declare @IDCountry int
declare @IDSeason int
declare @IDLeague int

select @IDCountry = IDCountry from DimCountry where Country = @Country
select @IDSeason = IDSeason from DimSeason where Season = @Season
select @IDLeague = IDLeague from DimLeague where League = @League and IDCountry = @IDCountry

--создание временных таблиц
IF OBJECT_ID('tempdb..#TmpTable') IS NOT NULL DROP TABLE #TmpTable

create table #TmpTable
(
Position int not null, 
Team varchar(100) null,
IDTeam int null,
CountGames int null, 
CountWin int null, 
CountDraw int null, 
CountLose int null, 
GoalWin int null, 
GoalLose int null,
GoalDifference  varchar(20) null, 
CountPoint int null,
CountGamesHome int null, 
CountWinHome int null, 
CountDrawHome int null, 
CountLoseHome int null, 
GoalWinHome int null, 
GoalLoseHome int null, 
GoalDifferenceHome varchar(20) null, 
CountPointHome int null,
CountGamesGuest int null, 
CountWinGuest int null, 
CountDrawGuest int null, 
CountLoseGuest int null, 
GoalWinGuest int null, 
GoalLoseGuest int null,
CountPointGuest int null,
GoalDifferenceGuest varchar(20) null,
PosType int null,
LastGames varchar(1000) null,
Sport varchar(100) null,
Country varchar(100) null,
Season varchar(100) null,
League varchar(100) null
)

if isnull(@League, 'NA') = 'NA'
begin
	select @League = L.League from DimLeague L
	join DimCountry C on L.IDCountry = C.IDCountry
	where C.Country = @Country
end
--последний сыгранный тур
select @LastTour = MAX(FR.Tour)
FROM FactResult  FR
left join DimSeason S on FR.IDSeason = S.IDSeason
left join DimCountry C on FR.IDCountry = C.IDCountry
left join DimLeague L on FR.IDleague = L.IDLeague
left join DimTeam T on FR.IDTeamHome = T.IDTeam
WHERE S.Season = @Season and C.Country = @Country and L.League = @League
      and FR.GoalHome IS NOT NULL and FR.GoalGuest IS NOT NULL


INSERT INTO #TmpTable
(
Position, 
Team,
IDTeam,
CountGames, 
CountWin, 
CountDraw, 
CountLose, 
GoalWin, 
GoalLose,
GoalDifference, 
CountPoint,
CountGamesHome, 
CountWinHome, 
CountDrawHome, 
CountLoseHome, 
GoalWinHome, 
GoalLoseHome, 
GoalDifferenceHome, 
CountPointHome,
CountGamesGuest, 
CountWinGuest, 
CountDrawGuest, 
CountLoseGuest, 
GoalWinGuest, 
GoalLoseGuest,
CountPointGuest,
GoalDifferenceGuest 
)
SELECT ROW_NUMBER()  OVER(ORDER BY sum(CountPoint) DESC) as Position, 
T.Team, T.IDTeam,
		sum(CountGames) as CountGames, 
        sum(CountWin) as CountWin, 
        sum(CountDraw) as CountDraw, 
        sum(CountLose) as CountLose, 
        SUM(GoalWin) as GoalWin, 
        SUM(GoalLose) as GoalLose,
        CONVERT(varchar(10), SUM(GoalWin)) + ' - ' + CONVERT(varchar(10), SUM(GoalLose)) as GoalDifference, 
        sum(CountPoint) as CountPoint,
        sum(case when PartTable = 'Home' then CountGames else 0 End) as CountGamesHome, 
        sum(case when PartTable = 'Home' then CountWin else 0 End) as CountWinHome, 
        sum(case when PartTable = 'Home' then CountDraw else 0 End) as CountDrawHome, 
        sum(case when PartTable = 'Home' then CountLose else 0 End) as CountLoseHome, 
        SUM(case when PartTable = 'Home' then GoalWin else 0 End) as GoalWinHome, 
        SUM(case when PartTable = 'Home' then GoalLose else 0 End) as GoalLoseHome,
        CONVERT(varchar(10), SUM(case when PartTable = 'Home' then GoalWin else 0 End)) + ' - ' 
        + CONVERT(varchar(10), SUM(case when PartTable = 'Home' then GoalLose else 0 End)) as GoalDifferenceHome, 
        sum(case when PartTable = 'Home' then CountPoint else 0 End) as CountPointHome,
        sum(case when PartTable = 'Guest' then CountGames else 0 End) as CountGamesGuest, 
        sum(case when PartTable = 'Guest' then CountWin else 0 End) as CountWinGuest, 
        sum(case when PartTable = 'Guest' then CountDraw else 0 End) as CountDrawGuest, 
        sum(case when PartTable = 'Guest' then CountLose else 0 End) as CountLoseGuest, 
        SUM(case when PartTable = 'Guest' then GoalWin else 0 End) as GoalWinGuest, 
        SUM(case when PartTable = 'Guest' then GoalLose else 0 End) as GoalLoseGuest,
        sum(case when PartTable = 'Guest' then CountPoint else 0 End) as CountPointGuest,
        CONVERT(varchar(10), SUM(case when PartTable = 'Guest' then GoalWin else 0 End)) + ' - ' 
        + CONVERT(varchar(10), SUM(case when PartTable = 'Guest' then GoalLose else 0 End)) as GoalDifferenceGuest 
FROM
(
SELECT 
T.Team, T.IDTeam,
		sum(case when FR.GoalHome IS NULL and FR.GoalGuest IS NULL then 0 else 1 End) as CountGames, 
        SUM(case when GoalHome > GoalGuest then 1 else 0 end) as CountWin,
        SUM(case when GoalHome = GoalGuest then 1 else 0 end) as CountDraw,
        SUM(case when GoalHome < GoalGuest then 1 else 0 end) as CountLose,
        SUM(GoalHome) as GoalWin,
        SUM(GoalGuest)  as GoalLose,
        SUM(case when GoalHome > GoalGuest then 3 when GoalHome = GoalGuest then 1 else 0 end) as CountPoint,
        'Home' as PartTable
FROM FactResult  FR
left join DimSeason S on FR.IDSeason = S.IDSeason
left join DimCountry C on FR.IDCountry = C.IDCountry
left join DimLeague L on FR.IDleague = L.IDLeague
left join DimTeam T on FR.IDTeamHome = T.IDTeam
WHERE S.Season = @Season and C.Country = @Country and L.League = @League
      and @TypeTable IN ('Всего', 'Дома')
      and (case when @TypeTour = 'Full' then 1
                when @TypeTour = 'LastTours' then (case when FR.Tour>=@LastTour -ISNULL(@LastTours,0) + 1 then 1 else 0 End)
                when @TypeTour = 'OnTour' then (case when @TourNumber is not null and FR.Tour<=@TourNumber then 1 else 0 End)
                when @TypeTour = 'OnDate' then (case when @TourDate is not null and FR.MatchDate<=@TourDate then 1 else 0 End)
          End) = 1
GROUP BY T.Team, T.IDTeam

UNION ALL
SELECT 
T.Team, T.IDTeam,
		sum(case when FR.GoalHome IS NULL and FR.GoalGuest IS NULL then 0 else 1 End) as CountGames, 
        SUM(case when GoalGuest > GoalHome then 1 else 0 end) as CountWin,
        SUM(case when GoalHome = GoalGuest then 1 else 0 end) as CountDraw,
        SUM(case when GoalGuest < GoalHome  then 1 else 0 end) as CountLose,
        SUM(GoalGuest) as GoalWin,
        SUM(GoalHome)  as GoalLose,
        SUM(case when GoalGuest > GoalHome then 3 when GoalHome = GoalGuest then 1 else 0 end) as CountPoint,
        'Guest' as PartTable
FROM FactResult  FR
left join DimSeason S on FR.IDSeason = S.IDSeason
left join DimCountry C on FR.IDCountry = C.IDCountry
left join DimLeague L on FR.IDleague = L.IDLeague
left join DimTeam T on FR.IDTeamGuest = T.IDTeam
WHERE S.Season = @Season and C.Country = @Country and L.League = @League
      and @TypeTable IN ('Всего', 'В гостях')
      and (case when @TypeTour = 'Full' then 1
            when @TypeTour = 'LastTours' then (case when FR.Tour>=@LastTour -ISNULL(@LastTours,0) + 1 then 1 else 0 End)
            when @TypeTour = 'OnTour' then (case when @TourNumber is not null and FR.Tour<=@TourNumber then 1 else 0 End)
            when @TypeTour = 'OnDate' then (case when @TourDate is not null and FR.MatchDate<=@TourDate then 1 else 0 End)
      End) = 1
GROUP BY T.Team,T.IDTeam
) T
GROUP BY T.Team, T.IDTeam
ORDER BY sum(T.CountPoint) DESC

update  #TmpTable
set Sport = @Sport,
	Season = @Season,
	Country = @Country,	
	League = @League

update #TmpTable
set PosType = pl.PosType
from #TmpTable tt
join DimPosLink pl on tt.Position between pl.PosFrom and  pl.PosTo 
where  pl.IDCountry = @IDCountry and  pl.IDLeague = @IDLeague and pl.Season = @Season
	
update  #TmpTable
set LastGames = dbo.fGetLastGames (Sport, Season, Country, League, Team, 5)

if @TypeTour = 'Full' select @TourDate = getdate()
select @Query = 
'SELECT '
 + (case when isnull(@TypeReturn,1) = 2 then 
 cast(@IDSport as varchar(10)) + ',' +
 '''' + @Country + ''',' +
 '''' + @Season + ''',' +
 '''' + @League + ''',' +
cast(@IDCountry as varchar(10)) + ',' + 
cast(@IDSeason as varchar(10)) + ',' + 
cast(@IDLeague as varchar(10)) + ',' +
'''' + @TypeTour + ''',' +
case when @LastTours is null then 'NULL' else cast(@LastTours  as varchar(10)) end + ',' +
case when @TourNumber is null then 'NULL' else cast(@TourNumber as varchar(10)) end + ',' +
case when  @TourDate is null then 'NULL' else '''' + convert(varchar, @TourDate,  104) + '''' end + ','
  else '' end) +
'IDTeam,
Position as ''М'', 
Team as ''Команда'', 
CountGames as ''И'', 
CountWin as ''В'', 
CountDraw as ''Н'', 
CountLose as ''П'', 
GoalWin as ''ГЗ'', 
GoalLose as ''ГП'',
GoalDifference as ''РМ'', 
CountPoint as ''О''' + (case when isnull(@IsDetailTable,0) = 1 then 
'
,
CountGamesHome, 
CountWinHome, 
CountDrawHome, 
CountLoseHome, 
GoalWinHome, 
GoalLoseHome, 
GoalDifferenceHome, 
CountPointHome,
CountGamesGuest, 
CountWinGuest, 
CountDrawGuest, 
CountLoseGuest, 
GoalWinGuest, 
GoalLoseGuest,
CountPointGuest,
GoalDifferenceGuest,
PosType,
LastGames ' else ' ' End) + 
'FROM #TmpTable'


if @TypeReturn = 1
begin
	--print @Query 
	exec(@Query)
end

if @TypeReturn = 2
begin
	if exists(select 1 from FactStanding 
			  where IDSport = @IDSport AND IDCountry = @IDCountry AND IDSeason = @IDSeason AND  IDLeague = @IDLeague
			  AND TypeTour = @TypeTour AND ((@TypeTour = 'Full' AND 1=1) OR
											(@TypeTour = 'LastTours' AND LastTours  = @LastTours) OR
											(@TypeTour = 'OnTour' AND TourNumber = @TourNumber) OR
											(@TypeTour = 'OnDate' AND TourDate = @TourDate)))
	begin
		delete from FactStanding 
		where IDSport = @IDSport AND IDCountry = @IDCountry AND IDSeason = @IDSeason AND  IDLeague = @IDLeague
		AND TypeTour = @TypeTour AND ((@TypeTour = 'Full' AND 1=1) OR
									(@TypeTour = 'LastTours' AND LastTours  = @LastTours) OR
									(@TypeTour = 'OnTour' AND TourNumber = @TourNumber) OR
									(@TypeTour = 'OnDate' AND TourDate = @TourDate))
	end
	--print @Query
	insert into FactStanding(
							IDSport,
							Country, 
							Season, 
							League, 
							IDCountry, 
							IDSeason, 
							IDLeague,
							TypeTour,
							LastTours,
							TourNumber,
							TourDate,
							IDTeam,
							Position, 
							Team, 
							CountGames, 
							CountWin, 
							CountDraw, 
							CountLose, 
							GoalWin, 
							GoalLose,
							GoalDifference, 
							CountPoint,
							CountGamesHome, 
							CountWinHome, 
							CountDrawHome, 
							CountLoseHome, 
							GoalWinHome, 
							GoalLoseHome, 
							GoalDifferenceHome, 
							CountPointHome,
							CountGamesGuest, 
							CountWinGuest, 
							CountDrawGuest, 
							CountLoseGuest, 
							GoalWinGuest, 
							GoalLoseGuest,
							CountPointGuest,
							GoalDifferenceGuest,
							PosType,
							LastGames) 
	exec(@Query)
end


end