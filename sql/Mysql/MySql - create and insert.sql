use sportstat;
CREATE TABLE DimCountry (
	IDCountry int NOT NULL,
	Country varchar(100) NULL,
	CountryEng varchar(100) NULL,
    PRIMARY KEY (IDCountry)
);

INSERT INTO DimCountry(IDCountry, Country, CountryEng) SELECT 1, 'Испания', 'Spain';
INSERT INTO DimCountry(IDCountry, Country, CountryEng) SELECT 2, 'Италия', 'Italy';
INSERT INTO DimCountry(IDCountry, Country, CountryEng) SELECT 3, 'Англия', 'England';
INSERT INTO DimCountry(IDCountry, Country, CountryEng) SELECT 25, 'Германия', 'Germany';
INSERT INTO DimCountry(IDCountry, Country, CountryEng) SELECT 26, 'Франция', 'France';
INSERT INTO DimCountry(IDCountry, Country, CountryEng) SELECT 27, 'Турция', 'Turkey';
INSERT INTO DimCountry(IDCountry, Country, CountryEng) SELECT 28, 'Португалия', 'Portugal';
INSERT INTO DimCountry(IDCountry, Country, CountryEng) SELECT 29, 'Голландия', 'Netherlands';
INSERT INTO DimCountry(IDCountry, Country, CountryEng) SELECT 30, 'Россия', 'Russia';

select * from DimCountry;

use sportstat;
CREATE TABLE DimLeague(
	IDLeague int  NOT NULL,
	League varchar(100) NULL,
	IDCountry int NULL,
	IDLeagueType int NULL,
	LeagueEng varchar(100) NULL,
	LeagueCurrentSource int NULL,
    PRIMARY KEY (IDLeague));
INSERT INTO DimLeague(IDLeague, League, IDCountry, IDLeagueType, LeagueEng, LeagueCurrentSource) VALUES(1, 'Примера', 1, 1, 'Primera', 1);
INSERT INTO DimLeague(IDLeague, League, IDCountry, IDLeagueType, LeagueEng, LeagueCurrentSource) VALUES(2, 'Серия A', 2, 1, 'Seria A', 2);
INSERT INTO DimLeague(IDLeague, League, IDCountry, IDLeagueType, LeagueEng, LeagueCurrentSource) VALUES(3, 'Премьер-лига', 3, 1, 'Premier League', 3);
INSERT INTO DimLeague(IDLeague, League, IDCountry, IDLeagueType, LeagueEng, LeagueCurrentSource) VALUES(7, 'Бундеслига 1', 25, 1, 'Bundesliga 1', 4);
INSERT INTO DimLeague(IDLeague, League, IDCountry, IDLeagueType, LeagueEng, LeagueCurrentSource) VALUES(8, 'Лига 1', 26, 1, 'Liga 1', 5);
INSERT INTO DimLeague(IDLeague, League, IDCountry, IDLeagueType, LeagueEng, LeagueCurrentSource) VALUES(9, 'Суперлига', 27, 1, 'Super', 6);
INSERT INTO DimLeague(IDLeague, League, IDCountry, IDLeagueType, LeagueEng, LeagueCurrentSource) VALUES(10, 'Суперлига', 28, 1, 'Super', 7);
INSERT INTO DimLeague(IDLeague, League, IDCountry, IDLeagueType, LeagueEng, LeagueCurrentSource) VALUES(11, 'Высшая лига', 29, 1, 'Highest', 8);
INSERT INTO DimLeague(IDLeague, League, IDCountry, IDLeagueType, LeagueEng, LeagueCurrentSource) VALUES(12, 'Премьер лига', 30, 1, 'Premier', 9);

select * from DimLeague;

CREATE TABLE DimLeagueSource(
	IDLeagueCurrentSource int NOT NULL,
	CurrentSource varchar(100) NULL,
	Country varchar(100) NULL,
	IDCountry int NULL,
	IDLeague int NULL,
	League varchar(100) NULL,
    PRIMARY KEY (IDLeagueCurrentSource));
    
INSERT INTO DimLeagueSource(IDLeagueCurrentSource, CurrentSource, Country, IDCountry, IDLeague, League) VALUES (1, 'http://football.sport-express.ru/foreign/spain/laleague/Season/calendar/tours/', 'Испания', 1, 1, 'Примера');
INSERT INTO DimLeagueSource(IDLeagueCurrentSource, CurrentSource, Country, IDCountry, IDLeague, League) VALUES (2, 'http://football.sport-express.ru/foreign/italy/seriaa/Season/calendar/tours/', 'Италия', 2, 2, 'Серия A');
INSERT INTO DimLeagueSource(IDLeagueCurrentSource, CurrentSource, Country, IDCountry, IDLeague, League) VALUES (3, 'http://football.sport-express.ru/foreign/england/premier/Season/calendar/tours/', 'Англия', 3, 3, 'Премьер-лига');
INSERT INTO DimLeagueSource(IDLeagueCurrentSource, CurrentSource, Country, IDCountry, IDLeague, League) VALUES (4, 'http://football.sport-express.ru/foreign/german/bundes1/Season/calendar/tours/', 'Германия', 25, 7, 'Бундеслига 1');
INSERT INTO DimLeagueSource(IDLeagueCurrentSource, CurrentSource, Country, IDCountry, IDLeague, League) VALUES (5, 'http://football.sport-express.ru/foreign/france/league1/Season/calendar/tours/', 'Франция', 26, 8, 'Лига 1');
INSERT INTO DimLeagueSource(IDLeagueCurrentSource, CurrentSource, Country, IDCountry, IDLeague, League) VALUES (6, 'https://www.sport-express.ru/football/L/foreign/turkey/super/Season/calendar/tours/', 'Турция', 27, 9, 'Суперлига');
INSERT INTO DimLeagueSource(IDLeagueCurrentSource, CurrentSource, Country, IDCountry, IDLeague, League) VALUES (7, 'https://www.sport-express.ru/football/L/foreign/portugal/super/Season/calendar/tours/', 'Португалия', 28, 10, 'Суперлига');
INSERT INTO DimLeagueSource(IDLeagueCurrentSource, CurrentSource, Country, IDCountry, IDLeague, League) VALUES (8, 'https://www.sport-express.ru/football/L/foreign/netherlands/highest/Season/calendar/tours/', 'Голландия', 29, 11, 'Высшая лига');
INSERT INTO DimLeagueSource(IDLeagueCurrentSource, CurrentSource, Country, IDCountry, IDLeague, League) VALUES (9, 'https://www.sport-express.ru/football/L/russia/premier/Season/calendar/tours/', 'Россия', 30, 12, 'Премьер лига');

select * from DimLeagueSource;

CREATE TABLE DimTeam(
	IDTeam int NOT NULL,
	Team varchar(300) NULL,
	IDCountry int NULL,
	TeamEng varchar(100) NULL,
    PRIMARY KEY (IDTeam));

CREATE TABLE DimSeason(
	IDSeason int NOT NULL,
	Season varchar(100) NULL,
	IsCurrentSeason int NULL,    
	PRIMARY KEY (IDSeason));
    
 
CREATE TABLE DimResultType(
	IDResultType int  NOT NULL,
	ResultType varchar(100) NULL,
    PRIMARY KEY (IDResultType));
 
 
CREATE TABLE DimLeagueType(
	IDLeagueType int  NOT NULL,
	LeagueType varchar(100) NULL,
    PRIMARY KEY (IDLeagueType));
 
 CREATE TABLE FactResult(
	IDFactResult bigint  NOT NULL,
	Country varchar(255) NULL,
	Season varchar(255) NULL,
	League varchar(255) NULL,
	Tour int NULL,
	MatchDate date NULL,
	TeamHome varchar(255) NULL,
	TeamGuest varchar(255) NULL,
	GoalHome int NULL,
	GoalGuest int NULL,
	IDResultType int NULL,
	GoalHomePenalty int NULL,
	GoalGuestPenalty int NULL,
	IDCountry int NULL,
	IDSeason int NULL,
	IDLeague int NULL,
	IDTeamHome int NULL,
	IDTeamGuest int NULL,
	LastUpdate datetime NULL,
    PRIMARY KEY (IDFactResult));
 
 
CREATE TABLE FactPredict(
	IDFactPredict bigint  NOT NULL,
	IDFactResult bigint NULL,
	PredictHome int NULL,
	PredictGuest int NULL,
	ProbHome numeric(20, 4) NULL,
	ProbDraw numeric(20, 4) NULL,
	ProbGuest numeric(20, 4) NULL,
	PredictType int NULL,
	Comment varchar(100) NULL,
	DateCreate datetime NULL,
	PRIMARY KEY (IDFactPredict));
     
CREATE TABLE FactLoadError(
	IDLoadError int  NOT NULL,
	VarStr varchar(1000) NULL,
	UpdateDate datetime NULL,
    PRIMARY KEY (IDLoadError));
    
    
INSERT INTO  DimLeagueType(IDLeagueType, LeagueType) VALUES(0, 'Чемпионат страны');
INSERT INTO  DimLeagueType(IDLeagueType, LeagueType) VALUES(1, 'Кубок страны');
INSERT INTO  DimLeagueType(IDLeagueType, LeagueType) VALUES(2, 'Лига Чемпионов');
INSERT INTO  DimLeagueType(IDLeagueType, LeagueType) VALUES(3, 'Лига Европы');
INSERT INTO  DimLeagueType(IDLeagueType, LeagueType) VALUES(4, 'Кубок УЕФА');

select * from DimLeagueType;

INSERT INTO DimResultType(IDResultType, ResultType) VALUES(0, 'Основное время');
INSERT INTO DimResultType(IDResultType, ResultType) VALUES(1, 'Дополнительное время');
INSERT INTO DimResultType(IDResultType, ResultType) VALUES(2, 'Послематчевые пенальти');

select * from DimResultType;


INSERT INTO DimSeason(IDSeason, Season, IsCurrentSeason) VALUES(0, '2005-2006',0);
INSERT INTO DimSeason(IDSeason, Season, IsCurrentSeason) VALUES(1, '2006-2007',0);
INSERT INTO DimSeason(IDSeason, Season, IsCurrentSeason) VALUES(2, '2007-2008',0);
INSERT INTO DimSeason(IDSeason, Season, IsCurrentSeason) VALUES(3, '2008-2009',0);
INSERT INTO DimSeason(IDSeason, Season, IsCurrentSeason) VALUES(4, '2009-2010',0);
INSERT INTO DimSeason(IDSeason, Season, IsCurrentSeason) VALUES(5, '2010-2011',0);
INSERT INTO DimSeason(IDSeason, Season, IsCurrentSeason) VALUES(6, '2011-2012',0);
INSERT INTO DimSeason(IDSeason, Season, IsCurrentSeason) VALUES(7, '2012-2013',0);
INSERT INTO DimSeason(IDSeason, Season, IsCurrentSeason) VALUES(8, '2013-2014',0);
INSERT INTO DimSeason(IDSeason, Season, IsCurrentSeason) VALUES(9, '2014-2015',0);
INSERT INTO DimSeason(IDSeason, Season, IsCurrentSeason) VALUES(16, '2015-2016',0);
INSERT INTO DimSeason(IDSeason, Season, IsCurrentSeason) VALUES(18, '2016-2017',0);
INSERT INTO DimSeason(IDSeason, Season, IsCurrentSeason) VALUES(19, '2017-2018',0);
INSERT INTO DimSeason(IDSeason, Season, IsCurrentSeason) VALUES(20, '2018-2019',0);
INSERT INTO DimSeason(IDSeason, Season, IsCurrentSeason) VALUES(21, '2019-2020',1);


INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(1, 'Алавес', 1, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(2, 'Альмерия', 1, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(3, 'Асколи', 2, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(4, 'Аталанта', 2, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(5, 'Атлетик', 1, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(6, 'Атлетико', 1, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(7, 'Бари', 2, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(8, 'Барселона', 1, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(9, 'Бетис', 1, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(10, 'Болонья', 2, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(11, 'Брешиа', 2, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(12, 'Валенсия', 1, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(13, 'Вальядолид', 1, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(14, 'Верона', 2, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(15, 'Вильярреал', 1, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(16, 'Гранада', 1, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(17, 'Депортиво', 1, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(18, 'Дженоа', 2, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(19, 'Интер', 2, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(20, 'Кадис', 1, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(21, 'Кальяри', 2, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(22, 'Катания', 2, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(23, 'Кордова', 1, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(24, 'Кьево', 2, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(25, 'Лацио', 2, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(26, 'Леванте', 1, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(27, 'Лечче', 2, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(28, 'Ливорно', 2, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(29, 'Малага', 1, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(30, 'Мальорка', 1, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(31, 'Мессина', 2, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(32, 'Милан', 2, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(33, 'Мурсия', 1, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(34, 'Наполи', 2, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(35, 'Новара', 2, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(36, 'Нумансия', 1, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(37, 'Осасуна', 1, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(38, 'Палермо', 2, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(39, 'Парма', 2, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(40, 'Пескара', 2, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(41, 'Райо Вальекано', 1, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(42, 'Расинг', 1, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(43, 'Реал', 1, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(44, 'Реал Сосьедад', 1, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(45, 'Реджина', 2, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(46, 'Рекреативо', 1, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(47, 'Рома', 2, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(48, 'Сампдория', 2, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(49, 'Сарагоса', 1, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(50, 'Сассуоло', 2, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(51, 'Севилья', 1, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(52, 'Сельта', 1, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(53, 'Сиена', 2, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(54, 'Спортинг Х', 1, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(55, 'Тенерифе', 1, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(56, 'Торино', 2, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(57, 'Тревизо', 2, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(58, 'Удинезе', 2, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(59, 'Фиорентина', 2, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(60, 'Херес', 1, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(61, 'Хетафе', 1, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(62, 'Химнастик', 1, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(63, 'Чезена', 2, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(64, 'Эйбар', 1, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(65, 'Эльче', 1, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(66, 'Эмполи', 2, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(67, 'Эркулес', 1, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(68, 'Эспаньол', 1, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(69, 'Ювентус', 2, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(70, 'Халл Сити', 3, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(71, 'Лестер', 3, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(72, 'Борнмут', 3, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(73, 'Манчестер Юнайтед', 3, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(74, 'Арсенал', 3, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(75, 'Ливерпуль', 3, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(76, 'Бернли', 3, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(77, 'Суонси', 3, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(78, 'Кристал Пэлас', 3, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(79, 'Вест Бромвич Альбион', 3, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(80, 'Эвертон', 3, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(81, 'Тоттенхэм Хотспур', 3, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(82, 'Мидлсбро', 3, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(83, 'Стоук Сити', 3, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(84, 'Саутгемптон', 3, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(85, 'Уотфорд', 3, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(86, 'Манчестер Сити', 3, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(87, 'Сандерленд', 3, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(88, 'Челси', 3, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(89, 'Вест Хэм Юнайтед', 3, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(90, 'Хаддерсфилд', 3, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(91, 'Брайтон & Хоув', 3, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(92, 'Ньюкасл Юнайтед', 3, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(93, 'Леганес', 1, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(94, 'Лас-Пальмас', 1, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(95, 'Жирона', 1, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(96, 'Кротоне', 2, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(97, 'СПАЛ', 2, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(98, 'Беневенто', 2, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(99, 'Астон Вилла', 3, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(100, 'Болтон Уондерерс', 3, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(101, 'Фулхэм', 3, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(102, 'Бирмингем Сити', 3, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(103, 'Блэкберн Роверс', 3, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(104, 'Чарльтон Атлетик', 3, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(105, 'Портсмут', 3, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(106, 'Уиган Атлетик', 3, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(107, 'Шеффилд Юнайтед', 3, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(108, 'Рединг', 3, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(109, 'Дерби Каунти', 3, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(110, 'Вулверхэмптон Уондерерс', 3, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(111, 'Блэкпул', 3, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(112, 'Куинз Парк Рейнджерс', 3, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(113, 'Норвич', 3, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(114, 'Кардифф Сити', 3, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(115, 'ПСЖ', 26, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(116, 'Метц', 26, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(117, 'Марсель', 26, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(118, 'Бордо', 26, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(119, 'Лилль', 26, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(120, 'Ренн', 26, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(121, 'Нант', 26, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(122, 'Ланс', 26, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(123, 'Сент-Этьен', 26, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(124, 'Аяччо', 26, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(125, 'Сошо', 26, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(126, 'Тулуза', 26, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(127, 'Страсбур', 26, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(128, 'Осер', 26, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(129, 'Нанси', 26, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(130, 'Монако', 26, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(131, 'Ницца', 26, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(132, 'Труа', 26, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(133, 'Ле Ман', 26, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(134, 'Лион', 26, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(135, 'Валансьен', 26, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(136, 'Лорьян', 26, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(137, 'Седан', 26, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(138, 'Кан', 26, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(139, 'Гавр', 26, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(140, 'Гренобль', 26, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(141, 'Монпелье', 26, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(142, 'Булонь-сюр-Мер', 26, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(143, 'Арль-Авиньон', 26, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(144, 'Брест', 26, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(145, 'Эвиан', 26, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(146, 'Дижон', 26, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(147, 'Бастия', 26, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(148, 'Реймс', 26, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(149, 'Генгам', 26, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(150, 'Анже', 26, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(151, 'Амьен', 26, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(152, 'Бавария', 25, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(153, 'Боруссия М', 25, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(154, 'Кельн', 25, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(155, 'Майнц', 25, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(156, 'Дуйсбург', 25, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(157, 'Штутгарт', 25, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(158, 'Гамбург', 25, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(159, 'Нюрнберг', 25, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(160, 'Вольфсбург', 25, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(161, 'Боруссия Д', 25, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(162, 'Вердер', 25, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(163, 'Арминия', 25, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(164, 'Ганновер-96', 25, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(165, 'Герта', 25, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(166, 'Шальке-04', 25, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(167, 'Кайзерслаутерн', 25, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(168, 'Айнтрахт Ф', 25, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(169, 'Байер', 25, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(170, 'Алемания', 25, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(171, 'Энерги', 25, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(172, 'Бохум', 25, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(173, 'Ганза', 25, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(174, 'Карлсруэ', 25, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(175, 'Хоффенхайм', 25, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(176, 'Фрайбург', 25, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(177, 'Санкт-Паули', 25, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(178, 'Аугсбург', 25, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(179, 'Фортуна Д', 25, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(180, 'Гройтер Фюрт', 25, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(181, 'Айнтрахт Бр', 25, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(182, 'Падерборн', 25, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(183, 'Дармштадт', 25, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(184, 'Ингольштадт', 25, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(185, 'РБ Лейпциг', 25, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(186, 'Уэска', 1, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(187, 'Фрозиноне', 2, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(188, 'Ним', 26, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(189, 'Карпи', 2, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(190, 'Анкарагюджю', 27, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(191, 'Галатасарай', 27, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(192, 'Сивасспор', 27, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(193, 'Аланьяспор', 27, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(194, 'Ризеспор', 27, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(195, 'Касымпаша', 27, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(196, 'Фенербахче', 27, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(197, 'Бурсаспор', 27, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(198, 'Коньяспор', 27, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(199, 'Эрзурумспор', 27, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(200, 'Истанбул ББ', 27, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(201, 'Трабзонспор', 27, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(202, 'Бешикташ', 27, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(203, 'Акхисар БС', 27, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(204, 'Гезтепе', 27, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(205, 'Йени Малатьяспор', 27, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(206, 'Кайсериспор', 27, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(207, 'Антальяспор', 27, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(208, 'Генчлербирлиги', 27, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(209, 'Анкараспор', 27, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(210, 'Эржийеспор', 27, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(211, 'Газиантепспор', 27, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(212, 'Денизлиспор', 27, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(213, 'Сакарьяспор', 27, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(214, 'Манисаспор', 27, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(215, 'Генчлербирлиги Офтас', 27, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(216, 'Коджаелиспор', 27, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(217, 'Эскишехирспор', 27, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(218, 'Хаджеттепе', 27, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(219, 'Диярбакырспор', 27, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(220, 'Буджаспор', 27, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(221, 'Карабюкспор', 27, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(222, 'Мерсин Идманюрду', 27, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(223, 'Самсунспор', 27, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(224, 'Ордуспор', 27, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(225, 'Элазыгспор', 27, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(226, 'Балыкесирспор', 27, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(227, 'Османлыспор', 27, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(228, 'Аданаспор', 27, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(229, 'Порту', 28, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(230, 'Лейрия', 28, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(231, 'Бейра Map', 28, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(232, 'Авеш', 28, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(233, 'Брага', 28, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(234, 'Пасуш де Феррейра', 28, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(235, 'Спортинг', 28, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(236, 'Боавишта', 28, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(237, 'Навал', 28, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(238, 'Эштрела', 28, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(239, 'Маритиму', 28, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(240, 'Насионал Ф', 28, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(241, 'Витория Сетубал', 28, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(242, 'Академика', 28, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(243, 'Бенфика', 28, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(244, 'Белененсеш', 28, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(245, 'Лейшойнш', 28, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(246, 'Витория Гимарайнш', 28, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(247, 'Трофенси', 28, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(248, 'Риу Аве', 28, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(249, 'Ольяненси', 28, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(250, 'Портимоненси', 28, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(251, 'Жил Висенте', 28, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(252, 'Фейренси', 28, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(253, 'Морейренси', 28, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(254, 'Эшторил', 28, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(255, 'Арока', 28, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(256, 'Пенафиел', 28, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(257, 'Тондела', 28, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(258, 'Униан Мадейра', 28, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(259, 'Шавиш', 28, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(260, 'Санта-Клара', 28, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(261, 'Витесс', 29, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(262, 'Гронинген', 29, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(263, 'Утрехт', 29, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(264, 'ПСВ', 29, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(265, 'Виллем II', 29, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(266, 'Аякс', 29, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(267, 'Рода', 29, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(268, 'Твенте', 29, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(269, 'НЕК Неймеген', 29, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(270, 'Де Графсхап', 29, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(271, 'Спарта Р', 29, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(272, 'АДО Ден Хаг', 29, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(273, 'Хераклес', 29, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(274, 'Фейеноорд', 29, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(275, 'Волендам', 29, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(276, 'Херенвен', 29, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(277, 'АЗ', 29, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(278, 'НАК Бреда', 29, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(279, 'РКС Валвейк', 29, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(280, 'Венло', 29, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(281, 'Экселсиор', 29, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(282, 'Зволле', 29, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(283, 'Камбюр', 29, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(284, 'Гоу Эхед Иглз', 29, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(285, 'Дордрехт', 29, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(286, 'Фортуна С', 29, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(287, 'Эммен', 29, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(288, 'Анжи', 30, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(289, 'Краснодар', 30, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(290, 'Спартак Нч', 30, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(291, 'Крылья Советов', 30, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(292, 'Локомотив', 30, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(293, 'Динамо', 30, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(294, 'Кубань', 30, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(295, 'Рубин', 30, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(296, 'ЦСКА', 30, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(297, 'Амкар', 30, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(298, 'Терек', 30, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(299, 'Зенит', 30, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(300, 'Волга НН', 30, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(301, 'Томь', 30, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(302, 'Ростов', 30, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(303, 'Спартак', 30, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(304, 'Мордовия', 30, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(305, 'Алания', 30, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(306, 'Урал', 30, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(307, 'Арсенал Т', 30, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(308, 'Торпедо М', 30, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(309, 'Уфа', 30, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(310, 'Оренбург', 30, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(311, 'Тосно', 30, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(312, 'СКА-Хабаровск', 30, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(313, 'Ахмат', 30, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(314, 'Енисей', 30, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(315, 'Истанбул Башакшехир', 27, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(316, 'Тамбов', 30, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(317, 'Сочи', 30, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(1316, 'Фамаликау', 28, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(1317, 'Фамаликан', 28, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(2324, 'Унион Б', 25, NULL);
INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(2325, 'Газишехир', 27, NULL);
