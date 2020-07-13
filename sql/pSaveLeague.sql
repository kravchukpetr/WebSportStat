USE [SportStat]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSaveLeague]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pSaveLeague]
GO

create procedure pSaveLeague
--входящие параметры
 @Country varchar(50)
,@CountryEng varchar(50)
,@League varchar(50)
,@LeagueEng varchar(50)
,@LeagueIndex int = 1
,@LeagueSource varchar(300)
,@IDLeagueType int = 1
,@IsMainCountry int
as
begin

declare @IDCountry int
declare @IDLeague int

if not exists (select  1 from DimCountry where Country = @Country)
begin

	insert into DimCountry(Country, CountryEng, IsMain)
	select @Country, @CountryEng, @IsMainCountry	

end

select @IDCountry = IDCountry from DimCountry where Country = @Country

if @IDLeagueType = 1
begin

	if not exists (select  1 from DimLeague where IDCountry = @IDCountry and IsPrimary = @Leagueindex)
	begin

		insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary)
		select @League, @IDcountry, @IDLeagueType, @LeagueEng, @Leagueindex 
 
	end

end

if @IDLeagueType <> 1
begin

	if not exists (select  1 from DimLeague where IDCountry = @IDCountry And IDLeagueType = @IDLeagueType)
	begin

		insert into DimLeague(League, IDCountry, IDLeagueType, LeagueEng, IsPrimary)
		select @League, @IDcountry, @IDLeagueType, @LeagueEng, @Leagueindex 
 
	end

end

if @IDLeagueType = 1
begin
	select @IDLeague = IDLeague from DimLeague where IDCountry = @IDCountry and IsPrimary = @Leagueindex
end
if @IDLeagueType <> 1
begin
	select @IDLeague = IDLeague from DimLeague where IDCountry = @IDCountry and League = @League
end

if @LeagueSource is not null
begin

	if not exists(select 1 from DimLeagueSource where IDCountry = @IDCountry and IDLeague = @IDLeague)
	begin

		insert into DimLeagueSource(CurrentSource, Country, IDCountry, IDLeague, League)
		select @LeagueSource, @Country, @IDCountry, @IDLeague, @League

	end

end

end
