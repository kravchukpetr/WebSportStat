# Generated by Django 2.2.5 on 2020-04-05 15:03

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('sport', '0005_auto_20200405_1800'),
    ]

    operations = [
        migrations.AlterField(
            model_name='result',
            name='IDLeague',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='results_league', to='sport.League'),
        ),
    ]
