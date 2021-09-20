from django.db import models
from django.contrib.auth.models import AbstractUser, BaseUserManager

# Create your models here.


class User(AbstractUser):
    username = models.CharField(max_length=100, unique=True)
    firebase_token = models.CharField(max_length=200)
    USERNAME_FIELD = 'username'

    REQUIRED_FIELDS = ['firebase_token']

    def __str__(self):
        return self.username
