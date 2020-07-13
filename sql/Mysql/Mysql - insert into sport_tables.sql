select * from sport_league;
select * from sport_country;
select * from sport_team;
select * from sport_season
select * from sport_sport
select * from sport_result
select * from sport_standing

select * from DimSeason


--truncate table sport_result
--truncate table sport_standing
--delete from  sport_team
--delete from  sport_league
--delete from  sport_country
--delete from  sport_season
--delete from  sport_sport
--truncate table sport_sport

select * from sport_sport

exec pReLoadToDjango




insert into sport_country(IdCountry, Country, CountryEng)
select * from dimcountry; 

insert into sport_team(IDTeam,Team, IDCountry_id, TeamEng)
select t.IDTeam, t.Team, sc.id as IDCountry_id, t.TeamEng 
from dimteam t
join DimCountry c on t.IDCountry =c.IDCountry
join  sport_country sc on c.Country = sc.Country
;

insert into sport_league(IDLeague, League, IDLeagueType, LeagueEng, LeagueCurrentSource, IDCountry_id)
select IDLeague, League, IDLeagueType, LeagueEng, LeagueCurrentSource, sc.id as IDCountry_id 
from DimLeague l
join DimCountry c on l.IDCountry = c.IDCountry
join  sport_country sc on c.Country = sc.Country

insert into sport_season(Season, IsCurrentSeason)
select Season, isnull(IsCurrentSeason,0) from DimSeason

insert into sport_sport(IDSport, Sport)
Select IDSport, Sport from DimSport

INSERT INTO [dbo].[sport_result]
           ([Country]
           ,[Season]
           ,[League]
           ,[Tour]
           ,[MatchDate]
           ,[TeamHome]
           ,[TeamGuest]
           ,[GoalHome]
           ,[GoalGuest]
           ,[IDResultType]
           ,[GoalHomePenalty]
           ,[GoalGuestPenalty]
           ,[LastUpDate]
           ,[IDCountry_id]
           ,[IDLeague_id]
           ,[IDSeason_id]
           ,[IDTeamGuest_id]
           ,[IDTeamHome_id])
select 
 f.Country
,f.Season
,f.League
,Tour
,MatchDate
,TeamHome
,TeamGuest
,GoalHome
,GoalGuest
,IDResultType
,GoalHomePenalty
,GoalGuestPenalty
,f.LastUpDate
,sc.id as IDCountry_id
,sl.id as IDLeague_id
,ss.id as IDSeason_id
,sth.id as IDTeamGuest_id
,stg.id as IDTeamHome_id
from FactResult f
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

alter table FactStanding add IDTeam int 

select * from sport_team
select * from sport_result 
select * from sport_standing 
select * from FactStanding 
delete from sport_standing

insert into sport_standing
(Country,Season,League,CountDraw,CountDrawGuest,CountDrawHome,CountGames
,CountGamesGuest,CountGamesHome,CountLose,CountLoseGuest,CountLoseHome
,CountPoint,CountPointGuest,CountPointHome,CountWin,CountWinGuest,CountWinHome
,GoalDifference,GoalDifferenceGuest,GoalDifferenceHome,GoalLose,GoalLoseGuest
,GoalLoseHome,GoalWin,GoalWinGuest,GoalWinHome,IDCountry_id,IDLeague_id
,IDSeason_id,IDSport_id,LastTours,Position,Team,TourDate,TourNumber,TypeTour, IDTeam_id)
select
 F.Country, F.Season, F.League, F.CountDraw, F.CountDrawGuest, F.CountDrawHome, F.CountGames
,F.CountGamesGuest, F.CountGamesHome, F.CountLose, F.CountLoseGuest, F.CountLoseHome
,F.CountPoint, F.CountPointGuest, F.CountPointHome, F.CountWin, F.CountWinGuest, F.CountWinHome
,F.GoalDifference, F.GoalDifferenceGuest, F.GoalDifferenceHome, F.GoalLose, F.GoalLoseGuest
,F.GoalLoseHome, F.GoalWin, F.GoalWinGuest, F.GoalWinHome, sc.id as IDCountry_id,sl.id as IDLeague_id
,ss.id as IDSeason_id, sps.id as IDSport_id, F.LastTours, F.Position, F.Team, F.TourDate, F.TourNumber, F.TypeTour,
st.id as IDTeam_id
--select count(*)
from FactStanding F
join DimCountry C on F.IDCountry = C.IDCountry
join sport_country sc on C.Country = sc.Country
join DimLeague l on f.IDLeague = L.IDLeague
join sport_league sl on l.League = sl.League
join DimSeason s on f.IDSeason = s.IDSeason
join sport_season ss on s.Season = ss.Season
join DimTeam t on f.IDTeam = t.IDteam
join sport_team st on t.Team = st.Team    
join DimSport sp on f.IDSport = sp.IDSport
join sport_sport sps on sp.Sport = sps.Sport 

update FactStanding
set IDTeam = t.IDTeam
from FactStanding ft
join DimTeam t on ft.Team = t.Team



select * from DimSport
select * from FactStanding
select convert(varchar, getdate(),  104)

select * from sport_league;
select * from sport_country;
select * from sport_team;
select * from sport_season;
select * from sport_sport;
select * from sport_result;
select * from sport_standing;
    
select * from Sport_team where Team = 'ёвентус'

select * from sport_result

update sport_result
set IDTeamGuest_id = stg.id
from sport_result sr
join DimTeam tg on sr.TeamGuest = tg.Team
join sport_team stg on tg.Team = stg.Team


select * from sport_country
select * from sport_league
select * from sport_standing
select * from sport_country
select * from sport_league
select * from FactStanding