from django.contrib import admin
from .models import Country, League, Team, Sport, Result, Standing, Season

# Register your models here.
admin.site.register(Country)
admin.site.register(League)
admin.site.register(Team)
admin.site.register(Sport)
admin.site.register(Result)
admin.site.register(Standing)
admin.site.register(Season)