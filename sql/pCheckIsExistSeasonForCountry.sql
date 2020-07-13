USE [SportStat]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pCheckIsExistSeasonForCountry]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pCheckIsExistSeasonForCountry]
GO

create procedure pCheckIsExistSeasonForCountry
@Country varchar(100),
@League varchar(100),
@Season varchar(100)
as
begin

set nocount on;
declare @IsExist int 
select @IsExist = 0
if exists(select top 1 Country
		from FactResult 
		where (Country = @Country and League =  @League AND Season = @Season))
		begin
			select @IsExist = 1
		end

select @IsExist as IsExist
end