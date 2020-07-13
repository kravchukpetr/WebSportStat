source("SportStatFunc.R")
my_df <- GetResultsDf(5, 'Англия', 'Премьер-лига', '2017-2018', 17, 'NULL')


df <- ConvertResultsDf(my_df)
#dfl <- filter(df, (Season !="2017-2018" | (Season =="2017-2018" & Tour < 14)))
model <- glm(goals ~ home + team + opponent, family=poisson(link=log), data=df)
to_predict <-  GetResultsDf(3, 'Англия', 'Премьер-лига', '2017-2018', 17, 'NULL')#result not exist
to_predict <- GetPredictList(to_predict)

filter(my_df, ((TeamHome =='Атлетик' & TeamGuest == 'Реал') | (TeamGuest =='Атлетик' & TeamHome == 'Реал')))
filter(my_df, ((TeamHome =='Хаддерсфилд' | TeamGuest == 'Хаддерсфилд') & Season =="2017-2018"))
filter(my_df, ((TeamHome =='Челси' | TeamGuest == 'Челси') & Season =="2017-2018"))



my_df 
to_predict
table(ResultPredict["Result"])
table(ResultPredict["Score"])

avector <- aframe[ , "a2"]

as.vector(CountryList[])
CountryList <- GetCountryDf(1)
str(CountryList)
avector <- CountryList[ , "Country", drop=FALSE]
str(avector)

tst <- c(as.vector(unlist(CountryList[["Country"]])) , "Все")
tst
avector <-as.vector(unlist(CountryList[["Country"]]))  
#CountryList[["Country"]] 
#dplyr::pull(CountryList, Country)

GetResultsDf(1, "Англия", NA, "2018-2019", "NULL", "2018-02-04", "2018-02-04",1)

TypeSelect = 7
TeamList = "Арсенал;Манчестер Юнайтед"
GetResultsForPredictDf(TypeSelect, "Англия", NA, "2018-2019", "NULL", "2018-01-01", "2018-12-31", TeamList)




source("SportStatFunc.R")


CountryParametr <- 'Франция'
SeasonParametr <- '2018-2019'

#for(CountryParametr in Countries$Country) {
  Leagues <- GetLeagueDf(CountryParametr, 1)
#  for(LeagueParametr in Leagues$League) {
    IsCheckIsExistSeasonForCountry <- CheckIsExistSeasonForCountry(CountryParametr, LeagueParametr,SeasonParametr)$IsExist
    IsCheckIsExistSeasonForCountry
    #if (IsCheckIsExistSeasonForCountry == 1)
    #{
      NTourFrom <-  GetNextTour(2, CountryParametr, LeagueParametr,SeasonParametr)$Tour
      NTour <-  GetNextTour(1, CountryParametr, LeagueParametr,SeasonParametr)$Tour
      print(CountryParametr)
      print(LeagueParametr)
      print(SeasonParametr)
      print(NTourFrom)
      print(NTour)
      
      #ResultPredict <- LoadPrediction(CountryParametr, LeagueParametr, SeasonParametr, NTourFrom, NTour)
      ##
      df <- GetResultsForPredictDf(5, CountryParametr, LeagueParametr, SeasonParametr, NTour, 'NULL', 'NULL', 'NULL')
      dfl <- ConvertResultsDf(df)
      #ResultPredict <- RunPrediction(1, dfl, CountryParametr, LeagueParametr, SeasonParametr, NTourFrom, NTour)
      ###
      #dfl <- df
      ResultPredict = dfl[FALSE,]
      #for (row in NTourFrom:NTour) {
      NTourFrom:NTour
      row <- 26
        df_for_model <- filter(dfl, (season !=SeasonParametr  | (season ==SeasonParametr  & tour < row)))
        model <- glm(goals ~ home + team + opponent, family=poisson(link=log), data=df_for_model)
        to_predict <-  GetResultsForPredictDf(2, CountryParametr, LeagueParametr, SeasonParametr, row, 'NULL', 'NULL', 'NULL')
        to_predict <- GetPredictList(to_predict, model)
        ####
        
        for (row in 1:nrow(to_predict)) {
          print(row)
          row <- 2
          TeamHome <- to_predict[row, "TH"]
          TeamGuest  <- to_predict[row, "TG"]
          MatchDate  <- to_predict[row, "Dt"]
          lst <- GetPredict(model, TeamHome, TeamGuest, MatchDate, 2)
          #####
          TeamHome
          TeamGuest
          MatchDate
          
          GetPredict(model, TeamHome, TeamGuest, MatchDate, 2)
          #####
          
          #######
          av_home_goals <- predict(model, 
                                   data.frame(home=1, team=TeamHome, 
                                              opponent=TeamGuest), 
                                   type="response")
          
          av_away_goals <- predict(model, 
                                   data.frame(home=0, team=TeamGuest, 
                                              opponent=TeamHome), 
                                   type="response")
          home_goals <- dpois(0:10, av_home_goals) 
          away_goals <- dpois(0:10, av_away_goals)
          
          m <- home_goals %o% away_goals
          
          total_result <- which(m == max(m), arr.ind = TRUE)-1
          
          draw <- sum(diag(m))
          away <- sum(m[upper.tri(m)])
          home <- sum(m[lower.tri(m)])
          
          
          if (TypeReturn == 1) {
            lst <- list(TeamHome, TeamGuest, MatchDate, av_home_goals, av_away_goals, home_goals, away_goals, m, total_result, home, draw, away)
          }
          if (TypeReturn == 2) {
            lst <- list(total_result[1], total_result[2], round(home,4), round(draw,4), round(away,4))
          }
          #######
          lst
          #print (paste(TeamHome, ' - ', TeamGuest, ' ', lst[1], ':', lst[2], ' Победа 1:', lst[3], ' Ничья:', lst[4], 'Победа 2:', lst[5]))
          to_predict[row, "PredictHome"] <-   lst[1]
          to_predict[row, "PredictGuest"] =  lst[2]
          to_predict[row, "ProbHome"] =  lst[3]
          to_predict[row, "ProbDraw"] =  lst[4]
          to_predict[row, "ProbGuest"] =  lst[5]
        }
        
        to_predict["Result"] <- ifelse((to_predict$GH > to_predict$GG & to_predict$PredictHome > to_predict$PredictGuest) 
                                       | (to_predict$GH < to_predict$GG & to_predict$PredictHome < to_predict$PredictGuest)
                                       | (to_predict$GH == to_predict$GG & to_predict$PredictHome == to_predict$PredictGuest)
                                       , 1,0)
        to_predict["Score"] <- ifelse(to_predict$GH == to_predict$PredictHome & to_predict$GG == to_predict$PredictGuest 
                                      , 1,0)
        ####
        WritePredictToDB(ConStr, to_predict)
        if(nrow(ResultPredict)==0){
          ResultPredict <- to_predict
        } else {
          ResultPredict <- rbind(ResultPredict, to_predict)
        }
      ###
      ##
     

