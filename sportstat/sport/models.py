from django.db import models
import logging
logger = logging.getLogger(__name__)  

def get_country_eng_for_team(self):
    field_name = 'IDCountry'
    obj = self
    field_object = self._meta.get_field(field_name)
    field_value = field_object.value_from_object(obj)

    CountryEngLst = Country.objects.filter(IDCountry = field_value).values('CountryEng')
    if len(CountryEngLst) >0:
        CountryEng = CountryEngLst[0]['CountryEng']
    else:
        CountryEng = 'England'
    return CountryEng

# Create your models here.
class Country(models.Model):
    IDCountry = models.IntegerField(null=True)
    Country = models.CharField(max_length=200)
    CountryEng = models.CharField(max_length=200)
    IsMain = models.IntegerField(null=True)
    IDSeasonType = models.IntegerField(null=True)
    
    def get_absolute_url(self):
        return reverse("country",kwargs={'pk':self.pk})

    def __str__(self):
        return str(self.IDCountry)

    def get_teams(self):     
        return self.teams.filter(idcountry=self.pk)

    # @property
    # def get_label_for_country(self):
    #     # field_name = 'IDCountry'
    #     # obj = self
    #     # field_object = self._meta.get_field(field_name)
    #     # field_value = field_object.value_from_object(obj)

    #     CountryVar = str(Country.objects.get(pk = self.IDCountry).CountryEng)
    #     logger.warning(f'CountryVar: {CountryVar}')
    #     return CountryVar

class League(models.Model):
    IDLeague = models.IntegerField()
    League = models.CharField(max_length=30)
    IDCountry = models.ForeignKey('sport.Country', related_name='leagues', on_delete=models.CASCADE)
    IsPrimary = models.IntegerField(null=True)
    IDLeagueType = models.IntegerField()
    LeagueEng = models.CharField(max_length=200)
    LeagueCurrentSource = models.CharField(max_length=200, null=True)
    LeagueImgSrc = models.ImageField(null=True)

    def __str__(self):
        return self.League

class Team(models.Model):
    IDTeam = models.IntegerField()
    Team = models.CharField(max_length=200)
    # IDCountry = models.IntegerField()
    IDCountry =  models.ForeignKey('sport.Country', related_name='teams', on_delete=models.CASCADE)
    TeamEng = models.CharField(max_length=200, null=True)
    ImgBig = models.ImageField(null=True)
    ImgSmall = models.ImageField(null=True)
    YearFound = models.IntegerField(null=True)
    Color = models.CharField(max_length=100, null=True)
    Stadium = models.CharField(max_length=100, null=True)
    StadiumNumber = models.CharField(max_length=100, null=True)
    Coach = models.CharField(max_length=100, null=True)

    @property
    def get_country_for_team(self):
        field_name = 'IDCountry'
        obj = self
        field_object = self._meta.get_field(field_name)
        field_value = field_object.value_from_object(obj)
        #CountryLst = Country.objects.filter(IDCountry = field_value).values('Country')
        CountryVar = str(Country.objects.get(pk = field_value).Country)
        #logger.warning(f'CountryVar: {CountryVar}')
        return CountryVar

    #def _get_country_for_team(self):
    #Country = property(_get_country_for_team)
    #logger.warning(f'Country: {Country}')

    def __str__(self):
        return str(self.id)

    @property
    def get_small_img_url(self):
        if self.ImgSmall and hasattr(self.ImgSmall, 'url'):
            return self.ImgSmall.url
        else:
            return f"/files/media/{get_country_eng_for_team(self)}.png"

    @property
    def get_big_img_url(self):
        if self.ImgBig and hasattr(self.ImgBig, 'url'):
            return self.ImgBig.url
        else:
            return f"/files/media/{get_country_eng_for_team(self)}.png"

    

class Season(models.Model):
    Season = models.CharField(max_length=20)
    IsCurrentSeason = models.IntegerField()
    IDSeasonType = models.IntegerField(null=True)

    def __str__(self):
        return self.Season

class Result(models.Model):
    Sport = models.CharField(max_length=30,null=True)
    Country = models.CharField(max_length=20)
    Season = models.CharField(max_length=20)
    League = models.CharField(max_length=30)
    Tour =  models.IntegerField(null=True)
    MatchDate = models.DateTimeField(null=True) 
    TeamHome = models.CharField(max_length=200)
    TeamGuest = models.CharField(max_length=200)
    GoalHome =  models.IntegerField(null=True)
    GoalGuest =  models.IntegerField(null=True)
    IDResultType =  models.IntegerField()
    GoalHomePenalty =  models.IntegerField(null=True)
    GoalGuestPenalty =  models.IntegerField(null=True)
    IDSport = models.ForeignKey('sport.Sport', related_name='results_sport', on_delete=models.CASCADE)
    IDCountry = models.ForeignKey('sport.Country', related_name='results_country', on_delete=models.CASCADE)
    IDSeason = models.ForeignKey('sport.Season', related_name='results_season', on_delete=models.CASCADE)
    IDLeague = models.ForeignKey('sport.League', related_name='results_league', on_delete=models.CASCADE) 
    IDTeamHome = models.ForeignKey('sport.Team', related_name='results_home', on_delete=models.CASCADE)
    IDTeamGuest = models.ForeignKey('sport.Team', related_name='results_guest', on_delete=models.CASCADE)
    LastUpdate = models.DateTimeField(null=True) 
    IDFactResult =  models.IntegerField()

    def __str__(self):
        return (self.MatchDate + ' ' + self.TeamHome + ' ' + self.TeamGuest)

class Sport(models.Model):
    IDSport = models.IntegerField()
    Sport = models.CharField(max_length=30)
    SportEng = models.CharField(max_length=30, null=True)

    def __str__(self):
        return self.Sport

class Standing(models.Model):
    IDSport = models.ForeignKey('sport.Sport', related_name='stands_sport', on_delete=models.CASCADE, null=True)
    Country = models.CharField(max_length=30,null=True) 
    CountryEng = models.CharField(max_length=30,null=True) 
    Season = models.CharField(max_length=30, null=True)  
    League = models.CharField(max_length=30, null=True)  
    IDCountry = models.ForeignKey('sport.Country', related_name='stands_country', on_delete=models.CASCADE, null=True) 
    IDSeason = models.ForeignKey('sport.Season', related_name='stands_season', on_delete=models.CASCADE, null=True)  
    IDLeague = models.ForeignKey('sport.League', related_name='stands_league', on_delete=models.CASCADE,null=True) 
    IDTeam = models.ForeignKey('sport.Team', related_name='stands_team', on_delete=models.CASCADE,null=True) 
    TypeTour = models.CharField(max_length=30, null=True) 
    LastTours =  models.IntegerField(null=True)
    TourNumber =  models.IntegerField(null=True)
    TourDate = models.DateTimeField(null=True) 
    Position =  models.IntegerField(null=True) 
    Team = models.CharField(max_length=30, null=True)  
    CountGames =  models.IntegerField(null=True)
    CountWin =  models.IntegerField(null=True)
    CountDraw =  models.IntegerField(null=True) 
    CountLose =  models.IntegerField(null=True) 
    GoalWin =  models.IntegerField(null=True)
    GoalLose =  models.IntegerField(null=True)
    GoalDifference = models.CharField(max_length=30,null=True)  
    CountPoint =  models.IntegerField(null=True)
    CountGamesHome =  models.IntegerField(null=True) 
    CountWinHome =  models.IntegerField(null=True) 
    CountDrawHome  =  models.IntegerField(null=True)
    CountLoseHome  =  models.IntegerField(null=True)
    GoalWinHome  =  models.IntegerField(null=True)
    GoalLoseHome =  models.IntegerField(null=True) 
    GoalDifferenceHome = models.CharField(max_length=30, null=True)  
    CountPointHome  =  models.IntegerField(null=True)
    CountGamesGuest  =  models.IntegerField(null=True) 
    CountWinGuest  =  models.IntegerField(null=True) 
    CountDrawGuest  =  models.IntegerField(null=True) 
    CountLoseGuest  =  models.IntegerField(null=True) 
    GoalWinGuest  =  models.IntegerField(null=True) 
    GoalLoseGuest  =  models.IntegerField(null=True)
    CountPointGuest  =  models.IntegerField(null=True)
    GoalDifferenceGuest = models.CharField(max_length=30, null=True)
    PosType  =  models.IntegerField(null=True)
    Sport = models.CharField(max_length=50, null=True)
    LastGames = models.CharField(max_length=1000, null=True)
    #LastGamesResult = models.CharField(max_length=300, null=True)

    def __str__(self):
        return self.Country

class Predict(models.Model):
    Sport = models.CharField(max_length=30,null=True)
    Country = models.CharField(max_length=20)
    Season = models.CharField(max_length=20)
    League = models.CharField(max_length=30)
    Tour =  models.IntegerField(null=True)
    MatchDate = models.DateTimeField(null=True) 
    TeamHome = models.CharField(max_length=200)
    TeamGuest = models.CharField(max_length=200)
    GoalHome =  models.IntegerField(null=True)
    GoalGuest =  models.IntegerField(null=True)
    PredictHome =  models.IntegerField(null=True)
    PredictGuest =  models.IntegerField(null=True)
    ProbHome =  models.DecimalField(null=True, max_digits=8, decimal_places=4)
    ProbDraw =  models.DecimalField(null=True, max_digits=8, decimal_places=4)
    ProbGuest =  models.DecimalField(null=True, max_digits=8, decimal_places=4)
    PredictType =  models.IntegerField()
    IDFactResult =  models.IntegerField()
    IDResult = models.ForeignKey('sport.Result', related_name='predict_country', on_delete=models.CASCADE)
    IDSport = models.ForeignKey('sport.Sport', related_name='predict_country', on_delete=models.CASCADE)
    IDCountry = models.ForeignKey('sport.Country', related_name='predict_country', on_delete=models.CASCADE)
    IDSeason = models.ForeignKey('sport.Season', related_name='predict_season', on_delete=models.CASCADE)
    IDLeague = models.ForeignKey('sport.League', related_name='predict_league', on_delete=models.CASCADE) 
    IDTeamHome = models.ForeignKey('sport.Team', related_name='predict_home', on_delete=models.CASCADE)
    IDTeamGuest = models.ForeignKey('sport.Team', related_name='predict_guest', on_delete=models.CASCADE)
    DateCreate = models.DateTimeField(null=True)

    @property
    def get_group_country_league(self):
        if self.Tour is None:
            TourStr = ''
        else:
            TourStr = '. ' + str(self.Tour) + ' тур'
        return self.Country + '. ' + self.League + '. ' + self.Season + TourStr
        
    
    # def __init__(self, *args, **kwargs):
    #     super(Standing, self).__init__(*args, **kwargs)
    #     self.fields['Country'].initial = 'Country'
    #     self.fields['Season'].initial = 'Season'
    #     self.fields['League'].initial = 'League'
