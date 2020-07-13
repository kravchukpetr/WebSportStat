USE [SportStat]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSavePredict]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pSavePredict]
GO

create procedure pSavePredict
 @Season varchar(50)
,@Country varchar(50)
,@League varchar(50)
,@Tour int
,@MatchDate date
,@TeamHome varchar(100)
,@TeamGuest varchar(100)
,@PredictHome int
,@PredictGuest int
,@ProbHome numeric(20,4)
,@ProbDraw numeric(20,4)
,@ProbGuest numeric(20,4)
,@Result int
,@Score int
,@PredictType int
,@Comment varchar(100)

as
begin

declare @IDFactResult bigint

select @IDFactResult = IDFactResult
from FactResult
where Season = @Season  AND Country = @Country AND League = @League AND MatchDate = convert(date, @MatchDate) AND TeamHome = @TeamHome AND TeamGuest = @TeamGuest

if @IDFactResult is not null
begin

if exists(select 1 from FactPredict where IDFactResult = @IDFactResult AND PredictType = @PredictType)
begin
	delete from FactPredict where IDFactResult = @IDFactResult AND PredictType = @PredictType
end


INSERT INTO FactPredict
(
  IDFactResult,
  PredictHome,
  PredictGuest,
  ProbHome,
  ProbDraw,
  ProbGuest,
  --Result,
  --Score,
  PredictType,
  Comment,
  DateCreate

)
select 
  @IDFactResult,
  @PredictHome,
  @PredictGuest,
  @ProbHome,
  @ProbDraw,
  @ProbGuest,
  --@Result,
  --@Score,
  @PredictType,
  @Comment,
  getdate()

end
end

