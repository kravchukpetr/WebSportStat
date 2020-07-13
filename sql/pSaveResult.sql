USE [SportStat]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSaveResult]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pSaveResult]
GO

create procedure pSaveResult
 @IsAddValues int = 0
,@Season varchar(50)
,@Country varchar(50)
,@League varchar(50)
,@Tour int
,@MatchDate date
,@TeamHome varchar(100)
,@TeamGuest varchar(100)
,@GoalHome int
,@GoalGuest int
,@IDResultType int = 1
,@GoalHomePenalty int = NULL
,@GoalGuestPenalty int = NULL
,@IsError int = 0
,@Stage varchar(50) = NULL
,@Sport varchar(50) = 'Футбол'
as
begin

declare @IDCountry int
declare @IDSeason int
declare @IDLeague int
declare @IDTeamHome int
declare @IDTeamGuest int
declare @IDSport int 

begin try
	
	if @IsError = 1
	begin

		insert into FactLoadError(UpdateDate, VarStr)
		select getdate(), '@Country' + convert(varchar(100), @Country) + '; @Season = ' + convert(varchar(100), @Season) + '; @League = ' + convert(varchar(100),@League)
					+ '; @TeamHome = ' +  convert(varchar(100), @TeamHome) + '; @TeamGuest = ' + convert(varchar(100),@TeamGuest) +  '; @GoalHome = ' + convert(varchar(100), isnull(@GoalHome,''))
					+ '; @GoalGuest = ' + convert(varchar(100), isnull(@GoalGuest,'')) + '; @IsError = 1'
	end

	select @TeamHome = ltrim(rtrim(@TeamHome))
	select @TeamGuest = ltrim(rtrim(@TeamGuest))
	select  @IDSport = IDSport from DimSport where Sport = @Sport
	select  @IDCountry = IDCountry from DimCountry where Country = @Country
	select  @IDSeason = IDSeason from DimSeason where Season = @Season
	select  @IDLeague = IDLeague from DimLeague where League = @League and IDCountry = @IDCountry
	select  @IDTeamHome = IDTeam from DimTeam where Team = @TeamHome
	select  @IDTeamGuest = IDTeam from DimTeam where Team = @TeamGuest


	if @IsAddValues = 1
	begin
	if @IDCountry is null
	begin
		insert into DimCountry(Country) select @Country
		select  @IDCountry = IDCountry from DimCountry where Country = @Country
	end
	if @IDSeason is null
	begin
		insert into DimSeason(Season) select @Season
		select  @IDSeason = IDSeason from DimSeason where Season = @Season
	end
	if @IDLeague is null
	begin
		insert into DimLeague(League) select @League
		select  @IDLeague = IDLeague from DimLeague where League = @League
	end
	if @IDTeamHome is null
	begin
		insert into DimTeam(Team, IDCountry) select @TeamHome, @IDCountry 
		select  @IDTeamHome = IDTeam from DimTeam where Team = @TeamHome 
	end
	if @IDTeamGuest is null
	begin
		insert into DimTeam(Team, IDCountry) select @TeamGuest, @IDCountry 
		select  @IDTeamGuest = IDTeam from DimTeam where Team = @TeamGuest
	end
end
	if @IDCountry is not null and @IDSeason   is not null and @IDLeague  is not null and @IDTeamHome  is not null and @IDTeamGuest is not null
	begin
		if not exists(select 1 from FactResult where IDCountry = @IDCountry and IDSeason = @IDSeason and IDLeague = @IDLeague and IDTeamHome = @IDTeamHome and IDTeamGuest = @IDTeamGuest)
		begin

			INSERT INTO [dbo].[FactResult]
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
					   ,[IDCountry]
					   ,[IDSeason]
					   ,[IDLeague]
					   ,[IDTeamHome]
					   ,[IDTeamGuest]
					   ,[LastUpdate]
					   ,[Stage]
					   ,[Sport]
					   ,[IDSport])
				 VALUES
					   (@Country
					   ,@Season
					   ,@League
					   ,@Tour
					   ,@MatchDate
					   ,@TeamHome
					   ,@TeamGuest
					   ,@GoalHome
					   ,@GoalGuest
					   ,isnull(@IDResultType,1)
					   ,@GoalHomePenalty
					   ,@GoalGuestPenalty
					   ,@IDCountry
					   ,@IDSeason
					   ,@IDLeague
					   ,@IDTeamHome
					   ,@IDTeamGuest
					   ,getdate()
					   ,@Stage
					   ,@Sport
					   ,@IDSport)

	end
	
		if exists(select 1 from FactResult where IDCountry = @IDCountry and IDSeason = @IDSeason and IDLeague = @IDLeague and IDTeamHome = @IDTeamHome and IDTeamGuest = @IDTeamGuest and GoalHome is null and GoalGuest is null and @GoalHome is not null and @GoalGuest is not null)
		begin
			update FactResult
			set GoalHome = @GoalHome
				,GoalGuest = @GoalGuest
				,GoalHomePenalty = @GoalHomePenalty
				,GoalGuestPenalty = @GoalGuestPenalty
				,MatchDate = @MatchDate
				,LastUpdate = getdate()	
				,Stage = @Stage
			where IDCountry = @IDCountry and IDSeason = @IDSeason and IDLeague = @IDLeague and IDTeamHome = @IDTeamHome and IDTeamGuest = @IDTeamGuest
		end

		if exists(select 1 from FactResult where IDCountry = @IDCountry and IDSeason = @IDSeason and IDLeague = @IDLeague and IDTeamHome = @IDTeamHome and IDTeamGuest = @IDTeamGuest and GoalHome is null and GoalGuest is null and MatchDate <> @MatchDate)
		begin
			update FactResult
			set MatchDate = @MatchDate
			where IDCountry = @IDCountry and IDSeason = @IDSeason and IDLeague = @IDLeague and IDTeamHome = @IDTeamHome and IDTeamGuest = @IDTeamGuest
		end
	end

end try



begin catch
	insert into FactLoadError(UpdateDate, VarStr)
	select getdate(), '@Country' + convert(varchar(100), @Country) + '; @Season = ' + convert(varchar(100), @Season) + '; @League = ' + convert(varchar(100),@League)
	        + '; @TeamHome = ' +  convert(varchar(100),@TeamHome) + '; @TeamGuest = ' + convert(varchar(100),@TeamGuest) +  '; @GoalHome = ' + convert(varchar(100),@GoalHome)
			+ '; @GoalGuest = ' + convert(varchar(100),@GoalGuest)
end catch

end

