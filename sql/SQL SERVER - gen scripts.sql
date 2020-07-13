select 'INSERT INTO DimCountry(IDCountry, Country, CountryEng) SELECT ' + Convert(varchar(10), IDCountry) + ', '''
+ Country + ''', ''' + CountryEng + ''';'
from DimCountry

select 
'INSERT INTO DimLeague(IDLeague, League, IDCountry, IDLeagueType, LeagueEng, LeagueCurrentSource) VALUES('
+ CAST(IDLeague as varchar) + ', ''' + CAST(League as varchar) + ''', ' + CAST(IDCountry as VARCHAR) + ', '
+ CAST(IDLeagueType as varchar) + ', ''' + LeagueEng + ''', ' + cast(LeagueCurrentSource as varchar) + ');'
from DimLeague

select 
'INSERT INTO DimLeagueSource(IDLeagueCurrentSource, CurrentSource, Country, IDCountry, IDLeague, League) VALUES ('
+ CAST(IDLeagueCurrentSource as varchar) + ', ''' + CurrentSource + ''', ''' +  Country + ''', ' + 
CAST(IDCountry as varchar) + ', ' + CAST(IDLeague as varchar) + ', ''' + League + ''');'
from DimLeagueSource



select 
'INSERT INTO  DimLeagueType(IDLeagueType, LeagueType) VALUES('
+ CAST(IDLeagueType AS VARCHAR) + ', ''' +  LeagueType + ''');'
from DimLeagueType


select 'INSERT INTO DimResultType(IDResultType, ResultType) VALUES(' +  cast(IDResultType as varchar) + ', ''' + ResultType 
+ ''');'
from DimResultType;


select 'INSERT INTO DimSeason(IDSeason, Season, IsCurrentSeason) VALUES(' +  
cast(IDSeason as varchar) + ', ''' + Season + ''',' + cast(ISNULL(IsCurrentSeason, '') as varchar) + ');'
from DimSeason



select 'INSERT INTO DimTeam(IDTeam, Team, IDCountry, TeamEng) VALUES(' + 
cast(IDTeam as varchar) + ', ''' + Team + ''', ' + cast(IDCountry as varchar) + ', ' + 
case when ISNULL(TeamEng, '') = '' then 'NULL' else '' + ISNULL(TeamEng, '')  + '' end  + ');'
from DimTeam;

select * from FactLoadError


select 'INSERT INTO FactResult(IDFactResult ,Country,Season,League,Tour,MatchDate,TeamHome,TeamGuest,GoalHome,GoalGuest,IDResultType,GoalHomePenalty,GoalGuestPenalty,IDCountry,IDSeason,IDLeague,IDTeamHome,IDTeamGuest,LastUpdate) VALUES(' 
+ cast(IDFactResult as varchar) + ', ''' + Country + ''', ''' + Season + ''', ''' + League + ''', ' 
+ cast(Tour as varchar) + ', ''' + convert(varchar, MatchDate, 120) + ''', ''' + TeamHome + ''', ''' + TeamGuest + ''', ' 
+ case when GoalHome is null then 'NULL' else cast(GoalHome as varchar) end + ', ' 
+ case when GoalGuest is null then 'NULL' else cast(GoalGuest  as varchar) end + ', ' +  cast(IDResultType as varchar) 
+ ', ' + case when GoalHomePenalty is null then 'NULL' else cast(GoalHomePenalty  as varchar) end 
+ ', ' + case when GoalGuestPenalty is null then 'NULL' else cast(GoalGuestPenalty as varchar) end 
+ ', ' + cast(IDCountry as varchar) + ', ' + cast(IDSeason as varchar) + ', ' + cast(IDLeague as varchar)  + ', ' 
+ cast(IDTeamHome as varchar) + ', ' +  cast(IDTeamGuest  as varchar)  + ', ' 
+ case when LastUpdate is null then 'null' else '''' + convert(varchar, LastUpdate, 120) + '''' end
+ ');'
from FactResult
where IDFactResult >= 2551


select 'INSERT INTO FactPredict (IDFactPredict, IDFactResult, PredictHome, PredictGuest, ProbHome, ProbDraw, ProbGuest, 
PredictType, Comment, DateCreate) Values(' + cast(IDFactPredict as varchaR) + ', ' +
+ cast(IDFactResult as varchaR) + ', ' + cast(PredictHome as varchaR) + ', '
+ cast(PredictGuest as varchaR) + ', '+ cast(ProbHome as varchaR) + ', '
+ cast(ProbDraw as varchaR) + ', ' + cast(ProbGuest as varchaR) + ', ' 
+ cast(PredictType as varchaR) + ', ' 
+ case when Comment is null then 'NULL' else '' + Comment + '' end + ', ''  ' + convert(varchar,DateCreate, 120) + ''')'
from 
FactPredict
