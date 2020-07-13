--создание основных таблиц
--DimCountry
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DimCountry]') AND type in (N'U', N'V'))
DROP TABLE [dbo].[DimCountry]
GO
create table DimCountry
(
  IDCountry int not null IDENTITY(1,1),
  Country varchar(100),
  CountryEng varchar(100),
  IsMain int null,
  IDSeasonType int null,
 CONSTRAINT [PK_DimCountry] PRIMARY KEY CLUSTERED 
(
	[IDCountry] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
Go
--DimSeason
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DimSeason]') AND type in (N'U', N'V'))
DROP TABLE [dbo].[DimSeason]
GO
create table DimSeason
(
  IDSeason int not null IDENTITY(1,1),
  Season varchar(100),
  IsCurrentSeason int, 
  IDSeasonType int,
 CONSTRAINT [PK_DimSeason] PRIMARY KEY CLUSTERED 
(
	[IDSeason] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
Go
--DimLeague
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DimLeague]') AND type in (N'U', N'V'))
DROP TABLE [dbo].[DimLeague]
GO
create table DimLeague
(
  IDLeague int not null IDENTITY(1,1),
  League varchar(100),
  IDCountry int NULL,
  IDLeagueType int NULL,
  LeagueEng varchar(100),
  LeagueCurrentSource int null,
  IsPrimary int null,
  LeagueImg varbinary(max),
  LeagueImgSrc varchar(100),
 CONSTRAINT [PK_DimLeague] PRIMARY KEY CLUSTERED 
(
	[IDLeague] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
Go

--DimLeagueCurrentSource
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DimLeagueSource]') AND type in (N'U', N'V'))
DROP TABLE [dbo].[DimLeagueSource]
GO
create table DimLeagueSource
(
  IDLeagueCurrentSource int not null IDENTITY(1,1),
  CurrentSource varchar(100) NULL,
  Country varchar(100) NULL,
  IDCountry int NULL,
  IDLeague int,
  League  varchar(100)
 CONSTRAINT [PK_DimLeagueSource] PRIMARY KEY CLUSTERED 
(
	[IDLeagueCurrentSource] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
Go

--DimLeagueType
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DimLeagueType]') AND type in (N'U', N'V'))
DROP TABLE [dbo].[DimLeagueType]
GO
create table DimLeagueType
(
  IDLeagueType int not null IDENTITY(1,1),
  LeagueType varchar(100),
 CONSTRAINT [PK_DimLeagueType] PRIMARY KEY CLUSTERED 
(
	[IDLeagueType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
Go

--DimResultType
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DimResultType]') AND type in (N'U', N'V'))
DROP TABLE [dbo].[DimResultType]
GO
create table DimResultType
(
  IDResultType int not null IDENTITY(1,1),
  ResultType varchar(100),
 CONSTRAINT [PK_DimResultType] PRIMARY KEY CLUSTERED 
(
	[IDResultType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
Go

--DimTeam
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DimTeam]') AND type in (N'U', N'V'))
DROP TABLE [dbo].[DimTeam]
GO
create table DimTeam
(
  IDTeam int not null IDENTITY(1,1),
  Team varchar(300),
  TeamEng varchar(100) NULL,
  IDCountry int NULL,
  ImgSmall  VARBINARY (MAX) NULL, 
  ImgSBig  VARBINARY (MAX) NULL, 
  YearFound int null,	
  Color varchar(100) null,
  Stadium varchar(100) null,
  StadiumNumber int null,
  Coach varchar(100) null,
  IsInfoExist int null,
 CONSTRAINT [PK_DimTeam] PRIMARY KEY CLUSTERED 
(
	[IDTeam] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
Go

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FactResult]') AND type in (N'U', N'V'))
DROP TABLE [dbo].[FactResult]
GO
create table FactResult
(
  IDFactResult bigint not null IDENTITY(1,1),
  Country varchar(255) null, 
  Season  varchar(255) null, 
  League  varchar(255) null, 
  Tour int  null, 
  MatchDate date null, 
  TeamHome  varchar(255) null, 
  TeamGuest  varchar(255) null,
  GoalHome  int null, 
  GoalGuest int null, 
  IDResultType int null,
  GoalHomePenalty int null,
  GoalGuestPenalty int null,
  IDCountry int null, 
  IDSeason  int null, 
  IDLeague  int null, 
  IDTeamHome  int null, 
  IDTeamGuest  int null,
  LastUpdate datetime,
  Sport varchar(50) null,
  IDSport int 
 CONSTRAINT [PK_FactResult] PRIMARY KEY CLUSTERED 
(
	[IDFactResult] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
Go

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FactLoadError]') AND type in (N'U', N'V'))
DROP TABLE [dbo].[FactLoadError]
GO
create table FactLoadError
(
  IDLoadError int not null IDENTITY(1,1),
  VarStr varchar(1000),
  UpdateDate datetime,
 CONSTRAINT [PK_FactLoadError] PRIMARY KEY CLUSTERED 
(
	[IDLoadError] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
Go

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FactPredict]') AND type in (N'U', N'V'))
DROP TABLE [dbo].[FactPredict]
GO
create table FactPredict
(
  IDFactPredict bigint not null IDENTITY(1,1),
  IDFactResult bigint,
  PredictHome int,
  PredictGuest int,
  ProbHome numeric(20,4),
  ProbDraw numeric(20,4),
  ProbGuest numeric(20,4),
  Result as case 
					when PredictHome is null then null
					when GoalHome > GoalGuest And PredictHome > PredictGuest then 1
					when GoalHome < GoalGuest And PredictHome < PredictGuest then 1
					when GoalHome = GoalGuest And PredictHome = PredictGuest then 1
					else 0
			end,
  Score  as case when PredictHome is null then null
				 when GoalHome = PredictHome And GoalGuest = PredictGuest  then 1
				 else 0
		   	End,
  PredictType int,
  Comment varchar(100),
  DateCreate datetime,
 CONSTRAINT [PK_FactPredict] PRIMARY KEY CLUSTERED 
(
	[IDFactPredict] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
Go

--DimPosLink
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DimPosLink]') AND type in (N'U', N'V'))
DROP TABLE [dbo].[DimPosLink]
GO
create table DimPosLink
(
  IDPosLink int not null IDENTITY(1,1),
  IDSport int null,
  IDCountry int null,
  IDLeague int null,
  Sport  varchar(100) null,
  Country varchar(100) null,
  League  varchar(100) null,
  PosFrom int null,
  PosTo int null,
  PosType int null,
  Season varchar(30) null,
  IDSeason int null,
 CONSTRAINT [PK_DimPosLink] PRIMARY KEY CLUSTERED 
(
	[IDPosLink] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
Go

--DimSportCountryLink
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DimSportCountryLink]') AND type in (N'U', N'V'))
DROP TABLE [dbo].[DimSportCountryLink]
GO
create table DimSportCountryLink
(
  IDSportCountryLink int not null IDENTITY(1,1),
  IDSport int null,
  IDCountry int null,
  Sport  varchar(100) null,
  Country varchar(100) null,
 CONSTRAINT [PK_DimSportCountryLink] PRIMARY KEY CLUSTERED 
(
	[IDSportCountryLink] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
Go

--FactStanding
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FactStanding]') AND type in (N'U', N'V'))
DROP TABLE [dbo].[FactStanding]
GO

CREATE TABLE [dbo].[FactStanding](
	[IDFactStanding] [bigint] IDENTITY(1,1) NOT NULL,
	[IDSport] [int] NULL,
	[Country] [varchar](255) NULL,
	[Season] [varchar](255) NULL,
	[League] [varchar](255) NULL,
	[IDCountry] [int] NULL,
	[IDSeason] [int] NULL,
	[IDLeague] [int] NULL,
	[TypeTour] [varchar](20) NULL,
	[LastTours] [int] NULL,
	[TourNumber] [int] NULL,
	[TourDate] [date] NULL,
	[Position] [int] NOT NULL,
	[Team] [varchar](100) NULL,
	[CountGames] [int] NULL,
	[CountWin] [int] NULL,
	[CountDraw] [int] NULL,
	[CountLose] [int] NULL,
	[GoalWin] [int] NULL,
	[GoalLose] [int] NULL,
	[GoalDifference] [varchar](20) NULL,
	[CountPoint] [int] NULL,
	[CountGamesHome] [int] NULL,
	[CountWinHome] [int] NULL,
	[CountDrawHome] [int] NULL,
	[CountLoseHome] [int] NULL,
	[GoalWinHome] [int] NULL,
	[GoalLoseHome] [int] NULL,
	[GoalDifferenceHome] [varchar](20) NULL,
	[CountPointHome] [int] NULL,
	[CountGamesGuest] [int] NULL,
	[CountWinGuest] [int] NULL,
	[CountDrawGuest] [int] NULL,
	[CountLoseGuest] [int] NULL,
	[GoalWinGuest] [int] NULL,
	[GoalLoseGuest] [int] NULL,
	[CountPointGuest] [int] NULL,
	[GoalDifferenceGuest] [varchar](20) NULL,
	[IDTeam] [int] NULL,
	[PosType] [int] NULL,
	[LastGames] [varchar](1000) NULL,
 CONSTRAINT [PK_FactStanding] PRIMARY KEY CLUSTERED 
(
	[IDFactStanding] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO




--загрузка данных в таблицы
DELETE FROM DimCountry
DBCC CHECKIDENT (DimCountry, RESEED, 0)
insert into DimCountry(Country)
select distinct Country from ResultTmp order by Country

DELETE FROM DimSeason
DBCC CHECKIDENT (DimSeason, RESEED, 0)
insert into DimSeason(Season)
select distinct Season from ResultTmp order by Season

DELETE FROM DimLeague
DBCC CHECKIDENT (DimLeague, RESEED, 0)
insert into DimLeague(League)
select distinct League from ResultTmp order by League

DELETE FROM DimLeagueType
DBCC CHECKIDENT (DimLeagueType, RESEED, 0)
DELETE FROM DimLeagueType
DBCC CHECKIDENT (DimLeagueType, RESEED, 0)

insert into DimLeagueType select 'Чемпионат страны'
insert into DimLeagueType select 'Кубок страны'
insert into DimLeagueType select 'Лига Чемпионов'
insert into DimLeagueType select 'Лига Европы'
insert into DimLeagueType select 'Кубок УЕФА'

DELETE FROM DimResultType
DBCC CHECKIDENT (DimResultType, RESEED, 0)
DELETE FROM DimResultType
DBCC CHECKIDENT (DimResultType, RESEED, 0)

insert into DimResultType select 'Основное время'
insert into DimResultType select 'Дополнительное время'
insert into DimResultType select 'Послематчевые пенальти'

update DimLeague
set IDCountry = C.IDCountry,
    IDLeagueType = 1  
from  DimLeague L
join ResultTmp R on L.League = R.League
join DimCountry C on C.Country = R.Country

--FactPlayer
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FactPlayer]') AND type in (N'U', N'V'))
DROP TABLE [dbo].[FactPlayer]
GO
create table FactPlayer
(
  IDPlayer int not null IDENTITY(1,1),
  Player varchar(200),
  PlayerEng varchar(200),
  IDTeam int,
  Team varchar(100),
  Amplua varchar(5),
  Games int,
  Goals int,
  Pass int,
  YellowCard int,
  RedCard int,
  GoalsGK int,
 CONSTRAINT [PK_FactPlayer] PRIMARY KEY CLUSTERED 
(
	[IDPlayer] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
Go

--DimNation
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DimNation]') AND type in (N'U', N'V'))
DROP TABLE [dbo].[DimNation]
GO
create table DimNation
(
  IDNation int not null IDENTITY(1,1),
  Nation varchar(100),
  NationUrl varchar(100),
  NationImg varbinary(max),
 CONSTRAINT [PK_DimNation] PRIMARY KEY CLUSTERED 
(
	[IDNation] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

--DimSeasonType
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DimSeasonType]') AND type in (N'U', N'V'))
DROP TABLE [dbo].[DimSeasonType]
GO
create table DimSeasonType
(
  IDSeasonType int not null IDENTITY(1,1),
  SeasonType varchar(100),

 CONSTRAINT [PK_DimSeasonType] PRIMARY KEY CLUSTERED 
(
	[IDSeasonType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
Go

DELETE FROM DimSeasonType
DBCC CHECKIDENT (DimSeasonType, RESEED, 0)
DELETE FROM DimSeasonType
DBCC CHECKIDENT (DimSeasonType, RESEED, 0)

insert into DimSeasonType(SeasonType) select 'Тип 1 - Два календарных года'
insert into DimSeasonType(SeasonType) select 'Тип 2 - Один календарный год'

--FactLogs
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FactLogs]') AND type in (N'U', N'V'))
DROP TABLE [dbo].[FactLogs]
GO
create table FactLogs
(
  IDFactLog int not null IDENTITY(1,1),
  Dt datetime,
  LogMsg varchar(1000),
  OperType varchar(100),
  Sport varchar(100),
  Country varchar(100),
  League varchar(100),
  Season varchar(20),
  OperStatus int
 CONSTRAINT [PK_IDFactLog] PRIMARY KEY CLUSTERED 
(
	[IDFactLog] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
Go


/*
DELETE FROM DimTeam 
DBCC CHECKIDENT (DimTeam, RESEED, 0)
insert into DimTeam(Team, IDCountry)
select distinct T.Team, C.IDCountry  from
(select TeamHome  as Team, Country from ResultTmp
union
select TeamGuest as Team, Country  from ResultTmp) T
left join DimCountry C on T.Country = C.Country 
order by  T.Team

--FactResult
DELETE FROM FactResult
DBCC CHECKIDENT (FactResult, RESEED, 0)
insert into FactResult
(
  Country, 
  Season, 
  League, 
  Tour, 
  MatchDate, 
  TeamHome, 
  TeamGuest,
  GoalHome, 
  GoalGuest, 
  IDResultType,
  GoalHomePenalty,
  GoalGuestPenalty,
  IDCountry, 
  IDSeason, 
  IDLeague, 
  IDTeamHome, 
  IDTeamGuest
  )
  select 
  RT.Country, 
  RT.Season, 
  RT.League, 
  cast(replace(Rtrim(LTrim(RT.Tour)),'-Й ТУР', '') as int),
  RT.MatchDate, 
  RT.TeamHome, 
  RT.TeamGuest,
  cast(RT.GoalHome as int), 
  cast(RT.GoalGuest as int),
  1,
  NULL,
  NULL,
  C.IDCountry, 
  S.IDSeason, 
  L.IDLeague, 
  TH.IDTeam, 
  TG.IDTeam
  from ResultTmp  RT
  left join DimCountry C on RT.Country = C.Country
  left join DimSeason S on RT.Season = S.Season 
  left join DimLeague L on RT.League = L.League 
  left join DimTeam TH on RT.TeamHome = TH.Team
  left join DimTeam TG on RT.TeamGuest = TG.Team
  
  
--просмотр данных в таблицах
select * from DimCountry
select * from DimSeason
select * from DimLeague
select * from DimLeagueType
select * from DimTeam
select * from DimResultType
select * from ResultTmp 
select * from FactResult 
select COUNT(*) from ResultTmp 

--загрузка данных в ResultTmp
use SportStat 
go
insert into ResultTmp(Country, Season, League, Tour, MatchDate, TeamHome, GoalHome, GoalGuest, TeamGuest)
select Country, Season, League, Tour, MatchDate, TeamHome, GoalHome, GoalGuest, TeamGuest from  dbo.['2005-2006$']
union all
select Country, Season, League, Tour, MatchDate, TeamHome, GoalHome, GoalGuest, TeamGuest from  dbo.['2006-2007$']
union all
select Country, Season, League, Tour, MatchDate, TeamHome, GoalHome, GoalGuest, TeamGuest from  dbo.['2007-2008$']
union all
select Country, Season, League, Tour, MatchDate, TeamHome, GoalHome, GoalGuest, TeamGuest from  dbo.['2008-2009$']
union all
select Country, Season, League, Tour, MatchDate, TeamHome, GoalHome, GoalGuest, TeamGuest from  dbo.['2009-2010$']
union all
select Country, Season, League, Tour, MatchDate, TeamHome, GoalHome, GoalGuest, TeamGuest from  dbo.['2010-2011$']
union all
select Country, Season, League, Tour, MatchDate, TeamHome, GoalHome, GoalGuest, TeamGuest from  dbo.['2011-2012$']
union all
select Country, Season, League, Tour, MatchDate, TeamHome, GoalHome, GoalGuest, TeamGuest from  dbo.['2012-2013$']
union all
select Country, Season, League, Tour, MatchDate, TeamHome, GoalHome, GoalGuest, TeamGuest from  dbo.['2013-2014$']
union all
select Country, Season, League, Tour, MatchDate, TeamHome, GoalHome, GoalGuest, TeamGuest from  dbo.['2014-2015$']

go
drop table dbo.['2005-2006$']
drop table dbo.['2006-2007$']
drop table dbo.['2007-2008$']
drop table dbo.['2008-2009$']
drop table dbo.['2009-2010$']
drop table dbo.['2010-2011$']
drop table dbo.['2011-2012$']
drop table dbo.['2012-2013$']
drop table dbo.['2013-2014$']
drop table dbo.['2014-2015$']

*/
