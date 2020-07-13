source("SportStatFunc.R")

NTourFrom = 2
NTour = GetNextTour(1, CountryParametr, LeagueParametr,SeasonParametr)$Tour
#SeasonParametr = "2018-2019"
CountryParametr = 'Англия'
LeagueParametr = 'Премьер-лига'
Seasons <- GetSeasonDf()

tst <- filter(Seasons, (Seasons$Season == "2018-2019"))


res <- lapply(tst$Season, function(x) {LoadPrediction(CountryParametr, LeagueParametr, toString(x), NTourFrom, NTour)})
#ResultPredict <- LoadPrediction(CountryParametr, LeagueParametr, SeasonParametr, NTourFrom, NTour)

ResultPredict = tst[FALSE,]
for(row in 1:nrow(tst)) {
  ResultPredict <- rbind(ResultPredict, as.data.frame(res[row]))
}

GetCountryDf(1)

##################################Загрузка прогнозов###################################################
source("SportStatFunc.R")

Countries <- GetCountryDf(1)
Countries <- filter(Countries, Countries$Country == "Англия")
Countries
Seasons


for(CountryParametr in Countries$Country) {
  print(CountryParametr)
  Leagues <- GetLeagueDf(CountryParametr, 1)
  for(LeagueParametr in Leagues$League) {
    print(LeagueParametr)
    CountSeason <- 1
    IDSeasonType <- 1
    Seasons <- GetSeasonDf(IDSeasonType)
    for(SeasonParametr in Seasons$Season){
      print(SeasonParametr)
      IsCheckIsExistSeasonForCountry <- CheckIsExistSeasonForCountry(CountryParametr, LeagueParametr,SeasonParametr)$IsExist
      print(IsCheckIsExistSeasonForCountry)
      if (IsCheckIsExistSeasonForCountry == "1")
      {
        if (CountSeason == 1) {NTourFrom <-  3} else {NTourFrom <-  2}
        NTour <-  GetNextTour(1, CountryParametr, LeagueParametr,SeasonParametr)$Tour
        print(NTourFrom)
        print(NTour)
        ResultPredict <- LoadPrediction(CountryParametr, LeagueParametr, SeasonParametr, NTourFrom, NTour)
        CountSeason <- CountSeason + 1
      }
    }
  }
}  





table(ResultPredict["Result"])
table(ResultPredict["Score"])

aggregate(ResultPredict["Result"], by = ResultPredict["Tour"], FUN = sum)
aggregate(ResultPredict["Score"], by = ResultPredict["Tour"], FUN = sum)
