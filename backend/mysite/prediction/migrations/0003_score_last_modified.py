# Generated by Django 3.1.6 on 2021-08-26 15:41

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('prediction', '0002_score'),
    ]

    operations = [
        migrations.AddField(
            model_name='score',
            name='last_modified',
            field=models.DateTimeField(auto_now=True),
        ),
    ]
