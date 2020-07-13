source("SportStatFunc.R")
ConStr <- read_file ("settings.txt")
Lang <-1
IsAddAllCountries <-1
CountryList <- GetCountryDf(Lang, IsAddAllCountries)
#CountryList <- c(as.vector(unlist(CountryList[["Country"]])) , "Все")
#SeasonList <- GetSeasonDf()
#LeagueList <- GetLeagueDf('Англия', 1)
#TourList <- GetTourDf(ConStr, 'Англия', 'NA', 'NA')
#League <- NA

ui <- fluidPage(
wellPanel(
  inputPanel(
    #selectInput("season", label = "Season",
                #choices = SeasonList[,1], selected = subset(SeasonList, IsCurrentSeason==1)$Season),
    selectInput("country", label = "Country",
                choices = CountryList[,1], selected = CountryList$Country[4]),
    uiOutput("SeasonList"),
    uiOutput("LeagueList"),
    uiOutput("TourList"),
    #selectInput("tour", label = "Tour",
    #            choices = TourList[,1], selected = TourList$Tour[1]),
    #selectInput("league", label = "League",
    #            choices = LeagueList[,1], selected = LeagueList$League[1]),
    dateRangeInput('MatchPeriod',
                   label = paste('Дата действия'),
                   start = Sys.Date() - 7, end = Sys.Date()+7,
                   separator = " - ",#, format = "dd/mm/yy",
                   startview = 'month', language = 'eng', weekstart = 1
    ),
    checkboxInput("IsShowPredict", "Прогнозы", value =  TRUE)
  ),
#navbarPage(position = "fixed-top",
#  title = 'Sport Stat',
tabsetPanel( 
tabPanel('Таблица',    
           #uiOutput("SeasonList"),
           fluidRow(
             column(6, DT::dataTableOutput('Standings')), 
             #column(1, tags$br()),
             column(2, DT::dataTableOutput('TeamResult'))
              )
           ),
  tabPanel('Календарь',    
           fluidRow(
             column(7, 
             fluidRow(DT::dataTableOutput('Results')),
             fluidRow(
               column(5, DT::dataTableOutput('TeamResultHome')),
               column(1, tags$br()),
               column(6, DT::dataTableOutput('TeamResultGuest'))
           )),
           column(1, tags$br()),
           column(4, fluidRow(
             DT::dataTableOutput('TeamResultPair')
             #verbatimTextOutput("NumberOfFilters")
             
             ))
           ))
)
)
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  Results <- reactive({
    if (input$tour == 'Все') {
      TypeSelect = 3
      Tour = 'NULL'
    }
    else{
      TypeSelect = 2
      Tour = input$tour
    }
    
    Season = input$season
    Country = input$country
    League = input$league
    DateFrom = toString(input$MatchPeriod[1])
    DateTo = toString(input$MatchPeriod[2])
    if (input$IsShowPredict == TRUE) {IsShowPredict = 1} else {IsShowPredict = 0}
    res <- GetResultsDf(TypeSelect, Country, League, Season, Tour, DateFrom, DateTo, IsShowPredict)
  })
  
  output$Results <- DT::renderDataTable({DT::datatable(Results(),rownames = FALSE, options = list(dom = 'Blrtip'), 
                                                       filter = "none", selection = 'single',class = 'white-space: nowrap')})
  # output$TestCheck <- renderPrint({
  #   if (input$tour == 'Все') {
  #     TypeSelect = 3
  #     Tour = 'NULL'
  #   }
  #   else{
  #     TypeSelect = 2
  #     Tour = input$tour
  #   }
  # 
  #   Season = input$season
  #   Country = input$country
  #   #League = input$league
  #   DateFrom = toString(input$MatchPeriod[1])
  #   #DateTo = str(input$MatchPeriod[2])
  #   DateTo = toString(input$MatchPeriod[2])
  #   #if (input$IsShowPredict == TRUE) {IsShowPredict = 1} else {IsShowPredict = 0}
  #   str(as.vector(GetResultsDf(TypeSelect, Country, League, Season, Tour, DateFrom, DateTo, 1)))
  #   })
  
  SeasonList <- eventReactive(input$country, {GetSeasonDf('null', input$country)}) 
  LeagueList <- eventReactive(input$country, {GetLeagueDf(input$country, Lang)}) 
  TourList <- eventReactive(c(input$league, input$season), {GetTourDf(ConStr, input$country, input$league, input$season)})
  
  
  #selectInput("tour", label = "Tour",
  #            choices = TourList[,1], selected = TourList$Tour[1]),
  
  Season <- eventReactive(input$season, {input$season})
  Country <- eventReactive(input$country, {input$country})
  League <- eventReactive(input$league, {input$league})
  
  TypeTable = 'Всего'
  IsDetailTable =  0
  TypeTour = 'Full'
  LastTours = 'NULL'
  TourNumber = 'NULL'
  TourDate = 'NULL'
  Standings <- eventReactive(list(input$league, input$season) , 
                             {GetStandingsDf(ConStr, Season(), Country(), League(), TypeTable, IsDetailTable, TypeTour, 
                                             LastTours, TourNumber, TourDate)})
  
  TeamResult <- reactive({
  TypeSelect = 7
  Country = input$country
  League = input$league
  Season = input$season
  Tour = 'NULL'
  DateFrom = 'NULL'
  DateTo = 'NULL'
  Position <- ifelse(length(input$Standings_rows_selected)>0, input$Standings_rows_selected, 1)
  TeamList = unlist(Standings()[Position,3])
  res <- GetResultsForPredictDf(TypeSelect, Country, League, Season, Tour, DateFrom, DateTo, TeamList)
  })
  TeamResultHome <- reactive({
    TypeSelect = 7
    Country = input$country
    League = input$league
    Season = input$season
    Tour = 'NULL'
    DateFrom = 'NULL'
    DateTo = 'NULL'
    Position <- ifelse(length(input$Results_rows_selected)>0, input$Results_rows_selected, 1)
    TeamList = unlist(Results()[Position,4])
    res <- GetResultsForPredictDf(TypeSelect, Country, League, Season, Tour, DateFrom, DateTo, TeamList)
  })
  TeamResultGuest <- reactive({
    TypeSelect = 7
    Country = input$country
    League = input$league
    Season = input$season
    Tour = 'NULL'
    DateFrom = 'NULL'
    DateTo = 'NULL'
    Position <- ifelse(length(input$Results_rows_selected)>0, input$Results_rows_selected, 1)
    TeamList = unlist(Results()[Position,7])
    res <- GetResultsForPredictDf(TypeSelect, Country, League, Season, Tour, DateFrom, DateTo, TeamList)
  })
  TeamResultPair <- reactive({
    TypeSelect = 8
    Country = input$country
    League = input$league
    Season = input$season
    Tour = 'NULL'
    DateFrom = 'NULL'
    DateTo = 'NULL'
    Position <- ifelse(length(input$Results_rows_selected)>0, input$Results_rows_selected, 1)
    TeamList = paste(unlist(Results()[Position,4]), unlist(Results()[Position,7]), sep = ",")
    res <- GetResultsForPredictDf(TypeSelect, Country, League, Season, Tour, DateFrom, DateTo, TeamList)
  })
  
  output$SeasonList<- renderUI({
    selectInput("season", label = "Season",
                choices = as.data.frame(SeasonList())['Season'], selected = subset(as.data.frame(SeasonList()), IsCurrentSeason==1)$Season)
  })
  output$LeagueList<- renderUI({
    selectInput("league", label = "League",
                choices = as.data.frame(LeagueList())['League'], selected = as.data.frame(LeagueList())['League'][1])
  })
  output$TourList<- renderUI({
    selectInput("tour", label = "Tour",
                choices = as.data.frame(TourList())['Tour'], selected = as.data.frame(TourList())['Tour'][1])
  })
  output$TeamResultHome <- DT::renderDataTable({DT::datatable(TeamResultHome(),rownames = FALSE, options = list(dom = 'tip' 
                                                       ,columnDefs = list(list(targets = c(6:9), visible = FALSE))
                                                       ), 
                                             filter = "none", selection = 'single',class = 'white-space: nowrap') %>% formatStyle(
                                                       c('GH', 'GG'), 'ResultColor',
                                                       backgroundColor = styleEqual(c(-1, 0, 1), c('red', 'gray', 'green')))
    })
  
  
  output$TeamResultGuest <- DT::renderDataTable({DT::datatable(TeamResultGuest(),rownames = FALSE, options = list(dom = 'tip' 
                                                              ,columnDefs = list(list(targets = c(6:9), visible = FALSE))
                                                             ), 
                                           filter = "none", selection = 'single',class = 'white-space: nowrap')%>% formatStyle(
                                           c('GH', 'GG'), 'ResultColor',
                                           backgroundColor = styleEqual(c(-1, 0, 1), c('red', 'gray', 'green')))
    })
  
  output$TeamResultPair <- DT::renderDataTable({DT::datatable(TeamResultPair(),rownames = FALSE, 
                                  options = list(dom = 'Blrtip',columnDefs = list(list(targets = c(7:9), visible = FALSE))
                                  ), filter = "none", selection = 'single',class = 'white-space: nowrap') 
  })
  
  output$Standings <- DT::renderDataTable({
    DT::datatable(Standings()[,2:11],rownames = FALSE, options = list(dom = 't',paging = FALSE, autoWidth = FALSE), 
                  filter = "none", selection = 'single',class = 'white-space: nowrap')
   })
   # print the selected indices
   #input$Standings_rows_selected
   output$NumberOfFilters<- renderPrint({
     #paste(unlist(Results()[input$Results_rows_selected,4]),collapse= ";")
     Position <- ifelse(length(input$Results_rows_selected)>0, input$Results_rows_selected, 1)
     TeamList = paste(unlist(Results()[Position,4]), unlist(Results()[Position,7]), sep = ",")
     TeamList
     })
   output$TeamResult <-  DT::renderDataTable({
     DT::datatable(TeamResult(), options = list(dom = 'Blrtip', columnDefs = list(list(targets = c(7:10), visible = FALSE))
                                                ),class = 'white-space: nowrap') %>% formatStyle(
       c('GH', 'GG'), 'ResultColor',
       #target = 'rowe',
       backgroundColor = styleEqual(c(-1, 0, 1), c('red', 'gray', 'green')))
   })
}

# Run the application 
shinyApp(ui = ui, server = server)