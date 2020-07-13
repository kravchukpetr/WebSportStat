USE [SportStat]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pGetCountryList]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pGetCountryList]
GO

create procedure pGetCountryList
@Lang int = 1,
@IsAddAll int = 1,
@Country varchar(100) = null
as
begin
	if isnull(@IsAddAll,0) <> 1
	begin

		select case when @Lang = 1 then Country else CountryEng end as Country, IsMain, IDSeasonType
		from DimCountry
		where @Country  is null or Country = @Country
		order by  case when @Lang = 1 then Country else CountryEng end

	end

	if isnull(@IsAddAll,0) = 1
	begin

		select case when @Lang = 1 then Country else CountryEng end as Country, IsMain, IDSeasonType
		from DimCountry
		where @Country  is null or Country = @Country
		union all 
		select case when @Lang = 1 then 'Все' else 'All' end, 1, 1
		order by  case when @Lang = 1 then Country else CountryEng end

	end
end
