source("SportStatFunc.R")


Countries <- GetCountryDf(1)
#Countries <- GetCountryDf(1, 0, 'Германия')

for(CountryParametr in Countries$Country) {
  Leagues <- GetLeagueDf(CountryParametr, 1)
  Leagues <- filter(Leagues, Leagues$IDLeagueType == 1)
  Seasons <- GetSeasonDf('null', CountryParametr)
  SeasonParametr <- toString(filter(Seasons, (Seasons$IsCurrentSeason == 1))$Season)
  for(LeagueParametr in Leagues$League) {
    IsCheckIsExistSeasonForCountry <- CheckIsExistSeasonForCountry(CountryParametr, LeagueParametr,SeasonParametr)$IsExist
    if (IsCheckIsExistSeasonForCountry == 1)
      {
        NTourFrom <-  GetNextTour(2, CountryParametr, LeagueParametr,SeasonParametr)$Tour
        NTour <-  GetNextTour(1, CountryParametr, LeagueParametr,SeasonParametr)$Tour
        NTour<- ifelse(NTour<NTourFrom,NTourFrom+1, NTour)
        print(CountryParametr)
        print(LeagueParametr)
        print(SeasonParametr)
        print(NTourFrom)
        print(NTour)
        if(!is.na(NTourFrom) && !is.na(NTour)) {
          ResultPredict <- LoadPrediction(CountryParametr, LeagueParametr, SeasonParametr, NTourFrom, NTour)
        }
      }
  }
}


