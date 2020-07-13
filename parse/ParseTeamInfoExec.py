import ParseResultsLib as prl
#con = pyodbc.connect('Trusted_Connection=yes', driver = '{SQL Server}',server = 'localhost', port = '1433', database = 'SportStat', autocommit=True)
prl.logger.warning('Start parse')

#Country = 'Англия'
CursorCountry = prl.con.cursor()
querystring = f"select Country, IsMain, IDSeasonType from DimCountry where IsLoadData is null"
Countries = CursorCountry.execute(querystring)
RowCountry = CursorCountry.fetchone()
country_dict = {}

while RowCountry:
    cnt_d = {}
    Country = RowCountry[0]
    IsMain = RowCountry[1]
    IDSeasonType = RowCountry[2]
    cnt_d["IsMain"] = IsMain
    cnt_d["IDSeasonType"] = IDSeasonType
    country_dict[Country] = cnt_d
    RowCountry = CursorCountry.fetchone()

for key, value in country_dict.items():
    Country = key
    IsMain = value["IsMain"]
    IDSeasonType  = value["IDSeasonType"]
    url_lst = prl.GetUrlList(prl.con, Country, IsMain, 1, IDSeasonType)
    prl.logger.warning(Country)

    for url in url_lst:
        print(url)
        prl.parse_team_data(url, prl.con, Country)