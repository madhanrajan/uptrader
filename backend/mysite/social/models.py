from django.db import models
from django.contrib.auth import get_user_model

User = get_user_model()


class Group(models.Model):
    creator = models.ForeignKey(
        User, on_delete=models.CASCADE, related_name="group_creator")
    date_created = models.DateTimeField(auto_now_add=True)
    followers = models.ManyToManyField(
        User, related_name="group_followers")
    title = models.CharField(max_length=100)

    def __str__(self):
        return self.title


class Post(models.Model):
    likes = models.ManyToManyField(User, related_name="post_likes")
    text = models.TextField()
    date_created = models.DateTimeField(auto_now_add=True)
    creator = models.ForeignKey(
        User, on_delete=models.CASCADE, related_name="post_creator")
    group = models.ForeignKey(
        Group, on_delete=models.CASCADE, related_name="group")

    def __str__(self):
        return self.text
