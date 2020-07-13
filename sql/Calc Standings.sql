use SportStat
go


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

select @TypeTable = 'Всего'--Всего/Дома/В гостяхa
select @IsDetailTable =  1 --нужно ли выводить детализацию дома/в гостях: 1 - да; 0 - нет
select @TypeTour = 'Full'-- тип тура: 'Full' - на текущий момент; 'LastTours' - за последние @LastTours туров; 'OnTour' - на @TourNumber тур; 'OnDate' - на @TourDate дату
select @LastTours = NULL
select @TourNumber = NULL
select @TourDate = NULL
select @IDSport = 1
select @TypeReturn = 2 -- 1 - вывод dataset; 2 - записьв таблицу


DECLARE season_cursor CURSOR FOR   
SELECT Season  FROM DimSeason
ORDER BY Season;    

--Season
OPEN season_cursor    
FETCH NEXT FROM season_cursor   
INTO @Season  
  
WHILE @@FETCH_STATUS = 0  
BEGIN  
  
	--Country
	DECLARE country_cursor CURSOR FOR   
	SELECT Country, IDCountry  FROM DimCountry
	ORDER BY IDCountry

	OPEN country_cursor    
	FETCH NEXT FROM country_cursor   
	INTO @Country, @IDCountry  
  
	WHILE @@FETCH_STATUS = 0  
	BEGIN
	
		--League
		DECLARE league_cursor CURSOR FOR   
		SELECT League  FROM DimLeague
		WHERE IDCountry = @IDCountry
		ORDER BY IDLeague
	
		OPEN league_cursor    
		FETCH NEXT FROM league_cursor   
		INTO @League
  
		WHILE @@FETCH_STATUS = 0  
		BEGIN

		print @Season + ' ' + @Country + ' ' + @League
		exec SportStat.dbo.pLoadTable @Season, @Country, @League, @TypeTable, @IsDetailTable,
							  @TypeTour, @LastTours, @TourNumber, @TourDate, @IDSport, @TypeReturn
   
		FETCH NEXT FROM league_cursor   
		INTO @League  
		END   

		CLOSE league_cursor  
		DEALLOCATE league_cursor

	FETCH NEXT FROM country_cursor   
	INTO @Country, @IDCountry   
	END   

	CLOSE country_cursor  
	DEALLOCATE country_cursor
   
FETCH NEXT FROM season_cursor   
INTO @Season  
END   

CLOSE season_cursor  
DEALLOCATE season_cursor