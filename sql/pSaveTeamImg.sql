USE [SportStat]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSaveTeamImg]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pSaveTeamImg]
GO

create procedure pSaveTeamImg
--входящие параметры
 @Team varchar(100)
,@Country  varchar(100)
,@Img VARBINARY (MAX)
,@TypeImg int = 1
,@YearFound int = null	
,@Color varchar(100) = null
,@Stadium varchar(100) = null
,@StadiumNumber int = null
,@Coach varchar(100) = null

as
begin

declare @IDTeam int 
declare @IDCountry int 

select @IDTeam = IDTeam from DimTeam where Team = @Team 
select @IDCountry = IDCountry from DimCountry where Country = @Country

if @IDTeam is null
begin
	insert into DimTeam(Team, IDCountry) select @Team, @IDCountry 
end


if @TypeImg = 1
begin
	update DimTeam
	set ImgSmall = @Img
	where Team = @Team
end

if @TypeImg = 2
begin
	
	update DimTeam
	set ImgBig = @Img,
		YearFound = case when @YearFound is not null then @YearFound else YearFound end,	
		Color = case when @Color is not null then @Color else Color end, 
	    Stadium = case when @Stadium is not null then @Stadium else Stadium end,
		StadiumNumber = case when @StadiumNumber is not null then @StadiumNumber else StadiumNumber end,
		Coach = case when @Coach is not null then @Coach else Coach end,
		IsInfoExist = 1
	where Team = @Team and isnull(IsInfoExist,0) = 0
end

end
