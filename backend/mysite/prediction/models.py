from django.db import models
from django.contrib.auth import get_user_model
# Create your models here.

User = get_user_model()


class Prediction(models.Model):
    ticker = models.CharField(max_length=10)
    date_created = models.DateTimeField(auto_now_add=True)
    trigger_date = models.DateTimeField()
    creator = models.ForeignKey(User, on_delete=models.CASCADE)
    yes_users = models.ManyToManyField(User, related_name="yes_predictions")
    no_users = models.ManyToManyField(User, related_name="no_predictions")
    value = models.FloatField()


class Score(models.Model):
    score = models.IntegerField(default=0)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    last_modified = models.DateTimeField(auto_now=True)
