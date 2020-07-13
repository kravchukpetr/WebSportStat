declare @IsAddValues int
,@Season varchar(50)
,@Country varchar(50)
,@League varchar(50)
,@Tour int
,@MatchDate date
,@TeamHome varchar(100)
,@TeamGuest varchar(100)
,@GoalHome int
,@GoalGuest int
,@IDResultType int
,@GoalHomePenalty int
,@GoalGuestPenalty int

select @IsAddValues = 1
select @Season = '2016-2017'
select @Country = 'Англия'
select @League = 'Премьер-лига'
select @Tour = 1
select @MatchDate = '2016-08-14'
select @TeamHome = 'Арсенал'
select @TeamGuest = 'Ливерпуль'
select @GoalHome = 3
select @GoalGuest = 4
select @IDResultType = 1

exec pSaveResult @IsAddValues, @Season, @Country, @League, @Tour, @MatchDate, @TeamHome, @TeamGuest, @GoalHome, @GoalGuest, @IDResultType, @GoalHomePenalty, @GoalGuestPenalty
--exec pSaveResult 1, '2016-08-14' , 'Англия', 'Премьер-лига', 1, '2016-08-14', 'Арсенал', 'Ливерпуль', 3, 4, 1, NULL, NULL
select top 100 * from FactResult where Country = @Country and Season = @Season and League = @League and MatchDate = @MatchDate and TeamHome = @TeamHome and TeamGuest = @TeamGuest
