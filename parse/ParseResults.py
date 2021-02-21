import ParseResultsLib as prl

now = prl.datetime.now()
SeasonAllType = 2    #1 - Все сезоны; 2 - Текущий сезон
TypeCountryInput = 1 #1 - Все страны; 2 - CountryInput
CountryInput = 'Германия' #'NULL' 'Германия'
IsExistsSource = 1   # 1 - Только имеющие источник 
IsMainCountry = 'NULL' #'NULL'
LeagueType = 1 #'NULL' 1 - Чемпионат страны 2 - Кубок страны 3 - Лига Чемпионов
#4 - Лига Европы 5 - Кубок УЕФА 6 - Суперкубок 7 - Кубок лиги
IsPrimary = 'NULL' #'NULL'
#print("ParseResults")
IsDebug = 1
prl.ParseResults(SeasonAllType, TypeCountryInput, CountryInput, IsExistsSource, IsMainCountry, LeagueType, IsPrimary, IsDebug)