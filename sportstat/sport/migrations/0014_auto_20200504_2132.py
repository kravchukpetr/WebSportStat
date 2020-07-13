# Generated by Django 3.0.5 on 2020-05-04 18:32

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('sport', '0013_result_sport'),
    ]

    operations = [
        migrations.AddField(
            model_name='team',
            name='Coach',
            field=models.CharField(max_length=100, null=True),
        ),
        migrations.AddField(
            model_name='team',
            name='Color',
            field=models.CharField(max_length=100, null=True),
        ),
        migrations.AddField(
            model_name='team',
            name='ImgBig',
            field=models.ImageField(null=True, upload_to='media/'),
        ),
        migrations.AddField(
            model_name='team',
            name='Stadium',
            field=models.CharField(max_length=100, null=True),
        ),
        migrations.AddField(
            model_name='team',
            name='StadiumNumber',
            field=models.CharField(max_length=100, null=True),
        ),
        migrations.AddField(
            model_name='team',
            name='YearFound',
            field=models.IntegerField(null=True),
        ),
    ]