use SportStat
go

USE [SportStat]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pCalcAllStand]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pCalcAllStand]
GO

create procedure pCalcAllStand
@IsCurrentSeason int = null,
@CountryInput varchar(100) = null
as
BEGIN

declare @Season varchar(50)
declare @Country varchar(50)
declare @League varchar(50)
declare @TypeTable varchar(50)
declare @IsDetailTable int 
declare @TypeTour varchar(20)
declare @LastTours int
declare @TourNumber int
declare @TourDate date
declare @IDSport int
declare @TypeReturn int
DECLARE @IDCountry int
DECLARE @IDSeasonType int
DECLARE @MaxID int

select @TypeTable = 'Всего'--Всего/Дома/В гостяхa
select @IsDetailTable =  1 --нужно ли выводить детализацию дома/в гостях: 1 - да; 0 - нет
select @TypeTour = 'Full'-- тип тура: 'Full' - на текущий момент; 'LastTours' - за последние @LastTours туров; 'OnTour' - на @TourNumber тур; 'OnDate' - на @TourDate дату
select @LastTours = NULL
select @TourNumber = NULL
select @TourDate = NULL
select @IDSport = 1
select @TypeReturn = 2 -- 1 - вывод dataset; 2 - записьв таблицу


  
--Country
DECLARE country_cursor CURSOR FOR   
SELECT Country, IDCountry, IDSeasonType  FROM DimCountry
where @CountryInput is null or Country = @CountryInput
ORDER BY IDCountry

OPEN country_cursor    
FETCH NEXT FROM country_cursor   
INTO @Country, @IDCountry, @IDSeasonType 
  
WHILE @@FETCH_STATUS = 0  
BEGIN
	
	--League
	DECLARE league_cursor CURSOR FOR   
	SELECT League  FROM DimLeague
	WHERE IDCountry = @IDCountry and IDLeagueType = 1
	ORDER BY IDLeague
	
	OPEN league_cursor    
	FETCH NEXT FROM league_cursor   
	INTO @League
  
	WHILE @@FETCH_STATUS = 0  
	BEGIN

		DECLARE season_cursor CURSOR FOR   
		SELECT Season  FROM DimSeason
		WHERE  IDSeasonType  =  @IDSeasonType and (@IsCurrentSeason is null or IsCurrentSeason = @IsCurrentSeason)
		ORDER BY Season;    

		--Season
		OPEN season_cursor    
		FETCH NEXT FROM season_cursor   
		INTO @Season  
  
		WHILE @@FETCH_STATUS = 0  
		BEGIN  

			print @Season + ' ' + @Country + ' ' + @League
			INSERT INTO FactLogs(Dt, OperType, Sport, Country, League, Season, OperStatus)
			SELECT getdate(), 'Расчет таблицы', 'Футбол', @Country, @League, @Season, 2
			
			select @MaxID = max(IDFactLog) from FactLogs where OperType = 'Расчет таблицы' and Country = @Country 
			and League = @League and Season = @Season and OperStatus = 2

			begin try
			exec SportStat.dbo.pLoadTable @Season, @Country, @League, @TypeTable, @IsDetailTable,
									@TypeTour, @LastTours, @TourNumber, @TourDate, @IDSport, @TypeReturn
			update FactLogs
			set OperStatus = 3
			where OperType = 'Расчет таблицы' and IDFactLog = @MaxID and OperStatus = 2

			end try
			begin catch

			update FactLogs
			set OperStatus = 4
			where OperType = 'Расчет таблицы' and IDFactLog = @MaxID and OperStatus = 2

			end catch
		FETCH NEXT FROM season_cursor   
		INTO @Season  
		END   

		CLOSE season_cursor  
		DEALLOCATE season_cursor
   
	FETCH NEXT FROM league_cursor   
	INTO @League  
	END   

	CLOSE league_cursor  
	DEALLOCATE league_cursor

FETCH NEXT FROM country_cursor   
INTO @Country, @IDCountry,  @IDSeasonType    
END   

CLOSE country_cursor  
DEALLOCATE country_cursor
   

END