USE [SportStat]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pReLoadToDjango]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pReLoadToDjango]
GO

create procedure pReLoadToDjango
as
BEGIN

ALTER TABLE [dbo].[sport_result] DROP CONSTRAINT [sport_result_IDTeamHome_id_604ccf7e_fk_sport_team_id]
ALTER TABLE [dbo].[sport_result] DROP CONSTRAINT [sport_result_IDTeamGuest_id_be14202f_fk_sport_team_id]
ALTER TABLE [dbo].[sport_result] DROP CONSTRAINT [sport_result_IDSeason_id_6de01aa9_fk_sport_season_id]
ALTER TABLE [dbo].[sport_result] DROP CONSTRAINT [sport_result_IDLeague_id_080d89e7_fk_sport_league_id]
ALTER TABLE [dbo].[sport_result] DROP CONSTRAINT [sport_result_IDCountry_id_cf7ab64c_fk_sport_country_id]
ALTER TABLE [dbo].[sport_result] DROP CONSTRAINT [sport_result_IDSport_id_2c7310b9_fk_sport_sport_id]
ALTER TABLE [dbo].[sport_standing] DROP CONSTRAINT [sport_standing_IDTeam_id_71ddc349_fk_sport_team_id]
ALTER TABLE [dbo].[sport_standing] DROP CONSTRAINT [sport_standing_IDSport_id_d9a9c27c_fk_sport_sport_id]
ALTER TABLE [dbo].[sport_standing] DROP CONSTRAINT [sport_standing_IDSeason_id_e68b0f67_fk_sport_season_id]
ALTER TABLE [dbo].[sport_standing] DROP CONSTRAINT [sport_standing_IDLeague_id_15a0c85b_fk_sport_league_id]
ALTER TABLE [dbo].[sport_standing] DROP CONSTRAINT [sport_standing_IDCountry_id_45a605e0_fk_sport_country_id]
ALTER TABLE [dbo].[sport_team] DROP CONSTRAINT [sport_team_IDCountry_id_cea5d302_fk_sport_country_id]
ALTER TABLE [dbo].[sport_league] DROP CONSTRAINT [sport_league_IDCountry_id_aac19d38_fk_sport_country_id]
ALTER TABLE [dbo].[sport_predict] DROP CONSTRAINT [sport_predict_IDSport_id_efbb8952_fk_sport_sport_id]
ALTER TABLE [dbo].[sport_predict] DROP CONSTRAINT [sport_predict_IDTeamGuest_id_b7148d85_fk_sport_team_id]
ALTER TABLE [dbo].[sport_predict] DROP CONSTRAINT [sport_predict_IDTeamHome_id_8087cbb5_fk_sport_team_id]
ALTER TABLE [dbo].[sport_predict] DROP CONSTRAINT [sport_predict_IDCountry_id_ee39a151_fk_sport_country_id]
ALTER TABLE [dbo].[sport_predict] DROP CONSTRAINT [sport_predict_IDLeague_id_52449f2a_fk_sport_league_id]
ALTER TABLE [dbo].[sport_predict] DROP CONSTRAINT [sport_predict_IDResult_id_700152fc_fk_sport_result_id]
ALTER TABLE [dbo].[sport_predict] DROP CONSTRAINT [sport_predict_IDSeason_id_5fff1b9e_fk_sport_season_id]

truncate table sport_predict
truncate table sport_result
truncate table sport_standing
truncate table sport_team
truncate table sport_league
truncate table sport_country
truncate table sport_season
truncate table sport_sport
truncate table sport_sport

ALTER TABLE [dbo].[sport_league]  WITH CHECK ADD  CONSTRAINT [sport_league_IDCountry_id_aac19d38_fk_sport_country_id] FOREIGN KEY([IDCountry_id])
REFERENCES [dbo].[sport_country] ([id])
ALTER TABLE [dbo].[sport_league] CHECK CONSTRAINT [sport_league_IDCountry_id_aac19d38_fk_sport_country_id]

ALTER TABLE [dbo].[sport_result]  WITH CHECK ADD  CONSTRAINT [sport_result_IDTeamHome_id_604ccf7e_fk_sport_team_id] FOREIGN KEY([IDTeamHome_id])
REFERENCES [dbo].[sport_team] ([id])
ALTER TABLE [dbo].[sport_result] CHECK CONSTRAINT [sport_result_IDTeamHome_id_604ccf7e_fk_sport_team_id]

ALTER TABLE [dbo].[sport_result]  WITH CHECK ADD  CONSTRAINT [sport_result_IDTeamGuest_id_be14202f_fk_sport_team_id] FOREIGN KEY([IDTeamGuest_id])
REFERENCES [dbo].[sport_team] ([id])
ALTER TABLE [dbo].[sport_result] CHECK CONSTRAINT [sport_result_IDTeamGuest_id_be14202f_fk_sport_team_id]

ALTER TABLE [dbo].[sport_result]  WITH CHECK ADD  CONSTRAINT [sport_result_IDSeason_id_6de01aa9_fk_sport_season_id] FOREIGN KEY([IDSeason_id])
REFERENCES [dbo].[sport_season] ([id])
ALTER TABLE [dbo].[sport_result] CHECK CONSTRAINT [sport_result_IDSeason_id_6de01aa9_fk_sport_season_id]

ALTER TABLE [dbo].[sport_result]  WITH CHECK ADD  CONSTRAINT [sport_result_IDLeague_id_080d89e7_fk_sport_league_id] FOREIGN KEY([IDLeague_id])
REFERENCES [dbo].[sport_league] ([id])
ALTER TABLE [dbo].[sport_result] CHECK CONSTRAINT [sport_result_IDLeague_id_080d89e7_fk_sport_league_id]

ALTER TABLE [dbo].[sport_result]  WITH CHECK ADD  CONSTRAINT [sport_result_IDCountry_id_cf7ab64c_fk_sport_country_id] FOREIGN KEY([IDCountry_id])
REFERENCES [dbo].[sport_country] ([id])
ALTER TABLE [dbo].[sport_result] CHECK CONSTRAINT [sport_result_IDCountry_id_cf7ab64c_fk_sport_country_id]


ALTER TABLE [dbo].[sport_result]  WITH CHECK ADD  CONSTRAINT [sport_result_IDSport_id_2c7310b9_fk_sport_sport_id] FOREIGN KEY([IDSport_id])
REFERENCES [dbo].[sport_sport] ([id])
ALTER TABLE [dbo].[sport_result] CHECK CONSTRAINT [sport_result_IDSport_id_2c7310b9_fk_sport_sport_id]

ALTER TABLE [dbo].[sport_team]  WITH CHECK ADD  CONSTRAINT [sport_team_IDCountry_id_cea5d302_fk_sport_country_id] FOREIGN KEY([IDCountry_id])
REFERENCES [dbo].[sport_country] ([id])
ALTER TABLE [dbo].[sport_team] CHECK CONSTRAINT [sport_team_IDCountry_id_cea5d302_fk_sport_country_id]

ALTER TABLE [dbo].[sport_standing]  WITH CHECK ADD  CONSTRAINT [sport_standing_IDTeam_id_71ddc349_fk_sport_team_id] FOREIGN KEY([IDTeam_id])
REFERENCES [dbo].[sport_team] ([id])
ALTER TABLE [dbo].[sport_standing] CHECK CONSTRAINT [sport_standing_IDTeam_id_71ddc349_fk_sport_team_id]

ALTER TABLE [dbo].[sport_standing]  WITH CHECK ADD  CONSTRAINT [sport_standing_IDSport_id_d9a9c27c_fk_sport_sport_id] FOREIGN KEY([IDSport_id])
REFERENCES [dbo].[sport_sport] ([id])
ALTER TABLE [dbo].[sport_standing] CHECK CONSTRAINT [sport_standing_IDSport_id_d9a9c27c_fk_sport_sport_id]

ALTER TABLE [dbo].[sport_standing]  WITH CHECK ADD  CONSTRAINT [sport_standing_IDSeason_id_e68b0f67_fk_sport_season_id] FOREIGN KEY([IDSeason_id])
REFERENCES [dbo].[sport_season] ([id])
ALTER TABLE [dbo].[sport_standing] CHECK CONSTRAINT [sport_standing_IDSeason_id_e68b0f67_fk_sport_season_id]

ALTER TABLE [dbo].[sport_standing]  WITH CHECK ADD  CONSTRAINT [sport_standing_IDLeague_id_15a0c85b_fk_sport_league_id] FOREIGN KEY([IDLeague_id])
REFERENCES [dbo].[sport_league] ([id])
ALTER TABLE [dbo].[sport_standing] CHECK CONSTRAINT [sport_standing_IDLeague_id_15a0c85b_fk_sport_league_id]

ALTER TABLE [dbo].[sport_standing]  WITH CHECK ADD  CONSTRAINT [sport_standing_IDCountry_id_45a605e0_fk_sport_country_id] FOREIGN KEY([IDCountry_id])
REFERENCES [dbo].[sport_country] ([id])
ALTER TABLE [dbo].[sport_standing] CHECK CONSTRAINT [sport_standing_IDCountry_id_45a605e0_fk_sport_country_id]


ALTER TABLE [dbo].[sport_predict]  WITH CHECK ADD  CONSTRAINT [sport_predict_IDCountry_id_ee39a151_fk_sport_country_id] FOREIGN KEY([IDCountry_id])
REFERENCES [dbo].[sport_country] ([id])
ALTER TABLE [dbo].[sport_predict] CHECK CONSTRAINT [sport_predict_IDCountry_id_ee39a151_fk_sport_country_id]

ALTER TABLE [dbo].[sport_predict]  WITH CHECK ADD  CONSTRAINT [sport_predict_IDLeague_id_52449f2a_fk_sport_league_id] FOREIGN KEY([IDLeague_id])
REFERENCES [dbo].[sport_league] ([id])
ALTER TABLE [dbo].[sport_predict] CHECK CONSTRAINT [sport_predict_IDLeague_id_52449f2a_fk_sport_league_id]

ALTER TABLE [dbo].[sport_predict]  WITH CHECK ADD  CONSTRAINT [sport_predict_IDResult_id_700152fc_fk_sport_result_id] FOREIGN KEY([IDResult_id])
REFERENCES [dbo].[sport_result] ([id])
ALTER TABLE [dbo].[sport_predict] CHECK CONSTRAINT [sport_predict_IDResult_id_700152fc_fk_sport_result_id]

ALTER TABLE [dbo].[sport_predict]  WITH CHECK ADD  CONSTRAINT [sport_predict_IDSeason_id_5fff1b9e_fk_sport_season_id] FOREIGN KEY([IDSeason_id])
REFERENCES [dbo].[sport_season] ([id])
ALTER TABLE [dbo].[sport_predict] CHECK CONSTRAINT [sport_predict_IDSeason_id_5fff1b9e_fk_sport_season_id]

ALTER TABLE [dbo].[sport_predict]  WITH CHECK ADD  CONSTRAINT [sport_predict_IDSport_id_efbb8952_fk_sport_sport_id] FOREIGN KEY([IDSport_id])
REFERENCES [dbo].[sport_sport] ([id])
ALTER TABLE [dbo].[sport_predict] CHECK CONSTRAINT [sport_predict_IDSport_id_efbb8952_fk_sport_sport_id]

ALTER TABLE [dbo].[sport_predict]  WITH CHECK ADD  CONSTRAINT [sport_predict_IDTeamGuest_id_b7148d85_fk_sport_team_id] FOREIGN KEY([IDTeamGuest_id])
REFERENCES [dbo].[sport_team] ([id])
ALTER TABLE [dbo].[sport_predict] CHECK CONSTRAINT [sport_predict_IDTeamGuest_id_b7148d85_fk_sport_team_id]

ALTER TABLE [dbo].[sport_predict]  WITH CHECK ADD  CONSTRAINT [sport_predict_IDTeamHome_id_8087cbb5_fk_sport_team_id] FOREIGN KEY([IDTeamHome_id])
REFERENCES [dbo].[sport_team] ([id])
ALTER TABLE [dbo].[sport_predict] CHECK CONSTRAINT [sport_predict_IDTeamHome_id_8087cbb5_fk_sport_team_id]

insert into sport_sport(IDSport, Sport, SportEng)
Select IDSport, Sport, SportEng from DimSport

insert into sport_country(IdCountry, Country, CountryEng, IsMain, IDSeasonType)
select IdCountry, Country, CountryEng, IsMain,  IDSeasonType
from DimCountry
order by IdCountry

insert into sport_team(IDTeam,Team, IDCountry_id, TeamEng, YearFound, Color, Stadium, StadiumNumber, Coach)
select t.IDTeam, t.Team, sc.id as IDCountry_id, t.TeamEng, t.YearFound, t.Color, t.Stadium, t.StadiumNumber, t.Coach 
from dimteam t
join DimCountry c on t.IDCountry =c.IDCountry
join  sport_country sc on c.Country = sc.Country
order by t.IDTeam

insert into sport_league(IDLeague, League, IDLeagueType, LeagueEng, LeagueCurrentSource, IDCountry_id, IsPrimary, LeagueImgSrc)
select IDLeague, League, IDLeagueType, LeagueEng, LeagueCurrentSource, sc.id as IDCountry_id, l.IsPrimary, l.LeagueImgSrc 
from DimLeague l
join DimCountry c on l.IDCountry = c.IDCountry
join  sport_country sc on c.Country = sc.Country
order by IDLeague

insert into sport_season(Season, IsCurrentSeason, IDSeasonType)
select Season, isnull(IsCurrentSeason,0), IDSeasonType from DimSeason

INSERT INTO [dbo].[sport_result]
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
           ,[IDResultType]
           ,[GoalHomePenalty]
           ,[GoalGuestPenalty]
           ,[LastUpDate]
           ,[IDCountry_id]
           ,[IDLeague_id]
           ,[IDSeason_id]
           ,[IDTeamHome_id]
		   ,[IDTeamGuest_id]
		   ,[IDSport_id]
		   ,[IDFactResult]
           )
select 
 f.Sport
,f.Country
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
,sth.id as IDTeamHome_id
,stg.id as IDTeamGuest_id
,ssp.id as IDSport_id
,f.IDFactResult
from FactResult f
join DimCountry c on f.IDCountry =c.IDCountry
join sport_country sc on c.Country = sc.Country
join DimLeague l on f.IDLeague = L.IDLeague
join sport_league sl on l.IDLeague = sl.IDLeague
join DimSeason s on f.IDSeason = s.IDSeason
join sport_season ss on s.Season = ss.Season
join DimTeam th on f.IDTeamHome = th.IDTeam
join sport_team sth on th.Team = sth.Team
join DimTeam tg on f.IDTeamGuest = tg.IDTeam
join sport_team stg on tg.Team = stg.Team
join DimSport ds on f.IDSport =ds.IDSport
join sport_sport ssp on ds.Sport = ssp.Sport

insert into sport_standing
(Sport, Country, CountryEng, Season,League,CountDraw,CountDrawGuest,CountDrawHome,CountGames
,CountGamesGuest,CountGamesHome,CountLose,CountLoseGuest,CountLoseHome
,CountPoint,CountPointGuest,CountPointHome,CountWin,CountWinGuest,CountWinHome
,GoalDifference,GoalDifferenceGuest,GoalDifferenceHome,GoalLose,GoalLoseGuest
,GoalLoseHome,GoalWin,GoalWinGuest,GoalWinHome,IDCountry_id,IDLeague_id
,IDSeason_id,IDSport_id,LastTours,Position,Team,TourDate,TourNumber,TypeTour, IDTeam_id, PosType, LastGames)
select
 F.Sport, F.Country, C.CountryEng, F.Season, F.League, F.CountDraw, F.CountDrawGuest, F.CountDrawHome, F.CountGames
,F.CountGamesGuest, F.CountGamesHome, F.CountLose, F.CountLoseGuest, F.CountLoseHome
,F.CountPoint, F.CountPointGuest, F.CountPointHome, F.CountWin, F.CountWinGuest, F.CountWinHome
,F.GoalDifference, F.GoalDifferenceGuest, F.GoalDifferenceHome, F.GoalLose, F.GoalLoseGuest
,F.GoalLoseHome, F.GoalWin, F.GoalWinGuest, F.GoalWinHome, sc.id as IDCountry_id,sl.id as IDLeague_id
,ss.id as IDSeason_id, sps.id as IDSport_id, F.LastTours, F.Position, F.Team, F.TourDate, F.TourNumber, F.TypeTour,
st.id as IDTeam_id, F.PosType, F.LastGames
from FactStanding F
join DimCountry C on F.IDCountry = C.IDCountry
join sport_country sc on C.Country = sc.Country
join DimLeague l on f.IDLeague = L.IDLeague
join sport_league sl on l.IDLeague = sl.IDLeague
join DimSeason s on f.IDSeason = s.IDSeason
join sport_season ss on s.Season = ss.Season
join DimTeam t on f.IDTeam = t.IDteam
join sport_team st on t.Team = st.Team    
join DimSport sp on f.IDSport = sp.IDSport
join sport_sport sps on sp.Sport = sps.Sport


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
           ,[ProbHome]
           ,[ProbDraw]
           ,[ProbGuest]
           ,[PredictType]
           ,[DateCreate]
           ,[IDCountry_id]
           ,[IDLeague_id]
           ,[IDSeason_id]
           ,[IDTeamGuest_id]
           ,[IDTeamHome_id]
		   ,[IDSport_id]
		   ,[IDResult_id]
		   ,[IDFactResult])
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
,f.IDFactResult
from FactPredict fp
join FactResult f on fp.IDFactResult = f.IDFactResult
join sport_result sr on f.IDFactResult = sr.IDFactResult
join DimCountry c on f.IDCountry =c.IDCountry
join sport_country sc on c.Country = sc.Country
join DimLeague l on f.IDLeague = L.IDLeague
join sport_league sl on l.IDLeague = sl.IDLeague
join DimSeason s on f.IDSeason = s.IDSeason
join sport_season ss on s.Season = ss.Season
join DimTeam th on f.IDTeamHome = th.IDTeam
join sport_team sth on th.Team = sth.Team
join DimTeam tg on f.IDTeamGuest = tg.IDTeam
join sport_team stg on tg.Team = stg.Team
join DimSport ds on f.IDSport =ds.IDSport
join sport_sport ssp on ds.Sport = ssp.Sport

update sport_team 
set ImgBig = 'team_' + cast(st.IDTeam as varchar) + '_big.png',
	ImgSmall = 'team_' + cast(st.IDTeam as varchar) + '_small.png'
from sport_team st
left join DimTeam dt on st.Team = dt.Team
where dt.ImgSmall is not null 

--exec pExtractFilesToDjango

END;





