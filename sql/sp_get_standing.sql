USE [SportStat]
GO

/****** Object:  StoredProcedure [dbo].[sp_get_standing]    Script Date: 07.04.2020 22:03:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[sp_get_standing] (@id int)
as
begin
set nocount on;
SELECT /*IDSport,*/ Country, Season, League
/*, 
        /*IDCountry, IDSeason, IDLeague, */TypeTour, LastTours, TourNumber,
        TourDate, Position, Team, CountGames, CountWin, CountDraw, CountLose,
        GoalWin, GoalLose, GoalDifference, CountPoint, CountGamesHome, CountWinHome,
        CountDrawHome, CountLoseHome, GoalWinHome, GoalLoseHome, GoalDifferenceHome,
        CountPointHome, CountGamesGuest, CountWinGuest, CountDrawGuest, CountLoseGuest,
        GoalWinGuest, GoalLoseGuest, CountPointGuest, GoalDifferenceGuest
*/
--SELECT *
FROM FactStanding

end
GO


