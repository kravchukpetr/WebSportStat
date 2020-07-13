select * from DimPosLink
select * from FactStanding where Season = '2016-2017' and Country = 'Англия'

update FactStanding 
set PosType = NULL
where Season = '2016-2017' and Country = 'Англия'



select * from DimLeague
select * from sport_standing

alter table DimLeague add IsPrimary int 

update DimLeague
set IsPrimary = 1

select * from sport_country
select * from sport_league
select * from sport_country
select * from DimCountry

select * from FactResult where IDCountry = 25
select * from sport_result where IDCountry_id = 25
select * from sport_result where Country = 'Германия'
select * from sport_league


update sport_league
set IsPrimary = 1

select * from DimLeagueType

select * from FactStanding

alter table FactStanding add PosType int

update FactStanding
set PosType = case when Position between 1 and 4 then 1
				   when Position between 5 and 6 then 2
				   when Position between 18 and 20 then 3
			 end 

update sport_standing
set PosType = case when Position between 1 and 4 then 1
				   when Position between 5 and 6 then 2
				   when Position between 18 and 20 then 3
			 end

select * from sport_standing

select * from DimSport
select * from DimCountry
select * from DimLeague
select * from DimSportCountryLink

SELECT  @STRING = COALESCE(@STRING + ', ' + '"' + NameOfField + '"', '"' + NameOfField + '"')
FROM    #MetaData  

STUFF( (SELECT 
--                  DISTINCT 
                    ',' + QUOTENAME( c.NameOfField ) 
            FROM #MetaData AS  c

            FOR XML PATH('')

declare @STRING varchar(500)

select abc = STUFF((select ', ' + res.fld
from (
select top 5  cast(GoalHome as varchar) + ':' + cast(GoalGuest as varchar) 
			  + ' ' + TeamHome + ' - '  + TeamGuest + ' ' + convert(varchar, MatchDate, 104) as fld
from FactResult where Country = 'Италия' AND League = 'Серия A' AND Season = '2019-2020'
And (TeamHome = 'Парма' OR TeamGuest = 'Парма') AND GoalHome is not null
order by MatchDate desc
) res
FOR XML PATH('')), 1, 1, ''
)

select top 100 Sport, * from FactResult

alter table FactResult add Sport varchar(50)
alter table FactResult add IDSport varchar(50)

update FactResult
set Sport = 'Футбол',
	IDSport = 1

alter table FactStanding add LastGames varchar(1000);
alter table FactStanding add Sport varchar(50);

select top 100 * from sport_standing
select top 100 * from FactStanding

1:2 Астон Вилла - Ливерпуль 02.11.2019,2:1 Ливерпуль - Тоттенхэм Хотспур 27.10.2019,1:1 Манчестер Юнайтед - Ливерпуль 20.10.2019,2:1 Ливерпуль - Лестер 05.10.2019,0:1 Шеффилд Юнайтед - Ливерпуль 28.09.2019
 1:1 Фиорентина - Парма 03.11.2019, 0:1 Парма - Верона 29.10.2019, 2:2 Интер - Парма 26.10.2019, 5:1 Парма - Дженоа 20.10.2019, 1:0 СПАЛ - Парма 05.10.2019
 
 update FactStanding
 set Sport = 'Футбол'

 select top 100 * from sport_result
 select top 100 * from sport_standing where season = '2019-2020' and Country = 'Англия'

exec pCalcAllStand
exec pReLoadToDjango

select * from sport_league
select * from sport_standing

update sport_standing
set LastGames = Team + ', ' + LastGames


update sport_league
set IsPrimary = 1

alter table DimTeam add ImgSmall  VARBINARY (MAX) NULL 
alter table DimTeam add ImgBig  VARBINARY (MAX) NULL 
alter table DimTeam add YearFound int null	
alter table DimTeam add Color varchar(100) null
alter table DimTeam add Stadium varchar(100) null
alter table DimTeam add StadiumNumber int null
alter table DimTeam add Coach varchar(100) null
alter table DimTeam add IsInfoExist int null


select max(IDTeam) from DimTeam;
delete from DimTeam where IDTeam > 2443;
select * from DimTeam where ImgSmall is not null
select * from DimTeam where Team = 'Хоффенхайм  - Майнц'

select * from sport_team where IDCountry_id = 1 and ImgBig is not null
select * from sport_team where Team = 'Барселона'
select * from DimTeam where Team = 'Барселона'

select * from sport_team where Team = 'Гранада'
select * from DimTeam where Team = 'Гранада'

SELECT DATALENGTH(ImgBig) as ln, *
from DimTeam where Team = 'Барселона'
--ImgBig is not null

create table _tstimg(img varbinary(max))
select * from _tstimg

update DimTeam
set  IsInfoExist = null

update sport_team 
set ImgBig = 'team_' + cast(st.IDTeam as varchar) + '_big.png',
	ImgSmall = 'team_' + cast(st.IDTeam as varchar) + '_small.png'
from sport_team st
left join DimTeam dt on st.Team = dt.Team
where dt.ImgSmall is not null 

select * from sport_team  where Team = 'Барселона'
select * from sport_team  where Team = 'Арсенал'

update sport_team 
set ImgSmall = null,
	ImgBig = null
--where Team = 'Арсенал'

select *from DimCountry
select * from sport_country


exec pExtractFilesToDjango


update sport_team
set ImgBig = dt.ImgBig, 
	YearFound = dt.YearFound, 
	Color = dt.Color, 
	Stadium = dt.Stadium, 
	StadiumNumber = dt.StadiumNumber, 
	Coach = dt.Coach
from sport_team st
join DimTeam dt on st.Team = dt.Team
where dt.IDCountry = 1

select* from DimTeam
select* from DimCountry
select * from sport_country
select * from DimCountry

select * from FactResult where TeamHome = 'Кельн - Бавария'
select * from FactResult where TeamGuest = 'Кельн - Бавария'
select * from DimTeam where Team = 'Боруссия Д - Аугсбург'

select * from DimLeagueSource
select * from FactResult where IDTeamHome >=2326

select distinct Year(MatchDate) from FactResult where IDTeamGuest >=2326 or  IDTeamHome >=2326
select * from FactResult where IDTeamGuest >=2326 or  IDTeamHome >=2326
select * from DimTeam where IDTeam >=2326

select * from sport_standing

--delete from FactResult where IDTeamGuest >=2326 or  IDTeamHome >=2326
--delete from DimTeam where IDTeam >=2326

exec pReLoadToDjango
exec pExtractFilesToDjango
select count(*) from DimTeam

select * from sport_standing
select * from sport_country

select * from DimSport
 alter table DimSport add SportEng varchar(50) null

update DimSport
set SportEng = 'Football'
where sport= 'Футбол'


update DimSport
set SportEng = 'Hockey'
where sport= 'Хоккей'

update sport_sport
set SportEng = 'Football'
where sport= 'Футбол'


update sport_sport
set SportEng = 'Hockey'
where sport= 'Хоккей'

select * 
from FactResult where Season = '2019-2020' and Country = 'Италия' and
(TeamHome = 'Аталанта' or TeamGuest = 'Аталанта')
order by MatchDate


select * from DimLeagueType
select * from DimLeague

alter table DimLeague add LeagueImg varbinary(max)
alter table DimLeague add LeagueImgSrc varchar(100)



Update DimLeague
set LeagueImgSrc = 'england_premier_league.png'
where League = 'Премьер-лига' AND IDCountry = (select IDCountry from DimCountry where Country = 'Англия')

Update DimLeague
set LeagueImgSrc = 'germany_bundesliga.png'
where League = 'Бундеслига 1' AND IDCountry = (select IDCountry from DimCountry where Country = 'Германия')

Update DimLeague
set LeagueImgSrc = 'spain_primera.png'
where League = 'Примера' AND IDCountry = (select IDCountry from DimCountry where Country = 'Испания')

Update DimLeague
set LeagueImgSrc = 'france_ligue1.png'
where League = 'Лига 1' AND IDCountry = (select IDCountry from DimCountry where Country = 'Франция')

Update DimLeague
set LeagueImgSrc = 'italy_seria_a.png'
where League = 'Серия A' AND IDCountry = (select IDCountry from DimCountry where Country = 'Италия')


Update DimLeague
set LeagueImgSrc = 'turkey_superliga.png'
where League = 'Суперлига' AND IDCountry = (select IDCountry from DimCountry where Country = 'Турция')

Update DimLeague
set LeagueImgSrc = 'portugal_primeira.png'
where League = 'Примейра лига' AND IDCountry = (select IDCountry from DimCountry where Country = 'Португалия')

Update DimLeague
set LeagueImgSrc = 'netherlands_eredivisie.png'
where League = 'Высшая лига' AND IDCountry = (select IDCountry from DimCountry where Country = 'Голландия')

Update DimLeague
set LeagueImgSrc = 'russia_premier.png'
where League = 'Премьер лига' AND IDCountry = (select IDCountry from DimCountry where Country = 'Россия')

select * from DimLeague
select * from sport_league

update DimLeague
set LeagueEng = 'FNL'
where IDLeague = 28


update DimLeague
set LeagueEng = 'PFL'
where IDLeague = 29



select * from DimLeague
select * from sport_league order by IDLeague
select * from sport_standing

select * from FactResult

select dl.IDLeague, dl.League, count(*) 
from FactResult fr
join DimLeague dl on fr.IDLeague = dl.IDLeague
group by dl.IDLeague, dl.League
order by dl.IDLeague, dl.League

select * from DimLeagueSource
select * from FactStanding

select distinct League from FactStanding where Country = 'Португалия'

Update FactResult
set League = 'Примейра лига'
where IDCountry = 28 And IDLeague = 10


Update FactResult
set League = 'Примейра лига'
where IDCountry = 28 And IDLeague = 10


Update FactStanding
set League = 'Примейра лига'
where Country = 'Португалия'


update FactResult
set IDLeague = dl.IDLeague
from FactResult fr
join DimLeague dl on fr.League = dl.League

select League, count(*) from FactStanding
group by League

select IDLeague, count(*) from FactStanding
group by IDLeague

update FactStanding
set IDLeague = dl.IDLeague
from FactStanding fr
join DimLeague dl on fr.League = dl.League


select *
from FactResult fr
left join DimLeague dl on fr.League = dl.League
where dl.League is null



select dl.IDLeague, dl.League, count(*) 
from FactResult fr
join sport_league dl on fr.IDLeague = dl.IDLeague
group by dl.IDLeague, dl.League
order by dl.IDLeague, dl.League

select dl.IDLeague, dl.League, count(*) 
from FactStanding fr
join DimLeague dl on fr.IDLeague = dl.IDLeague
group by dl.IDLeague, dl.League
order by dl.IDLeague, dl.League




select dl.IDLeague, dl.League, count(*) 
from sport_result fr
join sport_league dl on fr.IDLeague_id = dl.IDLeague
group by dl.IDLeague, dl.League
order by dl.IDLeague, dl.League


select dl.IDLeague, dl.League, count(*) 
from sport_standing fr
join sport_league dl on fr.IDLeague_id = dl.IDLeague
group by dl.IDLeague, dl.League
order by dl.IDLeague, dl.League

select * from sport_result

select * from DimLeagueType
select * from DimLeagueSource
select * from DimLeague
select * from DimCountry

delete from DimLeagueSource where IDLeagueCurrentSource > 15
delete from DimLeague where IDLeague >=28

DBCC CHECKIDENT (DimLeague, RESEED, 27)
DBCC CHECKIDENT (DimLeagueSource, RESEED, 15)



update DimLeagueSource
set IDCountry = 10,
	IDLeague = 27
where IDLeagueCurrentSource =  15


delete from DimLeagueSource where IDLeagueCurrentSource > 15
delete from DimLeague where IDLeague >=28

update DimLeague
set IDCountry = 10, 
	IDLeagueType = 1,
	IsPrimary = 1
where IDLeague = 27

delete from DimLeague where IDLeague >=28

insert into DimLeagueType(LeagueType) select 'Суперкубок'
insert into DimLeagueSource(CurrentSource, Country, IDCountry, IDLeague, League)



select * from FactPlayer
alter table FactPlayer add GoalsGK int

select * from FactPlayer
select * from FactPlayer where team = 'Чарльтон'
select * from DimNation


select Team, count(*) from FactPlayer
group by Team


select * from fGetCountrySource(1, null, 1) where IsMainCountry = 0 and LeagueType = 1
select * from fGetCountrySource(1, null, 1) where IsMainCountry = 1 and LeagueType = 1 and IsPrimary <> 1
select * from fGetCountrySource(1, null, 1) where IsMainCountry = 1 and LeagueType = 1 and IsPrimary = 1 and Country = 'Англия'

select CurrentSource, Country from fGetCountrySource(1, null, 1) 
where IsMainCountry = 1 and LeagueType = 1 and Country = 'Англия' order by Country

select * from DimLeague where IDLeague = 72

update DimLeague
set IDLeagueType = 7,
	IsPrimary = 1
where IDLeague = 72

select * from fGetCountrySource(2, 'Англия', 0)
select * from fGetCountrySource(2, 'Франция', 0)

select * from DimLeague
select 
LS.CurrentSource, C.Country, L.League, LS.* 
from DimCountry C
join DimLeague L on C.IDCountry = L.IDCountry
left join DimLeagueSource LS on L.LeagueCurrentSource = LS.IDLeagueCurrentSource
WHERE C.Country = 'Франция'
--OR (@Type = 2 AND C.Country = @Country)

--select * 
update DimLeague
set LeagueCurrentSource = LS.IDLeagueCurrentSource
from DimLeague dl
join  DimLeagueSource LS on dl.IDLeague = LS.IDLeague

select * from DimLeagueSource
select * from DimLeague
select * from DimLeagueType

insert into DimLeagueType(LeagueType) select 'Кубок лиги'

delete from DimLeagueSource where IDLeagueCurrentSource IN (63)
select * from  DimLeagueSource where IDLeagueCurrentSource = 63



select * from DimTeam where Team like '%Рига%'
select * from DimTeam where Team like '%Плимут%'
Плимут

select Country, IsMain from DimCountry

select * from DimCountry
alter table DimCountry add IsLoadData int

update DimCountry
set IsLoadData = 1
where IDCountry <=17

--2644
--322

select * 
from FactPlayer fp
left join DimTeam dt on fp.Team = dt.Team
where dt.Team is null


select count(*) 
from FactPlayer fp
left join DimTeam dt on fp.Team = dt.Team
where dt.Team is null

delete FactPlayer
from FactPlayer fp
left join DimTeam dt on fp.Team = dt.Team
where dt.Team is null

update DimCountry
set IsLoadData = 1
where country not in (
select dc.Country 
from DimCountry dc
left join 
(
select c.Country, count(*) cnt
from FactPlayer fp
join DimTeam dt on fp.Team = dt.Team
join DimCountry c on dt.IDCountry = c.IDCountry
group by c.Country
) cnt on dc.Country = cnt.Country
where cnt.Country is null
)

select * from DimCountry

update DimCountry
set IDSeasonType = 1
where IsLoadData = 1 and IDCountry <=40

update DimCountry
set IDSeasonType = 2
where IsLoadData Is NUll and IDCountry <=40


https://sport-express.ru/football/L/foreign/ireland/premier/[Season]/calendar/tours/

select * from DimLeagueSource

select count(*) from FactPlayer
select * from DimTeam where Team like '%Шеффилд%'
select * from DimTeam where Team = 'Зестафони'

select * from DimSeason

alter table DimSeason add IDSeasonType int
alter table DimCountry add IDSeasonType int

update DimSeason 
set IDSeasonType = 1

insert into DimSeason(Season, IDSeasonType) select '2005', 2
insert into DimSeason(Season, IDSeasonType) select '2006', 2
insert into DimSeason(Season, IDSeasonType) select '2007', 2
insert into DimSeason(Season, IDSeasonType) select '2008', 2
insert into DimSeason(Season, IDSeasonType) select '2009', 2
insert into DimSeason(Season, IDSeasonType) select '2010', 2
insert into DimSeason(Season, IDSeasonType) select '2011', 2
insert into DimSeason(Season, IDSeasonType) select '2012', 2
insert into DimSeason(Season, IDSeasonType) select '2013', 2
insert into DimSeason(Season, IDSeasonType) select '2014', 2
insert into DimSeason(Season, IDSeasonType) select '2015', 2
insert into DimSeason(Season, IDSeasonType) select '2016', 2
insert into DimSeason(Season, IDSeasonType) select '2017', 2
insert into DimSeason(Season, IDSeasonType) select '2018', 2
insert into DimSeason(Season, IDSeasonType) select '2019', 2
insert into DimSeason(Season, IDSeasonType, IsCurrentSeason) select '2020', 2, 1


select * from fGetSeason(2, NULL, 2)
select * from fGetSeason(1, NULL, 2)

select * from fGetCountrySource(1, NULL, 1)

select  * from DimCountry
select  * from DimNation

select top 100 * from FactResult order by IDFactResult Desc

select top 100 * from FactResult 
where Country = 'Уэльс'
order by IDFactResult Desc

select Season, count(*) from FactResult 
where Country = 'Уэльс'
group by Season
order by Season

select * from DimLeague
select * from DimCountry


select * from FactLoadError


update DimCountry
set IsMain = 0
where Country = 'Украина'

select * from DimCountry where IsMain = 1

exec pGetCountryList 1, 1

exec pGetLeagueListByCountry 'Англия', 1

exec SportStat.dbo.pLoadTable '2019-2020', 'Англия', 'Премьер-лига', 'Всего', 0, 'Full', NULL, NULL, NULL
exec SportStat.dbo.pLoadTable '2019-2020', 'Германия', 'Премьер-лига', 'Всего', 0, 'Full', NULL, NULL, NULL

exec pGetResultsForPredict 7, 'Англия', 'Премьер-лига', '2019-2020', NULL, NULL,NULL,'1'

update DimCountry
set IsLoadData = 1
where IsLoadData is null

select Country, count(*)
from FactStanding
group by Country

exec pGetLeagueList 'Австрия'

select * from FactLogs order by IDFactLog desc
exec pGetTourList 'Англия', 'Премьер-лига', '2019-2020'
exec pGetTourList 'Австрия', 'Бундеслига', '2019-2020'

select *
--distinct convert(varchar, Tour) as Tour, Tour as TourNumber
from FactResult 
where (Country = 'Австрия' and League =  'Бундеслига' AND Season = '2019-2020') 

select *from DimCountry

exec pGetResultsForPredict 7, 'Австрия', 'Бундеслига', '2019-2020', NULL, NULL,NULL,NULL

update FactResult 
set Tour = Tour + 1
where (Country = 'Австрия' and League =  'Бундеслига' AND Season = '2019-2020') 

select distinct Country, Season, League from FactResult where Tour = 0

declare @Country varchar(100) 
declare @Season varchar(100)  
declare @League varchar(100)  
DECLARE season_cursor CURSOR FOR  

select distinct Country, Season, League from FactResult where Tour = 0   

--Season
OPEN season_cursor    
FETCH NEXT FROM season_cursor   
INTO @Country, @Season, @League  
  
WHILE @@FETCH_STATUS = 0  
BEGIN  

	update FactResult 
	set Tour = Tour + 1
	where (Country = @Country and League = @League AND Season = @Season) 


FETCH NEXT FROM season_cursor   
INTO @Country, @Season, @League
END   

CLOSE season_cursor  
DEALLOCATE season_cursor


select * from DimCountry
select * from DimLeague where IDCountry = 4
select * from DimLeagueSource where Country = 'Австрия'
select * from DimLeagueType

select top 100 * from FactResult where Country = 'Англия' and League = 'Кубок лиги'
alter table FactResult add Stage varchar(10)

select * from DimResultType

exec pSaveResult 1, '2016-2017' , 'Англия', 'Кубок лиги', NULL, NULL, 
				'Манчестер Юнайтед', 'Саутгемптон', 3, 2, 3, , , 0, 'Финал'


select distinct Stage 
from FactResult 
where League = 'Кубок лиги'
order by IDFactResult desc

select count(*) from FactResult where Country = 'Германия' and League = 'Кубок'
alter table FactResult alter column Stage varchar(30)
exec pSaveResult 1, '2019-2020' , 'Германия', 'Кубок', NULL, NULL, 'Оснабрюк', 'РБ Лейпциг', 2, 3, 1, NULL, NULL, 0, '1/32 финала'
select * from FactLoadError order by IDLoadError desc
select Stage, *
from FactResult 
--where Stage like '%32%'
order by IDFactResult desc

--delete from FactResult  where IDFactResult between 182751 and 182751
select * from DimLeague


select * from Dimteam where Team = 'Барселона'
select * from FactStanding where Season = '2019-2020' and Country = 'Испания'
select * from FactStanding where Season = '2020'

select * from DimCountry
select * from DimLeague where IDLeague IN (8, 34)
select * from DimCountry where IDCountry IN (1, 14)

truncate table FactStanding

select * from DimCountry

exec pExtractFilesToDjango 0,0,1


select * from FactLogs order by IDFactLog desc

 select * from FactResult where (TeamGuest = 'Бавария' or TeamHome = 'Бавария' ) and Season = '2019-2020'
 order by MatchDate desc

  select TeamHome, TeamGuest, count(*) 
  from FactResult 
  where Country = 'Германия' and Season = '2019-2020' and League = 'Кубок'
  group by TeamHome, TeamGuest
  having count(*) > 1


  select * from FactResult order by IDFactResult desc

  select * from DimLeagueType


select * from FactResult where Country = 'Германия' and Season = '2019-2020'
and League = 'Бундеслига 2'
 order by MatchDate desc

 
select * from FactResult where Country = 'Дания' and Season = '2019-2020'
--and League = 'Бундеслига 1'
 order by MatchDate desc

 select * from DimLeagueSource where IDCountry = (select IDCountry from DimCountry where Country = 'Германия')
 select * from DimLeagueSource where IDCountry = (select IDCountry from DimCountry where Country = 'Дания')

 select * from FactPredict fp
 join FactResult fr on fp.IDFactResult = fr.IDFactResult
 where cast(DateCreate as date) = cast(getdate() as date)
 order by fp.IDFactPredict desc


 select Season, count(*) 
 from FactResult where Country = 'Кипр'
 group by Season
 order by Season

 select * from FactStanding where Country = 'Кипр' and Season = '2011-2012'

  
select * from FactResult where Country = 'Кипр' and Season = '2011-2012'
select * from FactPredict order by IDFactPredict desc
select * from FactResult where IDSport is null

update  FactResult 
set IDSport = 1
where IDSport is null

INSERT INTO [dbo].[sport_predict]
           ([Sport]
           ,[Country]
           ,[Season]
           ,[League]
           ,[Tour]
           ,[MatchDate]
           ,[TeamHome]
           ,[TeamGuest]
           ,[GoalHome]
           ,[GoalGuest]
           ,[PredictHome]
           ,[PredictGuest]
           ,[ProdHome]
           ,[ProdDraw]
           ,[ProdGuest]
           ,[PredictType]
           ,[DateCreate]
           ,[IDCountry_id]
           ,[IDLeague_id]
           ,[IDSeason_id]
           ,[IDTeamGuest_id]
           ,[IDTeamHome_id]
		   ,[IDSport_id]
		   ,[IDResult_id])
select 
 f.Sport
,f.Country
,f.Season
,f.League
,f.Tour
,f.MatchDate
,f.TeamHome
,f.TeamGuest
,f.GoalHome
,f.GoalGuest
,fp.PredictHome
,fp.PredictGuest
,fp.ProbHome
,fp.ProbDraw
,fp.ProbGuest
,fp.PredictType
,fp.DateCreate
,sc.id as IDCountry_id
,sl.id as IDLeague_id
,ss.id as IDSeason_id
,sth.id as IDTeamHome_id
,stg.id as IDTeamGuest_id
,ssp.id as IDSport_id
,sr.id
from FactPredict fp
join FactResult f on fp.IDFactResult = f.IDFactResult
join sport_result sr on f.IDFactResult = sr.IDFactResult
join DimCountry c on f.IDCountry =c.IDCountry
join sport_country sc on c.Country = sc.Country
join DimLeague l on f.IDLeague = L.IDLeague
join sport_league sl on l.League = sl.League
join DimSeason s on f.IDSeason = s.IDSeason
join sport_season ss on s.Season = ss.Season
join DimTeam th on f.TeamHome = th.Team
join sport_team sth on th.Team = sth.Team
join DimTeam tg on f.TeamGuest = tg.Team
join sport_team stg on tg.Team = stg.Team
join DimSport ds on f.IDSport =ds.IDSport
join sport_sport ssp on ds.Sport = ssp.Sport