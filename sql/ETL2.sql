Use SportStat
go

DELETE FROM DimCountry
DBCC CHECKIDENT (DimCountry, RESEED, 0)
DELETE FROM DimCountry
DBCC CHECKIDENT (DimCountry, RESEED, 0)

if not exists(select * from DimCountry where Country = '�������') insert into DimCountry(Country, CountryEng) select '�������', 'Spain'
if not exists(select * from DimCountry where Country = '������') insert into DimCountry(Country, CountryEng) select '������', 'Italy'
if not exists(select * from DimCountry where Country = '������') insert into DimCountry(Country, CountryEng) select '������', 'England'
if not exists(select * from DimCountry where Country = '��������') insert into DimCountry(Country, CountryEng) select '��������', 'Germany'
if not exists(select * from DimCountry where Country = '�������') insert into DimCountry(Country, CountryEng) select '�������', 'France'
if not exists(select * from DimCountry where Country = '������') insert into DimCountry(Country, CountryEng) select '������', 'Turkey'
if not exists(select * from DimCountry where Country = '����������') insert into DimCountry(Country, CountryEng) select '����������', 'Portugal'
if not exists(select * from DimCountry where Country = '���������') insert into DimCountry(Country, CountryEng) select '���������', 'Netherlands'
if not exists(select * from DimCountry where Country = '������') insert into DimCountry(Country, CountryEng) select '������', 'Russia'


DELETE FROM DimLeague
DBCC CHECKIDENT (DimLeague, RESEED, 0)
DELETE FROM DimLeague
DBCC CHECKIDENT (DimLeague, RESEED, 0)

--������
if not exists(select * from DimLeague where League = '�������-����' 
	AND IDCountry = (select IDCountry from DimCountry where Country = '������')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select '�������-����', (select IDCountry from DimCountry where Country = '������'), 1, 'Premier League', 1, 'england_premier_league.png'
end

if not exists(select * from DimLeague where League = '����������' 
	AND IDCountry = (select IDCountry from DimCountry where Country = '������')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select '����������', (select IDCountry from DimCountry where Country = '������'), 1, 'Championship', 2, 'england_championship.png'
end

if not exists(select * from DimLeague where League = '������ ����' 
	AND IDCountry = (select IDCountry from DimCountry where Country = '������')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select '������ ����', (select IDCountry from DimCountry where Country = '������'), 1, 'League One', 3, 'england_league_one.png'
end

if not exists(select * from DimLeague where League = '������ ����' 
	AND IDCountry = (select IDCountry from DimCountry where Country = '������')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select '������ ����', (select IDCountry from DimCountry where Country = '������'), 1, 'League Two', 4, 'england_league_two.png'
end

--��������
if not exists(select * from DimLeague where League = '���������� 1' 
	AND IDCountry = (select IDCountry from DimCountry where Country = '��������')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select '���������� 1', (select IDCountry from DimCountry where Country = '��������'), 1, 'Bundesliga 1', 1, 'germany_bundesliga.png'
end
if not exists(select * from DimLeague where League = '���������� 2' 
	AND IDCountry = (select IDCountry from DimCountry where Country = '��������')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select '���������� 2', (select IDCountry from DimCountry where Country = '��������'), 1, 'Bundesliga 2', 2, 'germany_bundesliga2.png'
end
if not exists(select * from DimLeague where League = '������ ����' 
	AND IDCountry = (select IDCountry from DimCountry where Country = '��������')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select '������ ����', (select IDCountry from DimCountry where Country = '��������'), 1, 'Liga 3', 3, 'germany_liga3.png'
end
--�������
if not exists(select * from DimLeague where League = '�������' 
	AND IDCountry = (select IDCountry from DimCountry where Country = '�������')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select '�������', (select IDCountry from DimCountry where Country = '�������'), 1, 'Primera', 1, 'spain_primera.png'
end

if not exists(select * from DimLeague where League = '�������' 
	AND IDCountry = (select IDCountry from DimCountry where Country = '�������')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select '�������', (select IDCountry from DimCountry where Country = '�������'), 1, 'Segunda', 2, 'spain_segunda.png'
end

if not exists(select * from DimLeague where League = '������� B' 
	AND IDCountry = (select IDCountry from DimCountry where Country = '�������')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select '������� B', (select IDCountry from DimCountry where Country = '�������'), 1, 'Segunda B', 3, 'spain_segunda_b.png'
end

--�������
if not exists(select * from DimLeague where League = '���� 1' 
	AND IDCountry = (select IDCountry from DimCountry where Country = '�������')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select '���� 1', (select IDCountry from DimCountry where Country = '�������'), 1, 'Liga 1', 1, 'france_ligue1.png'
end

if not exists(select * from DimLeague where League = '���� 2' 
	AND IDCountry = (select IDCountry from DimCountry where Country = '�������')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select '���� 2', (select IDCountry from DimCountry where Country = '�������'), 1, 'Liga 2', 2, 'france_ligue2.png'
end

if not exists(select * from DimLeague where League = '���� 3' 
	AND IDCountry = (select IDCountry from DimCountry where Country = '�������')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select '���� 3', (select IDCountry from DimCountry where Country = '�������'), 1, 'Liga 3', 3, 'france_ligue3.png'
end

--������
if not exists(select * from DimLeague where League = '����� A' 
	AND IDCountry = (select IDCountry from DimCountry where Country = '������')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select '����� A', (select IDCountry from DimCountry where Country = '������'), 1, 'Seria A', 1, 'italy_seria_a.png'
end

if not exists(select * from DimLeague where League = '����� B' 
	AND IDCountry = (select IDCountry from DimCountry where Country = '������')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select '����� B', (select IDCountry from DimCountry where Country = '������'), 1, 'Seria B', 2, 'italy_seria_b.png'
end

if not exists(select * from DimLeague where League = '����� C' 
	AND IDCountry = (select IDCountry from DimCountry where Country = '������')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select '����� C', (select IDCountry from DimCountry where Country = '������'), 1, 'Seria C', 3, 'italy_seria_c.png'
end

--������
if not exists(select * from DimLeague where League = '���������' 
	AND IDCountry = (select IDCountry from DimCountry where Country = '������')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select '���������', (select IDCountry from DimCountry where Country = '������'), 1, 'Super', 1, 'turkey_superliga.png'
end
go


--����������
if not exists(select * from DimLeague where League = '�������� ����' 
	AND IDCountry = (select IDCountry from DimCountry where Country = '����������')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select '�������� ����', (select IDCountry from DimCountry where Country = '����������'), 1, 'Primeira', 1, 'portugal_primeira.png'
end

if not exists(select * from DimLeague where League = '���� ���' 
	AND IDCountry = (select IDCountry from DimCountry where Country = '����������')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select '���� ���', (select IDCountry from DimCountry where Country = '����������'), 1, 'Liga Pro', 2, 'portugal_liga_pro.png'
end

if not exists(select * from DimLeague where League = '������ ����' 
	AND IDCountry = (select IDCountry from DimCountry where Country = '����������')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select '������ ����', (select IDCountry from DimCountry where Country = '����������'), 1, 'Campeonato', 3, 'portugal_campeonato.png'
end
go

--���������
if not exists(select * from DimLeague where League = '������ ����' 
	AND IDCountry = (select IDCountry from DimCountry where Country = '���������')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select '������ ����', (select IDCountry from DimCountry where Country = '���������'), 1, 'Eredivisie', 1, 'netherlands_eredivisie.png'
end

if not exists(select * from DimLeague where League = '������ ��������' 
	AND IDCountry = (select IDCountry from DimCountry where Country = '���������')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select '������ ��������', (select IDCountry from DimCountry where Country = '���������'), 1, 'Eerste divisie', 2, 'netherlands_eerste_divisie.png'
end

if not exists(select * from DimLeague where League = '������ ��������' 
	AND IDCountry = (select IDCountry from DimCountry where Country = '���������')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select '������ ��������', (select IDCountry from DimCountry where Country = '���������'), 1, 'Tweede divisie', 3, 'netherlands_tweede_divisie.png'
end

go
--������
if not exists(select * from DimLeague where League = '������� ����' 
	AND IDCountry = (select IDCountry from DimCountry where Country = '������')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select '������� ����', (select IDCountry from DimCountry where Country = '������'), 1, 'Premier', 1, 'russia_premier.png'
end

if not exists(select * from DimLeague where League = '���' 
	AND IDCountry = (select IDCountry from DimCountry where Country = '������')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select '���', (select IDCountry from DimCountry where Country = '������'), 1, 'FNL', 2, 'russia_fnl.png'
end

if not exists(select * from DimLeague where League = '���' 
	AND IDCountry = (select IDCountry from DimCountry where Country = '������')) 
begin
	insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary, LeagueImgSrc) 
	select '���', (select IDCountry from DimCountry where Country = '������'), 1, 'PFL', 3, 'russia_pfl.png'
end



DELETE FROM DimLeagueSource
DBCC CHECKIDENT (DimLeagueSource, RESEED, 0)

declare @IDCountry int
declare @IDLeague int
select @IDCountry = IDCountry from DimCountry where Country = '�������'
select @IDLeague = IDLeague from DimLeague where League = '�������'
if not exists(select 1 from DimLeagueSource where Country = '�������' and League = '�������')
begin
	insert into DimLeagueSource (CurrentSource, Country, IDCountry, IDLeague, League)
	select  'http://football.sport-express.ru/foreign/spain/laleague/[Season]/calendar/tours/', '�������', @IDCountry, @IDLeague, '�������' 
end

select @IDCountry = IDCountry from DimCountry where Country = '������'
select @IDLeague = IDLeague from DimLeague where League = '����� A'
if not exists(select 1 from DimLeagueSource where Country = '������' and League = '����� A')
begin
	insert into DimLeagueSource (CurrentSource, Country, IDCountry, IDLeague, League)
	select  'http://football.sport-express.ru/foreign/italy/seriaa/[Season]/calendar/tours/', '������', @IDCountry, @IDLeague, '����� A'  
end

select @IDCountry = IDCountry from DimCountry where Country = '������'
select @IDLeague = IDLeague from DimLeague where League = '�������-����'
if not exists(select 1 from DimLeagueSource where Country = '������' and League = '�������-����')
begin
	insert into DimLeagueSource (CurrentSource, Country, IDCountry, IDLeague, League)
	select  'http://football.sport-express.ru/foreign/england/premier/[Season]/calendar/tours/', '������', @IDCountry, @IDLeague, '�������-����'
end

select @IDCountry = IDCountry from DimCountry where Country = '��������'
select @IDLeague = IDLeague from DimLeague where League = '���������� 1'
if not exists(select 1 from DimLeagueSource where Country = '��������' and League = '���������� 1')
begin
	insert into DimLeagueSource (CurrentSource, Country, IDCountry, IDLeague, League)
	select  'http://football.sport-express.ru/foreign/german/bundes1/[Season]/calendar/tours/', '��������', @IDCountry, @IDLeague, '���������� 1'
end

select @IDCountry = IDCountry from DimCountry where Country = '�������'
select @IDLeague = IDLeague from DimLeague where League = '���� 1'
if not exists(select 1 from DimLeagueSource where Country = '�������' and League = '���� 1')
begin
	insert into DimLeagueSource (CurrentSource, Country, IDCountry, IDLeague, League)
	select  'http://football.sport-express.ru/foreign/france/league1/[Season]/calendar/tours/', '�������', @IDCountry, @IDLeague, '���� 1'
end

select @IDCountry = IDCountry from DimCountry where Country = '������'
select @IDLeague = IDLeague from DimLeague where League = '���������'
if not exists(select 1 from DimLeagueSource where Country = '������' and League = '���������')
begin
	insert into DimLeagueSource (CurrentSource, Country, IDCountry, IDLeague, League)
	select  'https://www.sport-express.ru/football/L/foreign/turkey/super/[Season]/calendar/tours/', '������', @IDCountry, @IDLeague, '���������'
end

select @IDCountry = IDCountry from DimCountry where Country = '����������'
select @IDLeague = IDLeague from DimLeague where League = '���������'
if not exists(select 1 from DimLeagueSource where Country = '����������' and League = '���������')
begin
	insert into DimLeagueSource (CurrentSource, Country, IDCountry, IDLeague, League)
	select  'https://www.sport-express.ru/football/L/foreign/portugal/super/[Season]/calendar/tours/', '����������', @IDCountry, @IDLeague, '���������'
end
select @IDCountry = IDCountry from DimCountry where Country = '���������'
select @IDLeague = IDLeague from DimLeague where League = '������ ����'
if not exists(select 1 from DimLeagueSource where Country = '���������' and League = '������ ����')
begin
	insert into DimLeagueSource (CurrentSource, Country, IDCountry, IDLeague, League)
	select  'https://www.sport-express.ru/football/L/foreign/netherlands/highest/[Season]/calendar/tours/', '���������', @IDCountry, @IDLeague, '������ ����'
end

select @IDCountry = IDCountry from DimCountry where Country = '������'
select @IDLeague = IDLeague from DimLeague where League = '������� ����'
if not exists(select 1 from DimLeagueSource where Country = '������' and League = '������� ����')
begin
	insert into DimLeagueSource (CurrentSource, Country, IDCountry, IDLeague, League)
	select  'https://www.sport-express.ru/football/L/russia/premier/[Season]/calendar/tours/', '������', @IDCountry, @IDLeague, '������� ����'
end

select @IDCountry = IDCountry from DimCountry where Country = '�������'
select @IDLeague = IDLeague from DimLeague where League = '�������'
if not exists(select 1 from DimLeagueSource where Country = '�������' and League = '�������')
begin
	insert into DimLeagueSource (CurrentSource, Country, IDCountry, IDLeague, League)
	select  'https://www.sport-express.ru/football/L/foreign/spain/segunda/[Season]/calendar/tours/', '�������', 
	@IDCountry, @IDLeague, '�������' 
end

select @IDCountry = IDCountry from DimCountry where Country = '������'
select @IDLeague = IDLeague from DimLeague where League = '����������'
if not exists(select 1 from DimLeagueSource where Country = '������' and League = '����������')
begin
	insert into DimLeagueSource (CurrentSource, Country, IDCountry, IDLeague, League)
	select  'https://www.sport-express.ru/football/L/foreign/england/champion/[Season]/calendar/tours/', '������', 
	@IDCountry, @IDLeague, '����������' 
end

select @IDCountry = IDCountry from DimCountry where Country = '��������'
select @IDLeague = IDLeague from DimLeague where League = '���������� 2'
if not exists(select 1 from DimLeagueSource where Country = '��������' and League = '���������� 2')
begin
	insert into DimLeagueSource (CurrentSource, Country, IDCountry, IDLeague, League)
	select  'https://www.sport-express.ru/football/L/foreign/german/bundes2/[Season]/calendar/tours/', '��������', 
	@IDCountry, @IDLeague, '���������� 2' 
end

select @IDCountry = IDCountry from DimCountry where Country = '��������'
select @IDLeague = IDLeague from DimLeague where League = '���������� 2'
if not exists(select 1 from DimLeagueSource where Country = '��������' and League = '���������� 2')
begin
	insert into DimLeagueSource (CurrentSource, Country, IDCountry, IDLeague, League)
	select  'https://www.sport-express.ru/football/L/foreign/german/bundes2/[Season]/calendar/tours/', '��������', 
	@IDCountry, @IDLeague, '���������� 2' 
end


select @IDCountry = IDCountry from DimCountry where Country = '�������'
select @IDLeague = IDLeague from DimLeague where League = '���� 2'
if not exists(select 1 from DimLeagueSource where Country = '�������' and League = '���� 2')
begin
	insert into DimLeagueSource (CurrentSource, Country, IDCountry, IDLeague, League)
	select  'https://www.sport-express.ru/football/L/foreign/france/league2/[Season]/calendar/tours/', '�������', 
	@IDCountry, @IDLeague, '���� 2' 
end

select @IDCountry = IDCountry from DimCountry where Country = '������'
select @IDLeague = IDLeague from DimLeague where League = '����� B'
if not exists(select 1 from DimLeagueSource where Country = '������' and League = '����� B')
begin
	insert into DimLeagueSource (CurrentSource, Country, IDCountry, IDLeague, League)
	select  'https://www.sport-express.ru/football/L/foreign/italy/seriab/[Season]/calendar/tours/', '������', 
	@IDCountry, @IDLeague, '����� B' 
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
select 1 as IDSport, c.IDCountry, '������', c.Country
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