from channels.auth import AuthMiddlewareStack
from django.contrib.auth import get_user_model
from django.contrib.auth.models import AnonymousUser
from firebase_admin import auth
from channels.db import database_sync_to_async
from rest_framework import exceptions


User = get_user_model()


@database_sync_to_async
def get_user(uid):
    try:
        return User.objects.get(firebase_token=uid)
    except User.DoesNotExist:
        return AnonymousUser


class FirebaseAuthMiddleware:
    def __init__(self, app):
        self.app = app

    async def __call__(self, scope, receive, send):
        headers = dict(scope["headers"])
        token = str(headers[b'sec-websocket-protocol'].decode())

        try:
            decoded_token = auth.verify_id_token(token)
        except:
            raise exceptions.AuthenticationFailed(
                "No such user in firebase database")

        uid = decoded_token["uid"]
        user = await get_user(uid)
        scope["user"] = user

        return await self.app(scope, receive, send)


def FirebaseAuthMiddlewareStack(inner):
    return FirebaseAuthMiddleware(AuthMiddlewareStack(inner))
