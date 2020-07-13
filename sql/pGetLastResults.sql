USE [SportStat]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pGetLastResults]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pGetLastResults]
GO

create procedure pGetLastResults
@Team varchar(100),
@IsAllChamps int = 0,
@Country varchar(100) = NULL,
@League varchar(100) = NULL,
@CountResults int = 10
as
begin
	select top (@CountResults)  convert(varchar, MatchDate, 104) as 'Дата', TeamHome as 'Хозяева', TeamGuest as 'Гости', GoalHome as 'ГХ', GoalGuest as 'ГГ'
	from FactResult 
	where (TeamHome = @Team or TeamGuest = @Team) AND ((@IsAllChamps = 0 AND Country = @Country and League =  @League) OR @IsAllChamps = 1) 
	order by MatchDate DESC
end

