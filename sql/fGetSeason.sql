USE [SportStat]
GO

/****** Object:  UserDefinedFunction [dbo].fGetSeason]    Script Date: 09.10.2017 19:46:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fGetSeason]') AND type in (N'P', N'PC', N'TF')) DROP FUNCTION fGetSeason

go

CREATE FUNCTION [dbo].[fGetSeason] (@Type int = 1, @Season VARCHAR(50) = null, @IDSeasonType int = 1)
RETURNS @SourceList TABLE
   (
     Substance varchar(300)
   )
AS
BEGIN
   INSERT @SourceList
		select S.Season from DimSeason S
		WHERE (@Type = 1 OR (@Type = 2 AND IsCurrentSeason = 1) OR (@Type = 3 AND S.Season = @Season))
			AND IDSeasonType = @IDSeasonType


   RETURN
END


GO


