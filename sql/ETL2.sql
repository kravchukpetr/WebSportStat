Use SportStat
go

DELETE FROM DimCountry
DBCC CHECKIDENT (DimCountry, RESEED, 0)
DELETE FROM DimCountry
DBCC CHECKIDENT (DimCountry, RESEED, 0)

if not exists(select * from DimCountry where Country = 'Испания') insert into DimCountry(Country, CountryEng) select 'Испания', 'Spain'
if not exists(select * from DimCountry where Country = 'Италия') insert into DimCountry(Country, CountryEng) select 'Италия', 'Italy'
if not exists(select * from DimCountry where Country = 'Англия') insert into DimCountry(Country, CountryEng) select 'Англия', 'England'
if not exists(select * from DimCountry where Country = 'Германия') insert into DimCountry(Country, CountryEng) select 'Германия', 'Germany'
if not exists(select * from DimCountry where Country = 'Франция') insert into DimCountry(Country, CountryEng) select 'Франция', 'France'
if not exists(select * from DimCountry where Country = 'Турция') insert into DimCountry(Country, CountryEng) select 'Турция', 'Turkey'
if not exists(select * from DimCountry where Country = 'Португалия') insert into DimCountry(Country, CountryEng) select 'Португалия', 'Portugal'
if not exists(select * from DimCountry where Country = 'Голландия') insert into DimCountry(Country, CountryEng) select 'Голландия', 'Netherlands'
if not exists(select * from DimCountry where Country = 'Россия') insert into DimCountry(Country, CountryEng) select 'Россия', 'Russia'


DELETE FROM DimLeague
DBCC CHECKIDENT (DimLeague, RESEED, 0)
DELETE FROM DimLeague
DBCC CHECKIDENT (DimLeague, RESEED, 0)

--Англия
if not exists(select * from DimLeague where League = 'Премьер-лига' 
	AND IDCountry = (select IDCountry from DimCountry where Country = 'Англия')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select 'Премьер-лига', (select IDCountry from DimCountry where Country = 'Англия'), 1, 'Premier League', 1, 'england_premier_league.png'
end

if not exists(select * from DimLeague where League = 'Чемпионшип' 
	AND IDCountry = (select IDCountry from DimCountry where Country = 'Англия')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select 'Чемпионшип', (select IDCountry from DimCountry where Country = 'Англия'), 1, 'Championship', 2, 'england_championship.png'
end

if not exists(select * from DimLeague where League = 'Первая лига' 
	AND IDCountry = (select IDCountry from DimCountry where Country = 'Англия')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select 'Первая лига', (select IDCountry from DimCountry where Country = 'Англия'), 1, 'League One', 3, 'england_league_one.png'
end

if not exists(select * from DimLeague where League = 'Вторая лига' 
	AND IDCountry = (select IDCountry from DimCountry where Country = 'Англия')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select 'Вторая лига', (select IDCountry from DimCountry where Country = 'Англия'), 1, 'League Two', 4, 'england_league_two.png'
end

--Германия
if not exists(select * from DimLeague where League = 'Бундеслига 1' 
	AND IDCountry = (select IDCountry from DimCountry where Country = 'Германия')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select 'Бундеслига 1', (select IDCountry from DimCountry where Country = 'Германия'), 1, 'Bundesliga 1', 1, 'germany_bundesliga.png'
end
if not exists(select * from DimLeague where League = 'Бундеслига 2' 
	AND IDCountry = (select IDCountry from DimCountry where Country = 'Германия')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select 'Бундеслига 2', (select IDCountry from DimCountry where Country = 'Германия'), 1, 'Bundesliga 2', 2, 'germany_bundesliga2.png'
end
if not exists(select * from DimLeague where League = 'Третья лига' 
	AND IDCountry = (select IDCountry from DimCountry where Country = 'Германия')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select 'Третья лига', (select IDCountry from DimCountry where Country = 'Германия'), 1, 'Liga 3', 3, 'germany_liga3.png'
end
--Испания
if not exists(select * from DimLeague where League = 'Примера' 
	AND IDCountry = (select IDCountry from DimCountry where Country = 'Испания')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select 'Примера', (select IDCountry from DimCountry where Country = 'Испания'), 1, 'Primera', 1, 'spain_primera.png'
end

if not exists(select * from DimLeague where League = 'Сегунда' 
	AND IDCountry = (select IDCountry from DimCountry where Country = 'Испания')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select 'Сегунда', (select IDCountry from DimCountry where Country = 'Испания'), 1, 'Segunda', 2, 'spain_segunda.png'
end

if not exists(select * from DimLeague where League = 'Сегунда B' 
	AND IDCountry = (select IDCountry from DimCountry where Country = 'Испания')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select 'Сегунда B', (select IDCountry from DimCountry where Country = 'Испания'), 1, 'Segunda B', 3, 'spain_segunda_b.png'
end

--Франция
if not exists(select * from DimLeague where League = 'Лига 1' 
	AND IDCountry = (select IDCountry from DimCountry where Country = 'Франция')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select 'Лига 1', (select IDCountry from DimCountry where Country = 'Франция'), 1, 'Liga 1', 1, 'france_ligue1.png'
end

if not exists(select * from DimLeague where League = 'Лига 2' 
	AND IDCountry = (select IDCountry from DimCountry where Country = 'Франция')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select 'Лига 2', (select IDCountry from DimCountry where Country = 'Франция'), 1, 'Liga 2', 2, 'france_ligue2.png'
end

if not exists(select * from DimLeague where League = 'Лига 3' 
	AND IDCountry = (select IDCountry from DimCountry where Country = 'Франция')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select 'Лига 3', (select IDCountry from DimCountry where Country = 'Франция'), 1, 'Liga 3', 3, 'france_ligue3.png'
end

--Италия
if not exists(select * from DimLeague where League = 'Серия A' 
	AND IDCountry = (select IDCountry from DimCountry where Country = 'Италия')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select 'Серия A', (select IDCountry from DimCountry where Country = 'Италия'), 1, 'Seria A', 1, 'italy_seria_a.png'
end

if not exists(select * from DimLeague where League = 'Серия B' 
	AND IDCountry = (select IDCountry from DimCountry where Country = 'Италия')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select 'Серия B', (select IDCountry from DimCountry where Country = 'Италия'), 1, 'Seria B', 2, 'italy_seria_b.png'
end

if not exists(select * from DimLeague where League = 'Серия C' 
	AND IDCountry = (select IDCountry from DimCountry where Country = 'Италия')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select 'Серия C', (select IDCountry from DimCountry where Country = 'Италия'), 1, 'Seria C', 3, 'italy_seria_c.png'
end

--Турция
if not exists(select * from DimLeague where League = 'Суперлига' 
	AND IDCountry = (select IDCountry from DimCountry where Country = 'Турция')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select 'Суперлига', (select IDCountry from DimCountry where Country = 'Турция'), 1, 'Super', 1, 'turkey_superliga.png'
end
go


--Португалия
if not exists(select * from DimLeague where League = 'Примейра лига' 
	AND IDCountry = (select IDCountry from DimCountry where Country = 'Португалия')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select 'Примейра лига', (select IDCountry from DimCountry where Country = 'Португалия'), 1, 'Primeira', 1, 'portugal_primeira.png'
end

if not exists(select * from DimLeague where League = 'Лига Про' 
	AND IDCountry = (select IDCountry from DimCountry where Country = 'Португалия')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select 'Лига Про', (select IDCountry from DimCountry where Country = 'Португалия'), 1, 'Liga Pro', 2, 'portugal_liga_pro.png'
end

if not exists(select * from DimLeague where League = 'Третья лига' 
	AND IDCountry = (select IDCountry from DimCountry where Country = 'Португалия')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select 'Третья лига', (select IDCountry from DimCountry where Country = 'Португалия'), 1, 'Campeonato', 3, 'portugal_campeonato.png'
end
go

--Голландия
if not exists(select * from DimLeague where League = 'Высшая лига' 
	AND IDCountry = (select IDCountry from DimCountry where Country = 'Голландия')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select 'Высшая лига', (select IDCountry from DimCountry where Country = 'Голландия'), 1, 'Eredivisie', 1, 'netherlands_eredivisie.png'
end

if not exists(select * from DimLeague where League = 'Первый дивизион' 
	AND IDCountry = (select IDCountry from DimCountry where Country = 'Голландия')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select 'Первый дивизион', (select IDCountry from DimCountry where Country = 'Голландия'), 1, 'Eerste divisie', 2, 'netherlands_eerste_divisie.png'
end

if not exists(select * from DimLeague where League = 'Второй дивизион' 
	AND IDCountry = (select IDCountry from DimCountry where Country = 'Голландия')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select 'Второй дивизион', (select IDCountry from DimCountry where Country = 'Голландия'), 1, 'Tweede divisie', 3, 'netherlands_tweede_divisie.png'
end

go
--Россия
if not exists(select * from DimLeague where League = 'Премьер лига' 
	AND IDCountry = (select IDCountry from DimCountry where Country = 'Россия')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select 'Премьер лига', (select IDCountry from DimCountry where Country = 'Россия'), 1, 'Premier', 1, 'russia_premier.png'
end

if not exists(select * from DimLeague where League = 'ФНЛ' 
	AND IDCountry = (select IDCountry from DimCountry where Country = 'Россия')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select 'ФНЛ', (select IDCountry from DimCountry where Country = 'Россия'), 1, 'FNL', 2, 'russia_fnl.png'
end

if not exists(select * from DimLeague where League = 'ПФЛ' 
	AND IDCountry = (select IDCountry from DimCountry where Country = 'Россия')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select 'ПФЛ', (select IDCountry from DimCountry where Country = 'Россия'), 1, 'PFL', 3, 'russia_pfl.png'
end



DELETE FROM DimLeagueSource
DBCC CHECKIDENT (DimLeagueSource, RESEED, 0)

declare @IDCountry int
declare @IDLeague int
select @IDCountry = IDCountry from DimCountry where Country = 'Испания'
select @IDLeague = IDLeague from DimLeague where League = 'Примера'
if not exists(select 1 from DimLeagueSource where Country = 'Испания' and League = 'Примера')
begin
	insert into DimLeagueSource (CurrentSource, Country, IDCountry, IDLeague, League)
	select  'http://football.sport-express.ru/foreign/spain/laleague/[Season]/calendar/tours/', 'Испания', @IDCountry, @IDLeague, 'Примера' 
end

select @IDCountry = IDCountry from DimCountry where Country = 'Италия'
select @IDLeague = IDLeague from DimLeague where League = 'Серия A'
if not exists(select 1 from DimLeagueSource where Country = 'Италия' and League = 'Серия A')
begin
	insert into DimLeagueSource (CurrentSource, Country, IDCountry, IDLeague, League)
	select  'http://football.sport-express.ru/foreign/italy/seriaa/[Season]/calendar/tours/', 'Италия', @IDCountry, @IDLeague, 'Серия A'  
end

select @IDCountry = IDCountry from DimCountry where Country = 'Англия'
select @IDLeague = IDLeague from DimLeague where League = 'Премьер-лига'
if not exists(select 1 from DimLeagueSource where Country = 'Англия' and League = 'Премьер-лига')
begin
	insert into DimLeagueSource (CurrentSource, Country, IDCountry, IDLeague, League)
	select  'http://football.sport-express.ru/foreign/england/premier/[Season]/calendar/tours/', 'Англия', @IDCountry, @IDLeague, 'Премьер-лига'
end

select @IDCountry = IDCountry from DimCountry where Country = 'Германия'
select @IDLeague = IDLeague from DimLeague where League = 'Бундеслига 1'
if not exists(select 1 from DimLeagueSource where Country = 'Германия' and League = 'Бундеслига 1')
begin
	insert into DimLeagueSource (CurrentSource, Country, IDCountry, IDLeague, League)
	select  'http://football.sport-express.ru/foreign/german/bundes1/[Season]/calendar/tours/', 'Германия', @IDCountry, @IDLeague, 'Бундеслига 1'
end

select @IDCountry = IDCountry from DimCountry where Country = 'Франция'
select @IDLeague = IDLeague from DimLeague where League = 'Лига 1'
if not exists(select 1 from DimLeagueSource where Country = 'Франция' and League = 'Лига 1')
begin
	insert into DimLeagueSource (CurrentSource, Country, IDCountry, IDLeague, League)
	select  'http://football.sport-express.ru/foreign/france/league1/[Season]/calendar/tours/', 'Франция', @IDCountry, @IDLeague, 'Лига 1'
end

select @IDCountry = IDCountry from DimCountry where Country = 'Турция'
select @IDLeague = IDLeague from DimLeague where League = 'Суперлига'
if not exists(select 1 from DimLeagueSource where Country = 'Турция' and League = 'Суперлига')
begin
	insert into DimLeagueSource (CurrentSource, Country, IDCountry, IDLeague, League)
	select  'https://www.sport-express.ru/football/L/foreign/turkey/super/[Season]/calendar/tours/', 'Турция', @IDCountry, @IDLeague, 'Суперлига'
end

select @IDCountry = IDCountry from DimCountry where Country = 'Португалия'
select @IDLeague = IDLeague from DimLeague where League = 'Суперлига'
if not exists(select 1 from DimLeagueSource where Country = 'Португалия' and League = 'Суперлига')
begin
	insert into DimLeagueSource (CurrentSource, Country, IDCountry, IDLeague, League)
	select  'https://www.sport-express.ru/football/L/foreign/portugal/super/[Season]/calendar/tours/', 'Португалия', @IDCountry, @IDLeague, 'Суперлига'
end
select @IDCountry = IDCountry from DimCountry where Country = 'Голландия'
select @IDLeague = IDLeague from DimLeague where League = 'Высшая лига'
if not exists(select 1 from DimLeagueSource where Country = 'Голландия' and League = 'Высшая лига')
begin
	insert into DimLeagueSource (CurrentSource, Country, IDCountry, IDLeague, League)
	select  'https://www.sport-express.ru/football/L/foreign/netherlands/highest/[Season]/calendar/tours/', 'Голландия', @IDCountry, @IDLeague, 'Высшая лига'
end

select @IDCountry = IDCountry from DimCountry where Country = 'Россия'
select @IDLeague = IDLeague from DimLeague where League = 'Премьер лига'
if not exists(select 1 from DimLeagueSource where Country = 'Россия' and League = 'Премьер лига')
begin
	insert into DimLeagueSource (CurrentSource, Country, IDCountry, IDLeague, League)
	select  'https://www.sport-express.ru/football/L/russia/premier/[Season]/calendar/tours/', 'Россия', @IDCountry, @IDLeague, 'Премьер лига'
end

select @IDCountry = IDCountry from DimCountry where Country = 'Испания'
select @IDLeague = IDLeague from DimLeague where League = 'Сегунда'
if not exists(select 1 from DimLeagueSource where Country = 'Испания' and League = 'Сегунда')
begin
	insert into DimLeagueSource (CurrentSource, Country, IDCountry, IDLeague, League)
	select  'https://www.sport-express.ru/football/L/foreign/spain/segunda/[Season]/calendar/tours/', 'Испания', 
	@IDCountry, @IDLeague, 'Сегунда' 
end

select @IDCountry = IDCountry from DimCountry where Country = 'Англия'
select @IDLeague = IDLeague from DimLeague where League = 'Чемпионшип'
if not exists(select 1 from DimLeagueSource where Country = 'Англия' and League = 'Чемпионшип')
begin
	insert into DimLeagueSource (CurrentSource, Country, IDCountry, IDLeague, League)
	select  'https://www.sport-express.ru/football/L/foreign/england/champion/[Season]/calendar/tours/', 'Англия', 
	@IDCountry, @IDLeague, 'Чемпионшип' 
end

select @IDCountry = IDCountry from DimCountry where Country = 'Германия'
select @IDLeague = IDLeague from DimLeague where League = 'Бундеслига 2'
if not exists(select 1 from DimLeagueSource where Country = 'Германия' and League = 'Бундеслига 2')
begin
	insert into DimLeagueSource (CurrentSource, Country, IDCountry, IDLeague, League)
	select  'https://www.sport-express.ru/football/L/foreign/german/bundes2/[Season]/calendar/tours/', 'Германия', 
	@IDCountry, @IDLeague, 'Бундеслига 2' 
end

select @IDCountry = IDCountry from DimCountry where Country = 'Германия'
select @IDLeague = IDLeague from DimLeague where League = 'Бундеслига 2'
if not exists(select 1 from DimLeagueSource where Country = 'Германия' and League = 'Бундеслига 2')
begin
	insert into DimLeagueSource (CurrentSource, Country, IDCountry, IDLeague, League)
	select  'https://www.sport-express.ru/football/L/foreign/german/bundes2/[Season]/calendar/tours/', 'Германия', 
	@IDCountry, @IDLeague, 'Бундеслига 2' 
end


select @IDCountry = IDCountry from DimCountry where Country = 'Франция'
select @IDLeague = IDLeague from DimLeague where League = 'Лига 2'
if not exists(select 1 from DimLeagueSource where Country = 'Франция' and League = 'Лига 2')
begin
	insert into DimLeagueSource (CurrentSource, Country, IDCountry, IDLeague, League)
	select  'https://www.sport-express.ru/football/L/foreign/france/league2/[Season]/calendar/tours/', 'Франция', 
	@IDCountry, @IDLeague, 'Лига 2' 
end

select @IDCountry = IDCountry from DimCountry where Country = 'Италия'
select @IDLeague = IDLeague from DimLeague where League = 'Серия B'
if not exists(select 1 from DimLeagueSource where Country = 'Италия' and League = 'Серия B')
begin
	insert into DimLeagueSource (CurrentSource, Country, IDCountry, IDLeague, League)
	select  'https://www.sport-express.ru/football/L/foreign/italy/seriab/[Season]/calendar/tours/', 'Италия', 
	@IDCountry, @IDLeague, 'Серия B' 
end


update DimLeague
set LeagueCurrentSource = LS.IDLeagueCurrentSource
from DimLeague L
join DimLeagueSource LS on L.IDLeague = LS.IDLeague and L.IDCountry = LS.IDCountry

if not exists(select * from DimSeason where Season = '2017-2018')
begin
	insert into DimSeason(Season, IsCurrentSeason) select '2017-2018', 0
end

if not exists(select * from DimSeason where Season = '2018-2019')
begin
	insert into DimSeason(Season, IsCurrentSeason) select '2018-2019', 1
end

INSERT INTO DimSportCountryLink (IDSport, IDCountry, Sport, Country)
select 1 as IDSport, c.IDCountry, 'Футбол', c.Country
from DimCountry c

TRUNCATE TABLE DimPosLink;

INSERT INTO DimPosLink(IDSport, IDCountry, IDLeague, Sport, Country, League, PosFrom, PosTo,PosType, Season, IDSeason)
SELECT scl.IDSport, c.IDCountry, l.IDLeague, scl.Sport, c.Country, l.League, 1, 4, 1, s.Season, s.IDSeason
from DimSportCountryLink scl
join DimCountry c on scl.IDCountry = c.IDCountry
join DimLeague l on c.IDCountry = l.IDCountry
join DimSeason s on s.IsCurrentSeason = 1
union all
SELECT scl.IDSport, c.IDCountry, l.IDLeague, scl.Sport, c.Country, l.League, 5, 6, 2, s.Season, s.IDSeason
from DimSportCountryLink scl
join DimCountry c on scl.IDCountry = c.IDCountry
join DimLeague l on c.IDCountry = l.IDCountry and l.IsPrimary = 1
join DimSeason s on s.IsCurrentSeason = 1
union all
SELECT scl.IDSport, c.IDCountry, l.IDLeague, scl.Sport, c.Country, l.League, 18, 20, 3, s.Season, s.IDSeason
from DimSportCountryLink scl
join DimCountry c on scl.IDCountry = c.IDCountry
join DimLeague l on c.IDCountry = l.IDCountry
join DimSeason s on s.IsCurrentSeason = 1