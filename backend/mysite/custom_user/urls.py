from .views import *
from django.urls import path
from rest_framework.routers import DefaultRouter

router = DefaultRouter()
# router.register(r'',, basename='user')
urlpatterns = router.urls

urlpatterns += [
    path('user_retrieve/', UserRetrieveView.as_view(), name="create_user"),
    path('user_create/', UserCreateView.as_view(), name="retrieve_user")
]
