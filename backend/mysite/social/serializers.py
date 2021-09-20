from django.db.models import fields
from rest_framework import serializers
from rest_framework import renderers
from .models import *


class GroupSerializer(serializers.ModelSerializer):
    class Meta:
        model = Group
        fields = ["title", "id"]


class PostSerializer(serializers.ModelSerializer):

    number_of_likes = serializers.SerializerMethodField()

    class Meta:
        model = Post
        fields = ["text", "group", "id", "number_of_likes"]

    def get_number_of_likes(self, object):
        return object.likes.count()
