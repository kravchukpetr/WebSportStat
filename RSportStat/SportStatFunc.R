library(RODBC)
library(RODBCext)
library(dplyr)
library(shiny)
library(DT)
library(readr)
library(shinyBS)
library(shinyjs)

ConStr <- 'driver={SQL Server};server=localhost;database=SportStat;trusted_connection=true'
CurrentSeason <- '2019-2020'

GetStandingsDf <- function(ConStr, Season = CurrentSeason, Country = 'Англия', League = 'Премьер-лига', TypeTable, IsDetailTable, TypeTour, LastTours, TourNumber, TourDate){
  dbhandle <- odbcDriverConnect(ConStr)
  QueryGetTable <- paste("exec SportStat.dbo.pLoadTable '", Season, "', '", Country, "', '", League, "', '", TypeTable, "', ", IsDetailTable, ", '", TypeTour, "', ", LastTours, ", ", TourNumber, ", ", TourDate, sep = "")
  QueryGetTable
  print(QueryGetTable)
  res <- sqlQuery(dbhandle, QueryGetTable)
  close(dbhandle)
  
  return(res)
}
GetCountryDf <- function(Lang = 1, IsAddAll = 1, Country = 'null'){
  dbhandle <- odbcDriverConnect(ConStr)
  CountryStr = ifelse(Country == 'null', Country, paste0("'", Country, "'"))
  SqlQueryStr <- paste0('exec pGetCountryList ', Lang, ', ', IsAddAll, ", ", CountryStr) 
  #print(SqlQueryStr)
  my_df <- sqlQuery(dbhandle, SqlQueryStr)
  close(dbhandle)
  return(my_df)
}
GetLeagueDf <- function(Country = 'Англия', Lang){
  dbhandle <- odbcDriverConnect(ConStr)
  if (!is.null(Country)) { 
    SqlQueryStr <- paste0("exec pGetLeagueListByCountry '", Country, "', ", Lang)  
  }else{
    SqlQueryStr <- paste0("exec pGetLeagueListByCountry NULL, ", Lang)
  }
  
  my_df <- sqlQuery(dbhandle, SqlQueryStr)
  close(dbhandle)
  return(my_df)
}
GetSeasonDf <- function(IDSeasonType = 'null', Country = 'Англия'){
  dbhandle <- odbcDriverConnect(ConStr)
  SqlQueryStr <- paste0("exec pGetSeasonList ", IDSeasonType, ", '", Country, "'") 
  my_df <- sqlQuery(dbhandle, SqlQueryStr)
  close(dbhandle)
  return(my_df)
}

GetTourDf <- function(ConStr, Country = 'Англия', League = 'Премьер-лига', Season = CurrentSeason){
  dbhandle <- odbcDriverConnect(ConStr)
  SqlQueryStr <- paste0('exec pGetTourList ', "'", Country, "'", ', ', "'", League, "'", ', ', "'", Season, "'")  

  my_df <- sqlQuery(dbhandle, SqlQueryStr)
  close(dbhandle)
  return(my_df)
}

ConvertResultsDf <- function(my_df){
  my_df <- apply(my_df, 1, function(row){
    data.frame(team=c(row['TH'], row['TG']),
               opponent=c(row['TG'], row['TH']),
               goals=c(row['GH'], row['GG']),
               home=c(1, 0),
               season=c(row['Season']),
               tour=c(as.numeric(row['T'])),
               date=c(row['Dt']))
  })
  my_df <- do.call(rbind, my_df)
  my_df$goals <- as.numeric(as.character(my_df$goals))
  return(my_df)
}

GetResultsForPredictDf <- function(TypeSelect, Country, League, Season, Tour, DateFrom, DateTo, TeamList){
  #print(GetResultsForPredictDf)
  dbhandle <- odbcDriverConnect(ConStr)
  if (DateFrom == 'NULL') {
    dtFrom <- 'NULL'
  }
  else {
    dtFrom <- paste0("'", DateFrom,"'")  
  }
  if (DateTo == 'NULL') {
    dtTo <- 'NULL'
  }
  else {
    dtTo <- paste0("'", DateTo,"'")  
  }
  if (ifelse(!is.na(TeamList),TeamList,'NULL') == 'NULL') {
    TeamList <- 'NULL'
  }
  else {
    TeamList <- paste0("'", TeamList,"'") 
  }
  
  SqlQueryStr <- paste0('exec pGetResultsForPredict ', TypeSelect, ', ', "'", Country, "'", ', ', "'", League, "'", ', ', "'", Season, "'", ', ', Tour, ', ', dtFrom, ',', dtTo, ',', TeamList) 
  #print(SqlQueryStr)
  my_df <- sqlQuery(dbhandle, SqlQueryStr)
  close(dbhandle)
  return(my_df) 
  #return(SqlQueryStr)
}

GetResultsDf <- function(TypeSelect, Country, League, Season, Tour, DateFrom, DateTo, IsShowPredict){
  dbhandle <- odbcDriverConnect(ConStr)
  if (DateFrom == 'NULL' || is.na(DateFrom)) {
    dtFrom <- 'NULL'
  }
  else {
    dtFrom <- paste0("'", DateFrom,"'")  
  }
  if (DateTo == 'NULL' || is.na(DateTo)) {
    dtTo <- 'NULL'
  }
  else {
    dtTo <- paste0("'", DateTo,"'")  
  }
  SqlQueryStr <- paste0('exec pGetResults ', TypeSelect, ', ', "'", Country, "'", ', ', "'", League, "'", ', ', "'", Season, "'", ', ', Tour, ', ', dtFrom, ', ', dtTo, ', ', IsShowPredict) 
  my_df <- sqlQuery(dbhandle, SqlQueryStr)
  close(dbhandle)
  return(my_df) #my_df
  #return(SqlQueryStr)
}

GetPredict <- function(model, TeamHome, TeamGuest, MatchDate, TypeReturn) {
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
  return(lst)    
  
}


GetPredictList <- function (to_predict, model){
  for (row in 1:nrow(to_predict)) {
    TeamHome <- to_predict[row, "TH"]
    TeamGuest  <- to_predict[row, "TG"]
    MatchDate  <- to_predict[row, "Dt"]
    lst <- GetPredict(model, TeamHome, TeamGuest, MatchDate, 2)
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
  return(to_predict)
}

WritePredictToDB <- function (ConStr, to_predict){
con <- odbcDriverConnect(ConStr)
cmd <- paste("exec pSavePredict '", to_predict$Season, "', '", 
             to_predict$Country, "', '",
             to_predict$League, "', ",
             to_predict$T, ", '",
             to_predict$Dt, "', '",
             to_predict$TH,"', '", 
             to_predict$TG,"', ",
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
close(con)
return()
}


RunPrediction <- function(IsExistDf, df, CountryParametr, LeagueParametr, SeasonParametr, NTourFrom, NTour){
  if (IsExistDf==0){
    df <- GetResultsForPredictDf(5, CountryParametr, LeagueParametr, SeasonParametr, NTour, 'NULL', 'NULL', 'NULL')
    dfl <- ConvertResultsDf(df)
  } else {dfl <- df}
  ResultPredict = dfl[FALSE,]
  for (row in NTourFrom:NTour) {
    df_for_model <- filter(dfl, (season !=SeasonParametr  | (season ==SeasonParametr  & tour < row)))
    model <- glm(goals ~ home + team + opponent, family=poisson(link=log), data=df_for_model)
    to_predict <-  GetResultsForPredictDf(2, CountryParametr, LeagueParametr, SeasonParametr, row, 'NULL', 'NULL', 'NULL')
    to_predict <- GetPredictList(to_predict, model)
    WritePredictToDB(ConStr, to_predict)
    if(nrow(ResultPredict)==0){
      ResultPredict <- to_predict
    } else {
      ResultPredict <- rbind(ResultPredict, to_predict)
    }
  }
  return(ResultPredict)
}

LoadPrediction <- function(CountryParametr, LeagueParametr, SeasonParametr, NTourFrom, NTour){
  df <- GetResultsForPredictDf(5, CountryParametr, LeagueParametr, SeasonParametr, NTour, 'NULL', 'NULL', 'NULL')
  dfl <- ConvertResultsDf(df)
  ResultPredict <- RunPrediction(1, dfl, CountryParametr, LeagueParametr, SeasonParametr, NTourFrom, NTour)
  return(ResultPredict)
}

GetNextTour <- function(TypeSelect, Country, League, Season){
  dbhandle <- odbcDriverConnect(ConStr)
  SqlQueryStr <- paste0('exec pGetNextTour ', TypeSelect,  ", '", Country, "'", ', ', "'", League, "'", ', ', "'", Season, "'")  
  print(SqlQueryStr)
  my_df <- sqlQuery(dbhandle, SqlQueryStr)
  close(dbhandle)
  return(my_df)
}

CheckIsExistSeasonForCountry <- function( Country, League, Season){
  dbhandle <- odbcDriverConnect(ConStr)
  SqlQueryStr <- paste0('exec pCheckIsExistSeasonForCountry ',  "'", Country, "'", ', ', "'", League, "'", ', ', "'", Season, "'")  
  my_df <- sqlQuery(dbhandle, SqlQueryStr)
  close(dbhandle)
  return(my_df)
}


