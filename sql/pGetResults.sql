USE [SportStat]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pGetResults]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pGetResults]
GO

create procedure pGetResults
@TypeSelect int = 1,
@Country varchar(100),
@League varchar(100),
@Season varchar(100),
@Tour int = NULL,
@DateFrom varchar(20) = NULL,
@DateTO varchar(20) = NULL,
@IsShowPredict int = 0
as
begin
	
	set nocount on;
	
	declare @DtFrom datetime
	declare @DtTO datetime

	BEGIN TRY

	select @DtFrom = convert(date, @DateFrom, 104)
	select @DtTo = convert(date, @DateTO, 104)

	END TRY


	BEGIN CATCH

	select @DtFrom = convert(date, @DateFrom, 120)
	select @DtTo = convert(date, @DateTO, 120)

	END CATCH

	if isnull(@League, 'NA') = 'NA'
	begin
		select @League = L.League from DimLeague L
		join DimCountry C on L.IDCountry = C.IDCountry
		where C.Country = @Country
	end

	if @IsShowPredict = 0 
	begin
		select Country as 'Страна', Tour as 'Тур',  convert(varchar, MatchDate, 104) as 'Дата', TeamHome as 'Хозяева',  GoalHome as 'ГХ', GoalGuest as 'ГГ', TeamGuest as 'Гости'
		from FactResult 
		where ((@Country = 'Все' or (Country = @Country and League =  @League)) AND Season = @Season) AND
		(@TypeSelect = 1 OR (@TypeSelect = 2 AND Tour = @Tour) OR (@TypeSelect = 3 AND  MatchDate between @DtFrom AND @DtTO))
		order by Country, Tour
	end
	if @IsShowPredict = 1 
	begin
		select FR.Country as 'Страна', FR.Tour as '№',  convert(varchar, FR.MatchDate, 104) as 'Дата', FR.TeamHome as 'Хозяева',  FR.GoalHome as 'ГХ', 
				FR.GoalGuest as 'ГГ', FR.TeamGuest as 'Гости', FP.PredictHome as 'PH', FP.PredictGuest  as 'PG', FP.ProbHome  as 'PrH', FP.ProbDraw  as 'PrD', FP.ProbGuest  as 'PG', 
				case 
						when FP.PredictHome is null then null
						when FR.GoalHome > FR.GoalGuest And FP.PredictHome > FP.PredictGuest then 1
						when FR.GoalHome < FR.GoalGuest And FP.PredictHome < FP.PredictGuest then 1
						when FR.GoalHome = FR.GoalGuest And FP.PredictHome = FP.PredictGuest then 1
						else 0
				end
				as 'R', 
				case 
						when FP.PredictHome is null then null
						when FR.GoalHome >= FR.GoalGuest And FP.PredictHome > FP.PredictGuest then 1
						when FR.GoalHome <= FR.GoalGuest And FP.PredictHome < FP.PredictGuest then 1
						when FR.GoalHome >= FR.GoalGuest And FP.PredictHome = FP.PredictGuest And FP.ProbHome > FP.ProbGuest then 1
						when FR.GoalHome <= FR.GoalGuest And FP.PredictHome = FP.PredictGuest And FP.ProbHome < FP.ProbGuest then 1
						when FR.GoalHome = FR.GoalGuest And FP.PredictHome = FP.PredictGuest then 1
						else 0
				end as 'RX',
				case when PredictHome is null then null
					 when GoalHome = PredictHome And GoalGuest = PredictGuest  then 1
					 else 0
		   		End as 'S',
				case when (case when FP.ProbHome >FP.ProbGuest then FP.ProbHome else FP.ProbGuest End) > FP.ProbDraw
					then (case when FP.ProbHome >FP.ProbGuest then FP.ProbHome else FP.ProbGuest End) else FP.ProbDraw
				end as 'MC'
		from FactResult FR
		left join FactPredict FP on FR.IDFactResult = FP.IDFactResult
		where ((@Country = 'Все' or (FR.Country = @Country and FR.League =  @League)) AND FR.Season = @Season) AND
		(@TypeSelect = 1 OR (@TypeSelect = 2 AND FR.Tour = @Tour) OR (@TypeSelect = 3 AND  FR.MatchDate between @DtFrom AND @DtTO))
		order by  FR.Country, FR.Tour
	end
end

