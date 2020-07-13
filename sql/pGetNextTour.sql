USE [SportStat]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pGetNextTour]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pGetNextTour]
GO

create procedure pGetNextTour
@Type int = 1,
@Country varchar(100),
@League varchar(100),
@Season varchar(100) = NULL,
@Dt datetime = NULL
as
begin

set nocount on;
if @Dt is null select @Dt = convert(date, getdate())
declare @Tour int

if @Type = 1
begin

	select @Tour = MIN(Tour)
	from FactResult 
	where Country = @Country and League =  @League AND Season = @Season AND MatchDate>=@Dt AND GoalHome is null

	if @Tour is null
	begin
			select @Tour = MAX(Tour)
			from FactResult 
			where Country = @Country and League =  @League AND Season = @Season AND MatchDate<=@Dt AND GoalHome is not null
	end

end

if @Type = 2
begin

	select @Tour = MAX(Tour)
	from FactResult 
	where Country = @Country and League =  @League AND Season = @Season AND MatchDate<=@Dt AND GoalHome is not null

	if @Tour is null
	begin
		select @Tour = MIN(Tour)
		from FactResult 
		where Country = @Country and League =  @League AND Season = @Season AND MatchDate>=@Dt AND GoalHome is null
	end

end


select @Tour as Tour

end