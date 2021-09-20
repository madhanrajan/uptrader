from rest_framework import serializers
from django.contrib.auth import get_user_model

user_model = get_user_model()


class UserCreateSerializer(serializers.ModelSerializer):

    class Meta:
        model = user_model
        fields = ['firebase_token', 'username']


class UserRetrieveSerializer(serializers.ModelSerializer):

    class Meta:
        model = user_model
        fields = ['firebase_token']
