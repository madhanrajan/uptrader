from rest_framework import permissions
from firebase_admin import auth
from django.contrib.auth import get_user_model

User = get_user_model()


class IsFirebaseAuthenticated(permissions.BasePermission):

    def has_permission(self, request, view):
        token = request.headers.get("token")

        if not token:
            return False

        decoded_token = auth.verify_id_token(token)

        uid = decoded_token["uid"]

        return User.objects.filter(firebase_token=uid).exists()
