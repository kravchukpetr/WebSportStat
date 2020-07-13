USE [SportStat]
GO

/****** Object:  UserDefinedFunction [dbo].fGetCountrySource]    Script Date: 09.10.2017 19:46:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fGetCountrySource]') AND type in (N'P', N'PC', N'TF')) DROP FUNCTION fGetCountrySource

go

CREATE FUNCTION [dbo].[fGetCountrySource] 
(@Type int = 1, 
 @Country VARCHAR(50) = null, 
 @IsExistsSource int = 1,
 @IsMainCountry int = null,
 @LeagueType int = null,
 @IsPrimary int = null
 )
RETURNS @SourceList TABLE
   (
     CurrentSource varchar(300),
	 Country varchar(50),
	 League varchar(50),
	 IsMainCountry int,
	 LeagueType int,
	 IsPrimary int,
	 IDSeasonType int
   )
AS
BEGIN
   INSERT @SourceList
		select LS.CurrentSource, C.Country, L.League, C.IsMain, L.IDLeagueType, L.IsPrimary, C.IDSeasonType
		from DimCountry C
		join DimLeague L on C.IDCountry = L.IDCountry
		left join DimLeagueSource LS on L.LeagueCurrentSource = LS.IDLeagueCurrentSource
		WHERE (@Type = 1 OR (@Type = 2 AND C.Country = @Country)) 
		And 
		((@IsExistsSource = 1 and LS.IDLeagueCurrentSource is not null) or isnull(@IsExistsSource,0) <> 1)
		And
		 (@IsMainCountry is null or C.IsMain = @IsMainCountry)
		 and 
		 (@LeagueType is null or L.IDLeagueType = @LeagueType)
		 and 
		 (@IsPrimary is null or L.IsPrimary = @IsPrimary)


   RETURN
END


GO


