use SportStat
go
select * from DimCountry
select * from DimTeam
select * from DimSeason
select * from DimLeague
select * from DimLeagueSource

update DimLeague
set IDCountry = 26
where League = 'Лига 1'

update DimLeagueSource
set IDCountry = 25,
    IDLeague = 7
where Country = 'Германия'

delete from DimLeague where IDLeague IN (4, 5, 6)

alter table DimSeason add IsCurrentSeason int 
go
insert into DimSeason(Season, IsCurrentSeason) select '2017-2018', 1



select * from fGetCountrySource(2, 'Франция')

delete from DimSeason where IDSeason = 17

insert into DimCountry(Country) select 'Франция'
insert into DimCountry(CountryEng) select 'France'
delete from DimCountry where Country = 'Франция'
delete from DimCountry where CountryEng = 'France'
delete from DimCountry where IDCountry >=21


select LS.CurrentSource from DimCountry C
join DimLeague L on C.IDCountry = L.IDCountry
join DimLeagueSource LS on L.LeagueCurrentSource = LS.IDLeagueCurrentSource
WHERE c.Country

select * from FactResult where IDSeason = 17
select * from FactResult order by IDFactResult desc

select * from FactResult where Season = '2014-2015' and League = 'Примера' and Tour = 38 and TeamHome = 'Реал'


select top 10000 * from FactResult order by IDFactResult desc

select count(*) from FactResult 

sp_Who

delete from  FactResult where IDFactResult > 7600


select * from fGetCountrySource(1, NULL)

alter table FactResult add LastUpdate datetime

delete from FactResult where IDFactResult = 7605

select Country, League, Season, count(*) 
from FactResult 
group by Country, League, Season
order by Country, League, Season


delete from FactResult where Season = '2017-2018'

alter table FactLoadError add UpdateDate datetime

exec pSaveResult 1, '2016-2017' , 'Италия', 'Серия A', 2, '28.08.2016', 'Сассуоло', 'Пескара', -, +, 1, NULL, NULL

select * from FactLoadError

