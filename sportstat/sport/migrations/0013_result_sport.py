# Generated by Django 3.0.5 on 2020-04-27 20:11

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('sport', '0012_auto_20200427_2251'),
    ]

    operations = [
        migrations.AddField(
            model_name='result',
            name='Sport',
            field=models.CharField(max_length=30, null=True),
        ),
    ]