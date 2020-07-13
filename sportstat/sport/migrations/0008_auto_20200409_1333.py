# Generated by Django 2.2.5 on 2020-04-09 10:33

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('sport', '0007_auto_20200406_2157'),
    ]

    operations = [
        migrations.AddField(
            model_name='standing',
            name='CountDraw',
            field=models.IntegerField(null=True),
        ),
        migrations.AddField(
            model_name='standing',
            name='CountDrawGuest',
            field=models.IntegerField(null=True),
        ),
        migrations.AddField(
            model_name='standing',
            name='CountDrawHome',
            field=models.IntegerField(null=True),
        ),
        migrations.AddField(
            model_name='standing',
            name='CountGames',
            field=models.IntegerField(null=True),
        ),
        migrations.AddField(
            model_name='standing',
            name='CountGamesGuest',
            field=models.IntegerField(null=True),
        ),
        migrations.AddField(
            model_name='standing',
            name='CountGamesHome',
            field=models.IntegerField(null=True),
        ),
        migrations.AddField(
            model_name='standing',
            name='CountLose',
            field=models.IntegerField(null=True),
        ),
        migrations.AddField(
            model_name='standing',
            name='CountLoseGuest',
            field=models.IntegerField(null=True),
        ),
        migrations.AddField(
            model_name='standing',
            name='CountLoseHome',
            field=models.IntegerField(null=True),
        ),
        migrations.AddField(
            model_name='standing',
            name='CountPoint',
            field=models.IntegerField(null=True),
        ),
        migrations.AddField(
            model_name='standing',
            name='CountPointGuest',
            field=models.IntegerField(null=True),
        ),
        migrations.AddField(
            model_name='standing',
            name='CountPointHome',
            field=models.IntegerField(null=True),
        ),
        migrations.AddField(
            model_name='standing',
            name='CountWin',
            field=models.IntegerField(null=True),
        ),
        migrations.AddField(
            model_name='standing',
            name='CountWinGuest',
            field=models.IntegerField(null=True),
        ),
        migrations.AddField(
            model_name='standing',
            name='CountWinHome',
            field=models.IntegerField(null=True),
        ),
        migrations.AddField(
            model_name='standing',
            name='GoalDifference',
            field=models.CharField(max_length=30, null=True),
        ),
        migrations.AddField(
            model_name='standing',
            name='GoalDifferenceGuest',
            field=models.CharField(max_length=30, null=True),
        ),
        migrations.AddField(
            model_name='standing',
            name='GoalDifferenceHome',
            field=models.CharField(max_length=30, null=True),
        ),
        migrations.AddField(
            model_name='standing',
            name='GoalLose',
            field=models.IntegerField(null=True),
        ),
        migrations.AddField(
            model_name='standing',
            name='GoalLoseGuest',
            field=models.IntegerField(null=True),
        ),
        migrations.AddField(
            model_name='standing',
            name='GoalLoseHome',
            field=models.IntegerField(null=True),
        ),
        migrations.AddField(
            model_name='standing',
            name='GoalWin',
            field=models.IntegerField(null=True),
        ),
        migrations.AddField(
            model_name='standing',
            name='GoalWinGuest',
            field=models.IntegerField(null=True),
        ),
        migrations.AddField(
            model_name='standing',
            name='GoalWinHome',
            field=models.IntegerField(null=True),
        ),
        migrations.AddField(
            model_name='standing',
            name='IDCountry',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='stands_country', to='sport.Country'),
        ),
        migrations.AddField(
            model_name='standing',
            name='IDLeague',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='stands_league', to='sport.League'),
        ),
        migrations.AddField(
            model_name='standing',
            name='IDSeason',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='stands_season', to='sport.Season'),
        ),
        migrations.AddField(
            model_name='standing',
            name='IDSport',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='stands_sport', to='sport.Sport'),
        ),
        migrations.AddField(
            model_name='standing',
            name='LastTours',
            field=models.IntegerField(null=True),
        ),
        migrations.AddField(
            model_name='standing',
            name='Position',
            field=models.IntegerField(null=True),
        ),
        migrations.AddField(
            model_name='standing',
            name='Team',
            field=models.CharField(max_length=30, null=True),
        ),
        migrations.AddField(
            model_name='standing',
            name='TourDate',
            field=models.DateTimeField(null=True),
        ),
        migrations.AddField(
            model_name='standing',
            name='TourNumber',
            field=models.IntegerField(null=True),
        ),
        migrations.AddField(
            model_name='standing',
            name='TypeTour',
            field=models.CharField(max_length=30, null=True),
        ),
        migrations.AlterField(
            model_name='standing',
            name='Country',
            field=models.CharField(max_length=30, null=True),
        ),
        migrations.AlterField(
            model_name='standing',
            name='League',
            field=models.CharField(max_length=30, null=True),
        ),
        migrations.AlterField(
            model_name='standing',
            name='Season',
            field=models.CharField(max_length=30, null=True),
        ),
    ]
