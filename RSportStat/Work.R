library(RODBC) 
library(RODBCext)
dbhandle <- odbcDriverConnect('driver={SQL Server};server=localhost;database=SportStat;trusted_connection=true')
source("SportStatFunc.R")

Season = '2014-2015'
Country = 'Италия'
League = NA#'Серия A'
TypeTable = 'Всего'
IsDetailTable =  0 
TypeTour = 'Full'
LastTours = 'NULL'
TourNumber = 'NULL'
TourDate = 'NULL'
QueryGetTable <- paste("exec SportStat.dbo.pLoadTable '", Season, "', '", Country, "', '", League, "', '", TypeTable, "', ", IsDetailTable, ", '", TypeTour, "', ", LastTours, ", ", TourNumber, ", ", TourDate, sep = "")
#QueryGetTable <- "exec pLoadTable '2014-2015', 'Италия', 'Серия A', 'Всего', 0, 'Full', NULL, NULL, NULL"
QueryGetTable
res <- sqlQuery(dbhandle, QueryGetTable)
res

??selectInput
source("SportStatFunc.R")
ConStr <- 'driver={SQL Server};server=localhost;database=SportStat;trusted_connection=true'
GetCountryDf(ConStr, 1)
CountryList <- GetCountryDf(ConStr, 1)
CountryList[1,1]
LeagueList
LeagueList <- GetLeagueDf(ConStr, 'Англия', 1)
LeagueList <- GetLeagueDf(ConStr, CountryList[1,1], 1)
LeagueList <- GetLeagueDf(ConStr, CountryList[1,1], 1)
LeagueList[1]
Country <- 'Италия'
Lang <- 1
if (!is.null(Country)) { 
  SqlQueryStr <- paste0("exec pGetLeagueListByCountry '", Country, "', ", Lang)  
}else{
  SqlQueryStr <- paste("exec pGetLeagueListByCountry NULL, ", Lang)
}
SqlQueryStr

source("SportStatFunc.R")
GetNextTour(2, CountryParametr, LeagueParametr,SeasonParametr)


GetNextTour(2, 'Германия', 'Бундеслига 1','2019-2020')$Tour
GetNextTour(1, 'Германия', 'Бундеслига 1','2019-2020')$Tour
GetLeagueDf('Германия', 1)
filter(Leagues, Leagues$IDLeagueType == 1)

Countries <- GetCountryDf(1, 0, 'Германия')
Countries
filter(Countries, Countries$IsMain == 1)


LeagueList[1,1]
SeasonList[,1]
SeasonList <- GetSeasonDf(ConStr)
SeasonList[SeasonList$IsCurrentSeason==1,]
SeasonList[SeasonList$IsCurrentSeason==1,1]
SeasonList$IsCurrentSeason==1

SeasonList
subset(SeasonList, IsCurrentSeason==1)$Season
tst <- as.vector(subset(SeasonList, IsCurrentSeason==1)$Season)
View(tst)
str(tst)
#res <- sqlExecute(dbhandle, QueryGetTable, data = data.frame('Field'), fetch = TRUE,as.is=TRUE)
#res <- sqlExecute(dbhandle, QueryGetTable, data = data.frame('Position', 'Team', 'CountGames', 'CountWin', 
#                                                             'CountDraw', 'CountLose', 'GoalWin', 'GoalLose', 
#                                                             'GoalDifference', 'CountPoint'), fetch = TRUE,as.is=TRUE)

library(readtext)
my_data <-readtext("settings.txt")[1,2]
my_data[1,2]
str(my_data)
readtext("settings.txt")[1,2]
?column

TypeSelect = 1
Season = '2017-2018'
Country = 'Англия'
#League = input$league
Tour = 'NULL'
DateFrom = 'NULL'
DateTo = 'NULL'
is.na(DateTo)
res <- GetResultsDf(ConStr,TypeSelect, Country, League, Season, Tour, DateFrom, DateTo)
GetTourDf(ConStr, Country, League, Season)
GetTourDf(ConStr, 'Англия', 'NA', '2017-2018')

TourList <- GetTourDf(ConStr, 'Англия', 'NA', 'NA')
TourList$Tour[1]
View(res)

source("SportStatFunc.R")
TypeSelect = 7
Season = '2017-2018'
Country = 'Англия'
Tour = 'NULL'
DateFrom = 'NULL'
DateTo = 'NULL'
dtFrom = 'NULL'
dtTo = 'NULL'
TeamList = 'Челси'
TeamList <- paste0("'", TeamList,"'") 
SqlQueryStr <- paste0('exec pGetResultsForPredict ', TypeSelect, ', ', "'", Country, "'", ', ', "'", League, "'", ', ', "'", Season, "'", ', ', Tour, ', ', dtFrom, ',', dtTo, ',', TeamList) 
SqlQueryStr
res <- GetResultsForPredictDf(ConStr, TypeSelect, Country, League, Season, Tour, DateFrom, DateTo, TeamList)
res


dbhandle <- odbcDriverConnect('driver={SQL Server};server=VWRISRU-BI362;database=KfinsDWH;trusted_connection=true')
SqlQueryStr <- paste0("exec RPT_GET_WP 2, '2018-01-01', '2018-01-02'") 
SqlQueryStr
my_df <- sqlQuery(dbhandle, SqlQueryStr)

library("xlsx")
View(my_df)
write.xlsx(my_df, "c:/mydata.xlsx", sheetName = "Sheet1", col.names = TRUE, row.names = TRUE, append = FALSE)
write.xlsx(my_df, "c:/mydata.xlsx")
View(mtcars)
write.xlsx(my_df, "mydata.xlsx")

?withProgress


library(RODBC)
library(RODBCext)
library(dplyr)
ConStr <- 'driver={SQL Server};server=VWRISRU-BI362;database=KfinsDWH;trusted_connection=true'
dbhandle <- odbcDriverConnect(ConStr)
QueryGetTable <- paste("exec KfinsDWH.dbo.ReportDesignerWP '2018-05-01', '2018-05-31'", sep = "")
QueryGetTable
res <- sqlQuery(dbhandle, QueryGetTable)
View(res)

library(RODBCext)
library(dplyr)
ConStr <- 'driver=ODBC Driver 17 for SQL Server;server=VWRISRU-BI362;database=KfinsDWH;trusted_connection=yes'
dbhandle <- odbcDriverConnect(ConStr)
QueryGetTable <- paste("exec KfinsDWH.dbo.ReportDesignerWP '2018-05-01', '2018-05-31'", sep = "")
QueryGetTable
res <- sqlQuery(dbhandle, QueryGetTable)


mtcars

source("LibertyFunc.R")
ConStr <- 'driver={SQL Server};server=VWRISRU-BI362;database=KfinsDWH;trusted_connection=true'
DimList <- GetDimDf(ConStr)

USArrests


devtools::install_github('jbryer/DataCache')
devtools::install_github('jbryer/DataCache')

GetSearch <- function(ConStr, StrToSearch){
  dbhandle <- odbcDriverConnect(ConStr)
  QueryGetTable <- QueryStr <- paste0("select numberofpolicy from Dim_Document_Dmtr where numberofpolicy like '%", StrToSearch, "%' ")
  #QueryGetTable <- QueryStr <- paste0("select numberofpolicy from Dim_Document_Dmtr")
  res <- sqlQuery(dbhandle, QueryGetTable)
  return(res)
}

library(RODBC)
library(RODBCext)
library(dplyr)
library(ggplot2)

GetFuncDf <- function(ConStr, IDReport, nmeasure, ndim, OperationPeriod, IsDetailReportDate){
  dbhandle <- odbcDriverConnect(ConStr)
  if (IsDetailReportDate == TRUE) {IsDetailReportDate = 1} else {IsDetailReportDate = 0}
  QueryGetTable <- paste("exec KfinsDWH.dbo.ReportDesigner '", OperationPeriod[1], "', '", OperationPeriod[2], "', ", IDReport, ", '{", paste0(unlist(nmeasure), collapse=','), "}', '", ndim, "', 0, ",  IsDetailReportDate,  sep = "")
  QueryGetTable
  res <- sqlQuery(dbhandle, QueryGetTable)
  odbcClose(dbhandle)
  return(res)
}



OperationPeriod <- c('2018-06-01', '2018-06-30')
ConStr <- 'driver={SQL Server};server=VWRISRU-BI362;database=KfinsDWH;trusted_connection=true'

df <- GetFuncDf(ConStr, 1, '{[Measures].[Начисл БП],[Measures].[Оплач БП]}', '{Шифр Страхования:315;301;201;310}{Канал продаж:}', OperationPeriod, 1)
View(df)
str(df)
df <- df %>% mutate_all(funs(replace(., is.na(.), 0)))
df$`Отчетная дата` <- as.Date(df$`Отчетная дата`,'%Y-%m-%d') 

df_gr <-  
df %>% 
  group_by(`Отчетная дата`, `Шифр Страхования`) %>% 
  summarise(`Начисл БП` = sum(`Начисл БП`), Cnt=n())

ggplot(df_gr, aes(x = `Отчетная дата`, y = `Начисл БП`)) + geom_bar(stat = "identity", fill="steelblue") +
  facet_grid(. ~ `Шифр Страхования`, ncol = 2)


library('DataCache')
TstDf <- GetSearch(ConStr, '315-')
head(TstDf)
TstDf
TstDf$numberofpolicy
cache.date1 <- data.cache(GetSearch(ConStr, '315-'), frequency=nMinutes(1000))
cache.info()
cacheData(GetSearch(ConStr, '315-'))
nchar('dfdfdf dfd')

cache.date1 <- data.cache(rnorm(10))
data.cache(rnorm(10))

DataCache::data.cache(
  function(){
    list(
      normal_random_numbers = rnorm(10),
      uniform_random_numbers = runif(10)
    )
  },
  cache.name = 'my_random_numbers'
)

?insertUI

?odbcDriverConnect


log(1.1)*120

?stri_enc_toutf8
stri_enc_toutf8("Ура")
x <- "Ура"
Encoding(x) <- "UTF-8"
x
Encoding(x)

?selectInput

library(readr)
mystring <- read_file("settings1.txt")
mystring
tst <- read("settings1.txt")
tst <- scan("settings1.txt")
str(tst)

Sys.getlocale()

Sys.setlocale("LC_ALL","Russian_Russia.1251")
Sys.setlocale("LC_ALL","ru_RU.UTF-8")

Sys.setlocale("LC_CTYPE","Russian_Russia")

Sys.setlocale("LC_ALL","EN")

Sys.setenv("LANGUAGE"="EN")


Sys.setenv(LANG = "rus")
Sys.setenv(NLS_LANG = "rus")
Sys.getenv()

Sys.setenv(LANG = "utf-8")
Sys.setenv(NLS_LANG = "utf-8")


