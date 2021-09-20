from django.contrib.auth import get_user_model
from firebase_admin import auth
from rest_framework import authentication
from rest_framework import exceptions


User = get_user_model()


class FirebaseAuthentication(authentication.BaseAuthentication):
    def authenticate(self, request):
        token = request.headers.get("token")

        if not token:
            return None

        decoded_token = auth.verify_id_token(token)
        uid = decoded_token["uid"]
        print("uid")

        try:
            user = User.objects.get(firebase_token=uid)
        except User.DoesNotExist:
            raise exceptions.AuthenticationFailed(
                "No such user in django database")

        return (user, None)
