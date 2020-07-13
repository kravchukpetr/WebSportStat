source("SportStatFunc.R")
ConStr <- 'driver={SQL Server};server=localhost;database=SportStat;trusted_connection=true'
my_df <- GetResultsForPredictDf(ConStr, 5, 'Англия', 'Премьер-лига', '2018-2019', 22, 'NULL', 'NULL', 'NULL')

my_df
#str(my_df)
#filter(my_df, (Season =="2017-2018" & Tour == "14"))
df <- ConvertResultsDf(my_df)
#dfl <- filter(df, (Season !="2017-2018" | (Season =="2017-2018" & Tour < 21)))
model <- glm(goals ~ home + team + opponent, family=poisson(link=log), data=df)
to_predict <-  GetResultsForPredictDf(ConStr, 2, 'Англия', 'Премьер-лига', '2018-2019', 21, 'NULL', 'NULL', 'NULL')#result exist
to_predict <-  GetResultsForPredictDf(ConStr, 3, 'Англия', 'Премьер-лига', '2018-2019', 22, 'NULL', 'NULL', 'NULL')#result not exist

to_predict

ifelse(is.na(to_predict$Result), 'NULL', to_predict$Result)



library(RODBC)
con <- odbcDriverConnect(ConStr)

#df <- data.frame(a=1:10, b=10:1, c=11:20)
cmd <- paste("exec pSavePredict '", to_predict$Season, "', '", 
                                    to_predict$Country, "', '",
                                    to_predict$League, "', ",
                                    to_predict$Tour, ", '",
                                    to_predict$MatchDate, "', '",
                                    to_predict$TeamHome,"', '", 
                                    to_predict$TeamGuest,"', ",
                                    to_predict$PredictHome,", ",
                                    to_predict$PredictGuest,", ",
                                    to_predict$ProbHome,", ",
                                    to_predict$ProbDraw,", ",
                                    to_predict$ProbGuest,", ",
                                    ifelse(is.na(to_predict$Result), 'NULL', to_predict$Result),", ",
                                    ifelse(is.na(to_predict$Score), 'NULL', to_predict$Score),", 1, NULL ", 
                                    sep="", collapse="\t")

cmd
result <- sqlQuery(con, cmd)
result



to_predict <- GetPredictList(to_predict, model)
WritePredictToDB(ConStr, to_predict)

#to_predict(["TeamHome"])
to_predict$str <- to_predict$TeamGuest + to_predict$TeamGuest
tst <- paste0(to_predict$TeamHome, " - ", to_predict$TeamGuest)
str(tst)
to_predict[1,c("TeamHome","TeamGuest")]
#TeamHome <- "Челси"
#TeamGuest <- "Суонси"
#MatchDate <- "2017-11-29"
#to_predict
#lst <- GetPredict(model, TeamHome, TeamGuest, MatchDate, 2)
#lst
#lst[1]
#print (paste(TeamHome, ' - ', TeamGuest, ' ', lst[1], ':', lst[2], ' Победа 1:', lst[3], ' Ничья:', lst[4], 'Победа 2:', lst[5]))

GetLeagueDf(ConStr, 'Англия', 1)

LeagueList <- GetLeagueDf(ConStr, 'Англия', 1)
LeagueList

NTourFrom = 23
NTour = 23
SeasonParametr = "2014-2015"
CountryParametr = 'Англия'
LeagueParametr = 'Премьер-лига'

df <- GetResultsForPredictDf(ConStr, 5, CountryParametr, LeagueParametr, SeasonParametr, NTour, 'NULL', 'NULL', 'NULL')

dfl <- ConvertResultsDf(df)
df2 <- filter(dfl, (season !=SeasonParametr  | (season ==SeasonParametr  & tour < 23)))

df2 <- filter(dfl, (season < SeasonParametr  | (season ==SeasonParametr  & tour < 23)))


head(df)
head(dfl)
head(df2)

model <- glm(goals ~ home + team + opponent, family=poisson(link=log), data=df2)
to_predict <-  GetResultsForPredictDf(ConStr, 2, 'Англия', 'Премьер-лига', '2018-2019', 23, 'NULL', 'NULL', 'NULL')
to_predict <- GetPredictList(to_predict, model)
WritePredictToDB(ConStr, to_predict)
if(nrow(ResultPredict)==0){
  ResultPredict <- to_predict
} else {
  ResultPredict <- rbind(ResultPredict, to_predict)
}

tst <- dfl%>%
  filter(., Season ==SeasonParametr) %>% group_by(., Tour) %>% summarise(., Cnt = n())
tst1 <- df%>%
  filter(., Season ==SeasonParametr) %>% group_by(., Tour) %>% summarise(., Cnt = n())

tst
View(tst1)

ResultPredict = c("")
nrow(ResultPredict)

NTourFrom = 2
NTour = 38
SeasonParametr = "2006-2007"
CountryParametr = 'Англия'
LeagueParametr = 'Премьер-лига'

LoadPrediction(CountryParametr, LeagueParametr, SeasonParametr, NTourFrom, NTour)

ResultPredict <- LoadPrediction(CountryParametr, LeagueParametr, SeasonParametr, NTourFrom, NTour)
  

df <- GetResultsForPredictDf(ConStr, 5, CountryParametr, LeagueParametr, SeasonParametr, NTour, 'NULL', 'NULL', 'NULL')
dfl <- ConvertResultsDf(df)
ResultPredict <- RunPrediction(1, dfl, CountryParametr, LeagueParametr, SeasonParametr, NTourFrom, NTour)

NTourFrom:NTour
ResultPredict = dfl[FALSE,]
for (row in NTourFrom:NTour) {
  print(row)
  row <- 2
  df_for_model <- filter(dfl, (season !=SeasonParametr  | (season ==SeasonParametr  & tour < row)))
  df_for_model
  model <- glm(goals ~ home + team + opponent, family=poisson(link=log), data=df_for_model)
  to_predict <-  GetResultsForPredictDf(ConStr, 2, CountryParametr, LeagueParametr, SeasonParametr, row, 'NULL', 'NULL', 'NULL')
  to_predict
  to_predict <- GetPredictList(to_predict, model)
  WritePredictToDB(ConStr, to_predict)
  if(nrow(ResultPredict)==0){
    ResultPredict <- to_predict
  } else {
    ResultPredict <- rbind(ResultPredict, to_predict)
  }
}

df <- c("")
ResultPredict <- RunPrediction(0, df, CountryParametr, LeagueParametr, SeasonParametr, NTourFrom, NTour)


SeasonParametr = "2017-2018"
CountryParametr = 'Англия'
LeagueParametr = 'Премьер-лига'

GetNextTour(1, CountryParametr, LeagueParametr,SeasonParametr)$Tour


ResultPredict = to_predict[FALSE,]
for (row in NTourFrom:NTour) {
  dfl <- filter(df, (Season !=SeasonParametr  | (Season ==SeasonParametr  & Tour < row)))
  df2 <- ConvertResultsDf(dfl)
  model <- glm(goals ~ home + team + opponent, family=poisson(link=log), data=df2)
  to_predict <-  GetResultsForPredictDf(ConStr, 2, CountryParametr, LeagueParametr, SeasonParametr, row, 'NULL', 'NULL', 'NULL')
  to_predict <- GetPredictList(to_predict, model)
  WritePredictToDB(ConStr, to_predict)
  if(nrow(ResultPredict)==0){
    ResultPredict <- to_predict
  } else {
    ResultPredict <- rbind(ResultPredict, to_predict)
  }
}
ResultPredict
table(ResultPredict["Result"])
table(ResultPredict["Score"])

aggregate(ResultPredict["Result"], by = ResultPredict["Tour"], FUN = sum)
aggregate(ResultPredict["Score"], by = ResultPredict["Tour"], FUN = sum)


