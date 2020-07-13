import pandas as pd
import html5lib
import re
import pyodbc
from datetime import datetime
import requests as req
from bs4 import BeautifulSoup
from PIL import Image
from io import BytesIO
import logging
import io


con = pyodbc.connect('Trusted_Connection=yes', driver = '{SQL Server}',server = 'localhost', port = '1433', database = 'SportStat', autocommit=True)

logger = logging.getLogger()
nations = {}

def fGetResultList(tables, LeagueType):
    if isinstance(tables, list):
        tables = tables[0]
    Results = []
    if LeagueType == 1:
        Tour = 0
        for i in range(0,tables.shape[0]):
            Result = []
            if (tables.iloc[i][0].find('тур')) >= 0:
                Tour = Tour + 1
            if (tables.iloc[i][0].find('тур')) == -1:
                if (tables.iloc[i][0].find('Плей-офф')) == -1:
                    if (datetime.date(datetime.now())> datetime.strptime(tables.iloc[i][0], '%d.%m.%Y').date()):
                        Result.append(tables.iloc[i][0])
                        Result.append(tables.iloc[i][1])
                        Result.append(tables.iloc[i][2].split(':')[0].rstrip())
                        Result.append(tables.iloc[i][2].split(':')[1].lstrip())
                        Result.append(tables.iloc[i][3])
                        Result.append(Tour)
                        Results.append(Result)
                    else:
                        Result.append(tables.iloc[i][0])
                        Result.append(tables.iloc[i][1])
                        Result.append('null')
                        Result.append('null')
                        Result.append(tables.iloc[i][3])
                        Result.append(Tour)
                        Results.append(Result)
    if LeagueType in [2,7]:
        for i in range(0,tables.shape[0]):
            Result = []
            if str(tables.iloc[i][2]) != 'nan' and 'W' not in str(tables.iloc[i][2]):
                Result.append(tables.iloc[i][2])
                Result.append(tables.iloc[i][6])   
                Result.append(tables.iloc[i][4].split(':')[0].rstrip())
                Result.append(tables.iloc[i][4].split(':')[1].lstrip())
                Result.append(tables.iloc[i][0])
                if '  ' in tables.iloc[i][7]:
                    Result.append(tables.iloc[i][7].split('  ')[1].split(':')[0].rstrip())
                    Result.append(tables.iloc[i][7].split('  ')[1].split(':')[1].lstrip())
                else:
                    Result.append('NULL')
                    Result.append('NULL')
                if '.' in tables.iloc[i][7]:
                    Result.append(tables.iloc[i][7])
                else:
                    Result.append('NULL')  
                Results.append(Result)
            elif str(tables.iloc[i][1]) != 'nan' and 'W' not in str(tables.iloc[i][1]):
                Result.append(tables.iloc[i][1])
                Result.append(tables.iloc[i][5])   
                Result.append(tables.iloc[i][3].split(':')[0].rstrip())
                Result.append(tables.iloc[i][3].split(':')[1].lstrip())
                Result.append(tables.columns[1])
                if '  ' in tables.iloc[i][6]:
                    Result.append(tables.iloc[i][6].split('  ')[1].split(':')[0].rstrip())
                    Result.append(tables.iloc[i][6].split('  ')[1].split(':')[1].lstrip())
                else:
                    Result.append('NULL')
                    Result.append('NULL')
                if '.' in tables.iloc[i][6]:
                     Result.append(tables.iloc[i][6])
                else:
                     Result.append('NULL')           
                Results.append(Result)
    return(Results)

def WriteResultsToDB(con, IsAddValues, Country, Season, League, Results, LeagueType, *args):
    for result in Results:
        query = ""
        try:
            if LeagueType == 1:
                Tour = result[5]
                if ' - ' in result[1]:
                    TeamHome = result[1].split(' - ')[0]
                    TeamGuest =result[1].split(' - ')[1]
                else:
                    TeamHome = result[1]
                    TeamGuest = result[4]
                GoalHome = result[2]
                GoalGuest = result[3]
                GoalHomeTmp = result[2]
                GoalGuestTmp = result[3]
                IDResultType = 1
                GoalHomePenalty = 'NULL'
                GoalGuestPenalty = 'NULL'
                Stage = 'NULL'
                MatchDateDt = datetime.strptime(result[0], '%d.%m.%Y').date().strftime('%Y-%m-%d')
                MatchDate = "'" + str(MatchDateDt) + "'"
            if LeagueType in [2,7]:
                TeamHome = result[0]
                TeamGuest = result[1]
                GoalHome = result[2]
                GoalGuest = result[3]
                GoalHomeTmp = result[2]
                GoalGuestTmp = result[3]
                Stage = result[4]
                Tour= 'NULL'
                MatchDate = result[7]
                if MatchDate != 'NULL':
                    MatchDateDt = datetime.strptime(MatchDate, '%d.%m.%y').date().strftime('%Y-%m-%d')
                    MatchDate = "'" + str(MatchDateDt) + "'"

                GoalHomePenalty = result[5]
                GoalGuestPenalty = result[6]
                if GoalHomePenalty != 'NULL':
                    IDResultType = 3
                else:
                    IDResultType = 1

            IsError = 0

            if (GoalHome.isdigit() == False or (len(GoalHomeTmp) ==2 and len(GoalGuestTmp) ==2)):
                GoalHome = 'NULL'
                if (datetime.date(datetime.now())> datetime.strptime(MatchDateDt, '%Y-%m-%d').date()):
                    IsError = 1
            if (GoalGuest.isdigit() ==False or (len(GoalHomeTmp) ==2 and len(GoalGuestTmp) ==2)):
                GoalGuest = 'NULL'
                if (datetime.date(datetime.now())> datetime.strptime(MatchDateDt, '%Y-%m-%d').date()):
                    IsError = 1            
            query = (
            "exec pSaveResult " + str(IsAddValues) + ", '" + Season + "' , '" + Country + "', '" + League + "', " + str(Tour) + ", "
                     + MatchDate + ", '" + TeamHome + "', '" + TeamGuest + "', " + str(GoalHome) + ", " + str(GoalGuest) + ", "
                     +  str(IDResultType) + ", " + GoalHomePenalty + ", " + GoalGuestPenalty + ", " + str(IsError)) + ", '" + str(Stage) + "'"
            #print(query) 
            con.execute(query)
            con.commit()   
            
        except Exception as e: 
            print(e)
            print(query)

def ParseResults(SeasonAllType, TypeCountryInput, CountryInput, IsExistsSource, IsMainCountry, LeagueType, IsPrimary, IsDebug = 0):
    CountryDict = GetCountryDict(TypeCountryInput, CountryInput, IsExistsSource, IsMainCountry, LeagueType, IsPrimary)
    if IsDebug == 1:
        print(CountryDict)
    for key, country in CountryDict.items():
        IDSeasonType = country['IDSeasonType']
        CurrentSource = country["CurrentSource"]
        Country = country["Country"]
        League = country["League"]
        LeagueType = country["LeagueType"]
        SeasonLst = GetSeasonList(con, SeasonAllType, IDSeasonType)
        print(f"{Country} {League}")
        
        for season in SeasonLst:
            url_list = []
            if LeagueType == 1:
                url = CurrentSource.replace("[Season]", str(season))
                url_list.append(url)
            if LeagueType in [2,7]:
                url = CurrentSource.replace("[Season]", str(season)).split('/calendar')[0]
                url_list.append(url + '/playoff/')
                url_list.append(url + '/32/')
                #url_list.append(url + '/64/')
            
            print(f"{season}")
            for url in url_list:
                IsError = 0
                print(url)
                try:
                    df = pd.read_html(url)
                    tables = df[0]
                except:
                    print("Error then load data from url", Country, season, League)
                    print(url)
                    IsError = 1
                else:    
                    print("Download Success: ", Country, season, League)
                if (IsError == 0):
                    try:
                        Results = fGetResultList(tables, LeagueType)
                        if IsDebug ==1:
                            print(Results)
                    except:
                        print("Error in loading ", Country, season, League)
                        print(url)
                        IsError = 1
                    else:    
                        print("Load Success: ", Country, season, League)
                if (IsError == 0):
                    try:
                        WriteResultsToDB(con, 1, Country, season, League, Results, LeagueType)
                    except:
                        print("Error in write to db ", Country, season, League)
                        print(url)
                    else:    
                        print("Write to DB Success: ", Country, season, League)

def parse_team_update_img(images, con, country):
    image_dict = {}
    for image in images:
        response = req.get('http:' + image['src'])
        image_dict[image['alt']] = Image.open(BytesIO(response.content))
    cursor = con.cursor()
    for key, value in image_dict.items():
        output = io.BytesIO()
        value.save(output, format='PNG')
        cursor.execute("exec pSaveTeamImg ?,?,?", (str(key), country, pyodbc.Binary(output.getvalue())))
    con.commit()

def parse_team_get_team_dict(teams):
    tags = [] 
    tags.extend(i.prettify() for i in  teams if (str(i or '').find("command") > 0))
    team_dict = {}
    for tag in tags:
        ref = tag.split('<a href="')[1].split('"')[0]
        team = tag.split('<a href="')[1].split('/">')[1].split('</a>')[0].strip()
        team_dict[team] = ref
    return team_dict

def save_team_info_to_db(teams_list, con, country):
    for team, value_dict in teams_list.items():
        BigImg = ''
        YearFound = 0
        Color = ''
        Stadium = '' 
        StadiumNumber = '' 
        Coach = ''
        for key, value in value_dict.items():
            if key == 'BigImg':
                output = io.BytesIO()
                value.save(output, format='PNG')
                BigImg = pyodbc.Binary(output.getvalue())
                continue
            if key == 'YearFound':
                YearFound = value
                continue
            if key == 'Color':
                Color = value
                continue
            if key == 'Stadium':
                Stadium = value
                continue
            if key == 'Coach':
                Coach = value
                continue
            if key == 'StadiumNumber':
                StadiumNumber = value
                continue
        cursor = con.cursor()
        cursor.execute("exec pSaveTeamImg ?,?,?,?,?,?,?,?,?", (str(team), country, BigImg, 2, YearFound, Color, Stadium, StadiumNumber, Coach))
        con.commit()
        #logger.warning(f'Update db for {str(team)}')

def parse_team_get_team_info(team, url):
    resp_team = req.get(url) 
    soup = BeautifulSoup(resp_team.text, 'lxml')
    inf = soup.findAll("div", {"class": "se19-team-profile__logo"})
    team_info = {}
    detail_lst = []
    for inf_el in inf:
        team_results = inf_el.find_all("img")
        for team_result in team_results:
            response = req.get(team_result['src'])
            team_info['BigImg'] = Image.open(BytesIO(response.content))
    details = soup.findAll("td", {"class": "pr_60"})
    for detail in details:
        try:
            detail_lst.append(str(detail).split('b>')[1].split('</')[0])
        except:
            detail_lst.append('')
    details = soup.findAll("td", {"class": "pr_0"})
    for detail in details:
        try:
            detail_lst.append(str(detail).split('b>')[1].split('</')[0].lstrip().split('\n')[0])
        except:
            detail_lst.append('')
    details = soup.findAll("span", {"class": "se19-team-profile__last-auditory ml_10"})
    if len(details) == 0:
        detail_lst.append('')
    else:
        for detail in details:
            try:
                detail_lst.append(str(detail).split('">')[1].split("</s")[0])
            except:
                detail_lst.append('')
    if len(detail_lst) > 1:
        team_info['YearFound'] = detail_lst[1]
        team_info['Color'] = detail_lst[2]
        team_info['Stadium'] = detail_lst[3]
        team_info['Coach'] = detail_lst[4]
        team_info['StadiumNumber'] = detail_lst[5]
    return team_info
    
def parse_team_get_team_info_main(team_dict, con, IsOverwrite, country):
    teams_list = {}
    for team, url in team_dict.items():
        logger.warning(team)
        team_info = parse_team_get_team_info(team, url)
        teams_list[team] = team_info
        #logger.warning("Получены данные")
        url_lineup =url + 'players/'
        #logger.warning(f"url_lineup = {url_lineup}")
        GetTeamlineUp(con, team, url_lineup, IsOverwrite)
    #logger.warning("Start save_team_info_to_db")
    save_team_info_to_db(teams_list, con, country)
    logger.warning("Done save_team_info_to_db")
    
def parse_team_data(url, con, country, IsOverwrite = 1):
    
    #logger.warning('Start parse_team_data')
    resp = req.get(url) 
    soup = BeautifulSoup(resp.text, 'lxml')
    
    #Основная функция: принимает на вход url турнирной таблицы
    #logger.warning('Start parse_team_update_img')
    images = soup.findAll("img", {"class": "mr_10 m_all"})
    try:
        parse_team_update_img(images, con, country)
        logger.warning('Done parse_team_update_img')
    except:
        logger.error('Error parse_team_update_img')
    
    #Парсинг и сохранение в базу инфо о команде
    teams = soup.findAll("span", {"class": "m_all link-underline"})
    if len(teams) == 0:
        teams = soup.findAll("span", {"class": "m_all"})
    #logger.warning('Start parse_team_get_team_dict')
    team_dict = parse_team_get_team_dict(teams)
    logger.warning('Done parse_team_get_team_dict')
    #logger.warning('Start parse_team_get_team_info_main')
    parse_team_get_team_info_main(team_dict, con, IsOverwrite, country)
    logger.warning('Done parse_team_get_team_info_main')
    SaveNations(con, nations)
    #logger.warning('SaveNations done')
    

def GetPlayerField(tr):
    cls = tr.attrs.get("class")
    if cls is not None and 'w_100p' in cls:
        img = tr.find("img")
        if img is not None:
            return img['title'] + '|' + img['src']
    return tr.text

def GetTeamlineUp(con, Team, url, IsOverwrite):
    resp = req.get(url) 
    soup_team = BeautifulSoup(resp.text, 'lxml')
    player_table = soup_team.find("table", {"class": "se19-table"})
    if player_table is not None:
        player_list = player_table.find('tbody').find_all('tr')
        
        l = []
        for tr in player_list:
            td = tr.find_all('td')
            row = [GetPlayerField(tr) for tr in td]
            #print(row)
            l.append(row)
        if len(l) != 0:
            if len(l[0]) == 6:
                IsFull = 1
                df_players = pd.DataFrame(l, columns=["Player", "Nation", "Amplua", "Games", "Goal", "Pass",])
            elif len(l[0]) == 3:
                IsFull = 0
                df_players = pd.DataFrame(l, columns=["Player", "Nation", "Amplua"])
            for index, row in df_players.iterrows():
                tst_dict = {}
                Player = row['Player'].strip()
                Amplua =  row['Amplua'].strip()
                if IsFull == 1:
                    Games =  row['Games']
                    Pass =  row['Pass']    
                    if Amplua == 'В' and '(' in row['Goal']:
                        Goals =  row['Goal'].split('(')[0]
                        GoalsGK =  row['Goal'].split('(')[1].split(')')[0]
                    else:
                        Goals =  row['Goal']
                        GoalsGK = 0
                else:
                    Games = 0
                    Pass = 0
                    Goals = 0
                    GoalsGK = 0
                if '|' in row['Nation']:
                    tst_dict['URL'] = row['Nation'].split('|')[1]
                    nations[row['Nation'].split('|')[0]] = tst_dict
                cursor = con.cursor()
                cursor.execute("exec pSaveLineUp ?,?,?,?,?,?,?,?", (Team, IsOverwrite, Player, Amplua, Games, Goals, Pass, GoalsGK))
                con.commit()
        
def SaveNations(con, nations):   
    for nation_key, nation_value  in nations.items():
        response = req.get(nation_value['URL'])
        nations[nation_key]['Img'] = Image.open(BytesIO(response.content))
    cursor = con.cursor()
    for key, value in nations.items():
        output = io.BytesIO()
        value['Img'].save(output, format='PNG')
        cursor.execute("exec pSaveNation ?,?,?", (str(key), value['URL'], pyodbc.Binary(output.getvalue())))
    con.commit()
    
def GetUrlList(con, Country, IsMainCountry, LeagueType, IDSeasonType):
    CursorLeague = con.cursor()
    querystring = f"select CurrentSource, Country from fGetCountrySource(2, '{Country}', 1) where IsMainCountry = {IsMainCountry} and LeagueType = {LeagueType}  order by Country"
    Leagues = CursorLeague.execute(querystring)
    RowLeague = CursorLeague.fetchone()
    league_list = []

    while RowLeague:
        league_list.append(RowLeague[0])
        RowLeague = CursorLeague.fetchone()

    CursorSeason = con.cursor()
    querystring = f"select * from fGetSeason(1, NULL, {IDSeasonType})"
    ResultSeason = CursorSeason.execute(querystring)

    season_lst = []
    RowSeason = CursorSeason.fetchone()
    while RowSeason:
        season_lst.append(RowSeason[0])
        RowSeason = CursorSeason.fetchone()

    url_lst = []
    for season in season_lst:
        tmp = list(map(lambda x: x.replace('[Season]', season).replace('calendar/tours/', ''), league_list))
        url_lst+=tmp
    return url_lst

def GetSeasonList(con, Type, IDSeasonType):
    CursorSeason = con.cursor()
    querystring = f"select * from fGetSeason({Type}, NULL, {IDSeasonType})"
    ResultSeason = CursorSeason.execute(querystring)
    SeasonArr = []
    RowSeason = CursorSeason.fetchone()
    while RowSeason:
        SeasonArr.append(RowSeason[0])
        RowSeason = CursorSeason.fetchone()
    return SeasonArr

def GetCountryDict(Type, Country = 'NULL', IsExistsSource = 1, IsMainCountry = 'NULL', LeagueType = 'NULL', IsPrimary = 'NULL'):
    CountryDict = {}
    CursorCountry = con.cursor()
    if Country != 'NULL':
        str_quote = "'"
    else:
        str_quote = ""
    querystring = f"select * from fGetCountrySource({Type}, {str_quote}{Country}{str_quote}, {IsExistsSource}, {IsMainCountry}, {LeagueType}, {IsPrimary})"
    print(querystring)
    ResultCountry = CursorCountry.execute(querystring)
    RowCountry = CursorCountry.fetchone()
    i=1
    while RowCountry:
        Country = {}
        Country["CurrentSource"] = RowCountry[0]
        Country["Country"] = RowCountry[1]
        Country["League"] = RowCountry[2]
        Country["IsMainCountry"] = RowCountry[3]
        Country["LeagueType"] = RowCountry[4]
        Country["IsPrimary"] = RowCountry[5]
        Country["IDSeasonType"] = RowCountry[6]
        CountryDict[i] = Country
        i+=1
        RowCountry = CursorCountry.fetchone()
    return CountryDict

