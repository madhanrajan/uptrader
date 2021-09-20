# Generated by Django 3.1.6 on 2021-08-26 15:35

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Prediction',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('ticker', models.CharField(max_length=10)),
                ('date_created', models.DateTimeField(auto_now_add=True)),
                ('trigger_date', models.DateTimeField()),
                ('min_range', models.FloatField()),
                ('max_range', models.FloatField()),
                ('creator', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
                ('no_users', models.ManyToManyField(related_name='no_prediction', to=settings.AUTH_USER_MODEL)),
                ('yes_users', models.ManyToManyField(related_name='yes_prediction', to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]