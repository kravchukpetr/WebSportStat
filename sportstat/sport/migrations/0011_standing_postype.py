# Generated by Django 3.0.5 on 2020-04-26 11:51

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('sport', '0010_league_isprimary'),
    ]

    operations = [
        migrations.AddField(
            model_name='standing',
            name='PosType',
            field=models.IntegerField(null=True),
        ),
    ]
