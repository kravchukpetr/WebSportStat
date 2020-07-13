from django.conf.urls import url
from django.urls import path
from sport import views

urlpatterns = [
	url(r'^countries/$',views.countries,name='countries'),
	url(r'^leagues/$',views.leagues,name='leagues'),
	path('leagues/<int:country_id>/',views.leagues,name='leagues'),
	url(r'^teams/$',views.teams,name='teams'),
	path('teams/<int:country_id>/',views.teams,name='teams'),
	url(r'^sports/$',views.sports,name='sports'),
	url(r'^seasons/$',views.seasons,name='seasons'),
	path('results/<int:country_id>/<str:season_id>/',views.results,name='results'),
	path('results/<int:country_id>/<str:season_id>/<int:league_id>/',views.results,name='results'),
	#url(r'^standings/$',views.standings,name='standings'),
	path('standings/<int:country_id>/', views.standings, name='standings'),
	path('standings/<int:country_id>/<str:season_id>/', views.standings, name='standings'),
	path('standings/<int:country_id>/<str:season_id>/<int:league_id>/', views.standings, name='standings'),
	url(r'^country/(?P<pk>\d+)$', views.CountryDetailView.as_view(), name='country'),
	url(r'^predict/(?P<pk>\d+)$', views.PredictDetailView.as_view(), name='predict'),
	#url(r'^team/(?P<pk>\d+)$', views.TeamDetailView.as_view(), name='team'),
	url(r'^team/(?P<pk>\d+)$', views.team_detail, name='team'),	
	path('team/<int:pk>/<str:season_id>/', views.team_detail, name='team'),	
    #url(r'^$',views.countries,name='countries'),
    #url(r'^$',views.leagues,name='leagues'),
]
