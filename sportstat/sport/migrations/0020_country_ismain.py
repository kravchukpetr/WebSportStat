# Generated by Django 3.0.5 on 2020-05-16 16:06

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('sport', '0019_auto_20200514_1343'),
    ]

    operations = [
        migrations.AddField(
            model_name='country',
            name='IsMain',
            field=models.IntegerField(null=True),
        ),
    ]