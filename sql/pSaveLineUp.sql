USE [SportStat]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSaveLineUp]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pSaveLineUp]
GO

create procedure pSaveLineUp
--входящие параметры
 @Team varchar(50)
,@IsOverwrite int 
,@Player varchar(100)
,@Amplua varchar(5)
,@Games int
,@Goals int
,@Pass int
,@GoalsGK int
as
begin

declare @IDTeam int
select @IDTeam = IDTeam from DimTeam where Team = @Team

if @IsOverwrite = 1
begin
	delete from FactPlayer where Team = @Team And Player = @Player
end 

if not exists(select 1 from FactPlayer where Team = @Team And Player = @Player)
begin
	insert into FactPlayer(Player, IDTeam, Team, Amplua, Games, Goals, Pass, GoalsGK)
	select @Player, @IDTeam, @Team, @Amplua, @Games, @Goals, @Pass, @GoalsGK
end

end