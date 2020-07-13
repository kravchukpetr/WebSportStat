declare @Season varchar(50)
declare @Country varchar(50)
declare @League varchar(50)
declare @Tour int
declare @MatchDate date
declare @TeamHome varchar(100)
declare @TeamGuest varchar(100)
declare @PredictHome int
declare @PredictGuest int
declare @ProbHome numeric(20,4)
declare @ProbDraw numeric(20,4)
declare @ProbGuest numeric(20,4)
declare @Result int
declare @Score int
declare @PredictType int
declare @Comment varchar(100)

select @Season = '2017-2018'
select @Country = 'Англия'
select @League = 'Премьер-лига'
select @Tour = 28
select @MatchDate = '2018-02-24'
select @TeamHome = 'Бернли'
select @TeamGuest = 'Саутгемптон'
select @PredictHome = 1
select @PredictGuest = 11
select @ProbHome = 0.3126
select @ProbDraw = 0.2874
select @ProbGuest = 0.4001
select @Result = NULL
select @Score = NULL
select @PredictType = 1
select @Comment = NULL

exec pSavePredict @Season, @Country, @League, @Tour, @MatchDate, @TeamHome, @TeamGuest, @PredictHome, @PredictGuest, 
				  @ProbHome, @ProbDraw, @ProbGuest, @Result, @Score, @PredictType, @Comment