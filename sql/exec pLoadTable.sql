--формирование таблицы

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

select @Season = '2019-2020'
select @Country = 'Испания'
select @League = 'Примера'
select @TypeTable = 'Всего'--Всего/Дома/В гостях
select @IsDetailTable =  1 --нужно ли выводить детализацию дома/в гостях: 1 - да; 0 - нет
select @TypeTour = 'Full'-- тип тура: 'Full' - на текущий момент; 'LastTours' - за последние @LastTours туров; 'OnTour' - на @TourNumber тур; 'OnDate' - на @TourDate дату
select @LastTours = NULL
select @TourNumber = NULL
select @TourDate = NULL
select @IDSport = 1
select @TypeReturn = 1 -- 1 - вывод dataset; 2 - запись в таблицу

exec SportStat.dbo.pLoadTable @Season, @Country, @League, @TypeTable, @IsDetailTable,
							  @TypeTour, @LastTours, @TourNumber, @TourDate, @IDSport, @TypeReturn


--exec SportStat.dbo.pLoadTable '2017-2018', 'Италия', 'Серия A', 'Всего', 0, 'Full'--, NULL, NULL, NULL
--exec pGetCountryList 2
--exec pGetLeagueList


--exec pGetResults 1, 'Италия', 'Серия A', '2017-2018'

