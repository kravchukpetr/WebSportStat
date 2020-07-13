from django.shortcuts import render
from django.http import HttpResponse
from django.db import connection
from sport.models import Country, League, Team, Sport, Season, Standing, Result, Predict
from django.views.generic import (TemplateView,ListView,
                                  DetailView,CreateView,
                                  UpdateView,DeleteView)
import logging
from django.db.models import CharField, Value, Subquery
from django.conf import settings as conf_settings
from datetime import datetime, timedelta
from django.db.models import Q
# Create your views here.
logger = logging.getLogger(__name__)    

# def index(request):
#     return render(request,'sport/index.html')
    
def countries(request):

    country_list = Country.objects.order_by('-IsMain', 'Country')
    country_dict = {"countries":country_list,
                    "MEDIA_URL":conf_settings.MEDIA_URL,
                   }
    return render(request,'sport/country_list.html',context=country_dict)

def leagues(request, country_id = None):
    if country_id is None:
        league_list = League.objects.order_by('IDCountry', 'IsPrimary', 'League')
        country = None
    else:
        league_list = League.objects.filter(IDCountry = country_id).order_by('IDCountry', 'IsPrimary', 'League')
        country_obj = Country.objects.filter(pk = country_id).values('Country')[0]
        country = str.join(" ", country_obj.values())

    country_list = Country.objects.all()
    league_dict = {"leagues":league_list,
                   "MEDIA_URL":conf_settings.MEDIA_URL,
                   "countries": country_list,
                   "country" : country,
                  }
    return render(request,'sport/league.html',context=league_dict)

def sports(request):

    sport_list = Sport.objects.order_by('Sport')
    sport_dict = {"sports":sport_list}
    return render(request,'sport/sport.html',context=sport_dict)

def seasons(request):

    season_list = Season.objects.order_by('Season')
    season_dict = {"seasons":season_list}
    # CntElmt = type(season_list)
    # logger.error(f'season_list type: {CntElmt}')
    return render(request,'sport/season.html',context=season_dict)

def teams(request, country_id = None):

    if country_id is None:
        team_list = Team.objects.order_by('Team')
        country = None
        country_img = None
    else:
        team_list = Team.objects.filter(IDCountry = country_id).order_by('Team')
        country_obj = Country.objects.filter(pk = country_id).values('Country', 'CountryEng')[0]
        country = country_obj.get('Country') #str.join(" ", country_obj.values())
        country_img = country_obj.get('CountryEng') #str.join("", country_obj.values())

    country_list = Country.objects.all()

    team_dict = {"teams" : team_list,
                 "country" : country,
                 "country_img" : country_img,
                 "countries" : country_list,
                 "MEDIA_URL" : conf_settings.MEDIA_URL,
                }
    response = render(request,'sport/team_list.html',context=team_dict)
    response['MyHeader'] = 'Some header'
    return response

def results(request, country_id = 1, season_id = None, league_id = None):

    if season_id is None:
        season_obj = Season.objects.filter(IsCurrentSeason = 1).values('Season')[0]
        season_id = str.join(" ", season_obj.values())

    if league_id is None:
        league_obj = League.objects.filter(IDCountry = country_id, IsPrimary = 1).values('IDLeague')[0]
        logger.warning(f'league_obj = : {league_obj}')     
        league_id = league_obj.get('IDLeague')

    country_obj = Country.objects.filter(pk = country_id).values('Country', 'CountryEng')[0]
    country = country_obj.get('Country') #str.join(" ", country_obj.values())    
    country_img = country_obj.get('CountryEng')

    result_list = Result.objects.filter(IDCountry = country_id, Season = season_id, IDLeague = league_id).order_by('MatchDate')
    country_list = Country.objects.all()
    season_list = Season.objects.all()
    league_list = League.objects.filter(IDCountry = country_id)

    league_obj = League.objects.filter(pk = league_id).values('League', 'LeagueImgSrc')[0]    
    league = league_obj.get('League')
    league_img = league_obj.get('LeagueImgSrc')
    #logger.warning(f'league = : {league}') 

    result_dict = {"results":result_list, 
                     "countries": country_list,
                     "seasons": season_list,
                     "leagues": league_list,
                     "country_id": country_id, 
                     "season_id" : season_id,
                     "league_id" : league_id,
                     "league" : league,
                     "country" : country,
                     "league_img" : league_img,
                     "country_img" : country_img,
                     "MEDIA_URL" : conf_settings.MEDIA_URL,
                     }
    return render(request,'sport/result_list.html',context=result_dict)

def standings(request, country_id = 1, season_id = None, league_id = None):

    if season_id is None:
        season_obj = Season.objects.filter(IsCurrentSeason = 1).values('Season')[0]
        season_id = str.join(" ", season_obj.values())
    if league_id is None:
        league_obj = League.objects.filter(IDCountry = country_id, IsPrimary = 1).values('IDLeague')[0]
        league_id = league_obj.get('IDLeague')   
    standing_list = Standing.objects.filter(IDCountry = country_id, Season = season_id, IDLeague = league_id).order_by('Position')
    country_list = Country.objects.all()
    league_list = League.objects.filter(IDCountry = country_id).order_by('IsPrimary')

    logger.warning(f"league_id = : {league_id}") 
    logger.warning(f"league_list = : {league_list}") 

    country_obj = Country.objects.filter(pk = country_id).values('Country')[0]
    country = str.join(" ", country_obj.values())
    country_obj = Country.objects.filter(pk = country_id).values('CountryEng')[0]
    country_img = str.join("", country_obj.values())
    country_obj = Country.objects.filter(pk = country_id).values('IDSeasonType')[0]
    IDSeasonType = country_obj.get('IDSeasonType')
    season_list = Season.objects.filter(IDSeasonType = IDSeasonType).all()

    league_obj = League.objects.filter(pk = league_id).values('League', 'LeagueImgSrc')[0]    
    league = league_obj.get('League')
    league_img = league_obj.get('LeagueImgSrc')

    #logger.warning(f"league_id = : {league_id}") 
    #logger.warning(f"league_img = : {league_img}")      

    i = 0
    lst_res_str = []
    lst_team_img = []
    dict_res_str = {}
    
    for row in standing_list.values('LastGames'):
        res = standing_list.values('LastGames')[i]['LastGames'].split(', ')
        # logger.warning(f"tst_dict = : {tst_dict}")        
        result = ''.join([str(elem) for elem in map(GetResultStr, enumerate(res))])
        lst_res_str.append(result) 
        i+=1

    i=0
    for row in standing_list.values('IDTeam'):
        try:
            res = row['IDTeam']
            team_obj = Team.objects.filter(pk = row['IDTeam']).values('ImgSmall')[0]
            team_img = f"{conf_settings.MEDIA_URL}{team_obj['ImgSmall']}"
        except:
            team_img =  ""          
        lst_team_img.append(team_img)
        i+=1

    dict_res_str['LastGamesResult'] = lst_res_str
    dict_res_str['TeamImg'] = lst_team_img
    # logger.warning(f"dict_res_str = : {dict_res_str}")
    # logger.warning(f"tst_lst = : {tst_lst}")
    # logger.warning(f"type(standing_list.values('LastGames')) = : {type(standing_list.values('LastGames'))}")
    # logger.warning(f"type(standing_list.values('LastGames')[0]) = : {type(standing_list.values('LastGames')[0])}")
    # logger.warning(f"type = : {standing_list.values('LastGames')[0]}")
    # logger.warning(f"type = : {standing_list.values('LastGames')[1]}")
    # standing_list.all().annotate(LastGamesResult=Value('777', output_field=CharField()))  
    #subquery = Subquery(standing_list.values('LastGames')[0])
    #standing_list.annotate(LastGamesResult=subquery) 
    # i = 0
    # for obj in standing_list.values('LastGamesResult') :
    #     logger.warning(f"type = : {type(obj)}")
    #     #obj.LastGamesResult = lst_res_str[i]
    #     i+=1

    # .select_related("stands_country")
    standing_dict = {"standings": standing_list, 
                     "countries": country_list,
                     "seasons": season_list,
                     "leagues" : league_list,
                     "country_id": country_id, 
                     "season_id" : season_id,
                     "league_id" : league_id,
                     "league_img" : league_img,
                     "league" : league,
                     "country" : country,
                     "dict_res_str" : dict_res_str,
                     "country_img" : country_img,
                     "MEDIA_URL" : conf_settings.MEDIA_URL,
                     }
    return render(request,'sport/standing.html',context=standing_dict)

# def standings(request):
        
#     cursor = connection.cursor()
#     cursor.execute('exec SportStat.dbo.sp_get_standing 1')
#     standing_list = cursor.fetchall()

#     # CntElmt = type(standing_list[0])
#     # logger.error(f'standing_list[0]: {CntElmt}')

#     standing_dict = {"standings":standing_list}
#     return render(request,'sport/standing.html',context=standing_dict)

class CountryDetailView(DetailView):
    model = Country
    #template_name = 'country_detail.html'

    def get_context_data(self, **kwargs):
        context = super(CountryDetailView, self).get_context_data(**kwargs)
        context['MEDIA_URL'] = conf_settings.MEDIA_URL
        #context['tasks'] = Task.objects.filter(list=self.object)
        return context

    # def get_queryset(self):
    #     queryset = super().get_queryset()
    #     queryset = queryset.filter()
    #     return queryset

class TeamDetailView(DetailView):
    model = Team
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        results_home = self.results_home.all()
        results_guest = self.results_guest.all()
        context['results_list'] = results_home.union(results_guest, all=True).order_by('MatchDate')
        return context

    # def get_context_data(self, *args, **kwargs):
    #     context = super(ProjectDetail, self).get_context_data(*args, **kwargs)
    #     context['todolist'] = ProjectsToDo.objects.order_by('project_tododate')
    #     context['todoform'] = ProjectToDoForm()
    #     context['form'] = ProjectForm(instance=Projects.objects.get(slug=self.kwargs['slug']))
    #     return context

    # def get_queryset(self):
    #     return Team.results_home.filter(TeamHome = self.request.tem)
    # .union(model.results_guest.all()) 

def team_detail(request, pk, season_id = None):

    if season_id is None:
        season_obj = Season.objects.filter(IsCurrentSeason = 1).values('Season')[0]
        season_id = str.join(" ", season_obj.values())

    results_home_list =  Result.objects.filter(IDTeamHome = pk, Season = season_id)
    results_guest_list = Result.objects.filter(IDTeamGuest = pk, Season = season_id)
    
   
    obj_team = Team.objects.get(pk=pk)
    #team = obj_team.Team
    # team = Team.objects.filter(IDTeam = pk).values()
    # team_obj = Team.objects.filter(IDTeam = pk).values('Team')[0]
    # team = str.join(" ", team_obj.values())

    ImgBig_obj = Team.objects.filter(IDTeam = pk).values('ImgBig')[0]
    ImgBig =  f"{conf_settings.MEDIA_URL}{ImgBig_obj['ImgBig']}"

    #logger.warning(f'obj_team.get_country_for_team: {obj_team.get_country_for_team}')

    results_list = results_home_list.union(results_guest_list, all=True).order_by('MatchDate')
    season_list = Season.objects.all()

    return render(request, 'sport/team_detail.html', {'results_list' : results_list,
                                                       'team' : obj_team,
                                                       'season' : season_id,
                                                       'seasons' : season_list,
                                                       'TeamID' : pk,
                                                       'ImgBig' : ImgBig
                                                     })

class PredictDetailView(DetailView):
    model = Predict
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        predict_obj = Predict.objects.filter(pk  = self.kwargs['pk']).values('TeamHome', 'TeamGuest')[0]
        TeamHome = predict_obj['TeamHome']
        TeamGuest = predict_obj['TeamGuest'] 
        logger.warning(f"predict_obj = {predict_obj};")
        result_home_obj = Result.objects.filter((Q(TeamHome = TeamHome) | Q(TeamGuest = TeamHome)) & (Q(GoalHome__isnull=False))).order_by('-MatchDate')[:10]
        result_guest_obj = Result.objects.filter((Q(TeamHome = TeamGuest) | Q(TeamGuest = TeamGuest)) & (Q(GoalHome__isnull=False))).order_by('-MatchDate')[:10]
        result_together_obj = Result.objects.filter(((Q(TeamHome = TeamHome) & Q(TeamGuest = TeamGuest)) | (Q(TeamHome = TeamGuest) & Q(TeamGuest = TeamHome))) & (Q(GoalHome__isnull=False))).order_by('-MatchDate')[:10]

        i=0
        dict_result = {}
        result_home_total = []
        for row in result_home_obj.values('TeamHome', 'TeamGuest', 'GoalHome', 'GoalGuest'):
            # logger.warning(f"Team = {TeamHome}; row['TeamHome'] = {row['TeamHome']}; row['TeamGuest'] = {row['TeamGuest']}; row['GoalHome'] = {row['GoalHome']}; row['GoalGuest'] = {row['GoalGuest']}")
            total_type = GetResultTotal(TeamHome, row['TeamHome'], row['TeamGuest'], row['GoalHome'], row['GoalGuest'])
            result_home_total.append(total_type)
        
        result_guest_total = []
        for row in result_guest_obj.values('TeamHome', 'TeamGuest', 'GoalHome', 'GoalGuest'):
            total_type = GetResultTotal(TeamGuest, row['TeamHome'], row['TeamGuest'], row['GoalHome'], row['GoalGuest'])
            result_guest_total.append(total_type)
         
        # logger.warning(f'result_home_total: {result_home_total}')
        # logger.warning(f'result_guest_total: {result_guest_total}')
        dict_result['result_home_total'] = result_home_total
        dict_result['result_guest_total'] = result_guest_total
        context['results_home'] = result_home_obj
        context['results_guest'] = result_guest_obj
        context['results_together'] = result_together_obj
        context['dict_result'] = dict_result
        return context

def predict(request):
    current_date = datetime.now()
    date_from = current_date + timedelta(days=-10)
    date_to = current_date + timedelta(days=5)
    predict_list = Predict.objects.filter(MatchDate__range=[date_from, date_to]).order_by('Country', 'League', 'Tour', 'MatchDate')
    logger.warning(f'date_from = : {date_from}') 
    logger.warning(f'date_to = : {date_to}') 
    logger.warning(f'predict_list = : {predict_list}') 

    result_dict = {"predicts":predict_list, 
                     # "countries": country_list,
                     # "seasons": season_list,
                     # "leagues": league_list,
                     # "country_id": country_id, 
                     # "season_id" : season_id,
                     # "league_id" : league_id,
                     # "league" : league,
                     # "country" : country,
                     # "league_img" : league_img,
                     # "country_img" : country_img,
                     "MEDIA_URL" : conf_settings.MEDIA_URL,
                     }
    return render(request,'sport/index.html',context=result_dict)
def GetResultStr(val_str):
    res = val_str[1].lstrip().split(' ')[0].split(':')
    type_res = val_str[1].lstrip().split(' ')[1]
    tooltip_str = val_str[1].lstrip().split(' ')[0] + ' ' + ' '.join(str(e) for e in val_str[1].lstrip().split(' ')[2:])
    num_res=val_str[0]+1
    if ((res[0]>res[1] and type_res == '(д)') or (res[0]<res[1] and type_res == '(г)')):
        return f'<span class = "ResultClassWin Result{num_res}" data-toggle="tooltip" title="{tooltip_str}"> В </span>'
    elif ((res[0]<res[1]  and type_res == '(д)') or (res[0]>res[1]  and type_res == '(г)')):
        return f'<span class = "ResultClassLose Result{num_res} data-toggle="tooltip" title="{tooltip_str}""> П </span>'
    else:
        return f'<span class = "ResultClassDraw Result{num_res} data-toggle="tooltip" title="{tooltip_str}""> Н </span>'

def  GetResultTotal(Team, TeamCheckHome, TeamCheckGuest, GoalHome, GoalGuest):
    total_type = 0
    # print(f"{Team}, {TeamCheckHome}, {TeamCheckGuest}, {GoalHome}, {GoalGuest}")
    if ((TeamCheckHome == Team) and (GoalHome > GoalGuest)):
        total_type = 1
    if ((TeamCheckGuest == Team) and (GoalHome < GoalGuest)):
        total_type = 1
    if ((TeamCheckHome == Team) and (GoalHome < GoalGuest)):
        total_type = 2
    if ((TeamCheckGuest == Team) and (GoalHome > GoalGuest)):
        total_type = 2
    return total_type