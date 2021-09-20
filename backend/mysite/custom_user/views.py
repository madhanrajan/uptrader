from django.contrib.auth import get_user_model
from .serializers import *
from rest_framework.response import Response
from firebase_admin import credentials
from firebase_admin import auth
import firebase_admin
from pathlib import Path
from rest_framework import generics
from rest_framework import mixins


BASE_DIR = Path(__file__).resolve().parent.parent
cred = credentials.Certificate(BASE_DIR.joinpath("credentials.json"))
firebase_admin.initialize_app(cred)

User = get_user_model()


class UserCreateView(generics.GenericAPIView, mixins.CreateModelMixin):

    queryset = User.objects.all()
    serializer_class = UserCreateSerializer

    def post(self, request):
        user_data = UserCreateSerializer(data=request.data)
        if user_data.is_valid():
            print(user_data.data["firebase_token"])
            user_uid = user_data.data["firebase_token"]
            username = user_data.data["username"]
            user_record = auth.get_user(uid=user_uid)
            User.objects.create(firebase_token=user_uid, username=username, first_name=user_record.display_name,
                                email=user_record.email)

        return Response({'get': user_record.email})


class UserRetrieveView(generics.GenericAPIView, mixins.RetrieveModelMixin):

    queryset = User.objects.all()
    serializer_class = UserRetrieveSerializer

    def post(self, request):
        user_data = UserRetrieveSerializer(data=request.data)
        if user_data.is_valid():
            print(user_data.data["firebase_token"])
            user_uid = user_data.data["firebase_token"]
            user = User.objects.filter(firebase_token=user_uid)
            if (user.exists()):
                return Response({"error": "", "username": user[0].username})
            else:
                return Response({"error": "No users"})

        return Response({'error': "Serializer invalid"})
