# Generated by Django 3.0.5 on 2020-05-29 16:09

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('sport', '0023_auto_20200529_1905'),
    ]

    operations = [
        migrations.AddField(
            model_name='predict',
            name='IDFactResult',
            field=models.IntegerField(default=1),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='result',
            name='IDFactResult',
            field=models.IntegerField(default=1),
            preserve_default=False,
        ),
    ]
