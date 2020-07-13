USE [SportStat]
GO

/****** Object:  UserDefinedFunction [dbo].fGetLastGames]    Script Date: 09.10.2017 19:46:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fGetLastGames]') AND type in (N'P', N'PC', N'TF', N'FN', N'FT')) 
DROP FUNCTION fGetLastGames

go

CREATE FUNCTION [dbo].[fGetLastGames] (@Sport  VARCHAR(50) = null, 
									   @Season VARCHAR(50) = null, 
									   @Country VARCHAR(50) = null, 
									   @League VARCHAR(50) = null, 
									   @Team VARCHAR(50) = null, 
									   @N int = 5)
RETURNS VARCHAR(1000)
AS
BEGIN
   declare @GamesStr varchar(500)

	select @GamesStr = STUFF((select ', ' + res.fld
	from (
	select top (@N)  cast(GoalHome as varchar) + ':' + cast(GoalGuest as varchar) 
				  + case when TeamHome = @Team then ' (ä)' 
						 when TeamGuest = @Team then ' (ã)'
					end
				  + ' ' + TeamHome + ' - '  + TeamGuest + ' ' + convert(varchar, MatchDate, 104) as fld
	from FactResult where Sport = @Sport AND Country = @Country AND League = @League AND Season = @Season
	And (TeamHome = @Team OR TeamGuest = @Team) AND GoalHome is not null
	order by MatchDate desc
	) res
	FOR XML PATH('')), 1, 1, ''
	)
   RETURN @GamesStr
END


GO