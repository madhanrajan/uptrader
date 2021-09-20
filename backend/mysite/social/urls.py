from django.db.models import base
from rest_framework.routers import DefaultRouter
from .views import *

router = DefaultRouter()
router.register(r'group', GroupViewSet, basename='group')
router.register(r'post', PostViewSet, basename='post')
router.register(r'paginated_post', PaginatedPostViewSet,
                basename="paginated_post")
router.register(r'user_paginated_post', UserPaginatedPostViewSet,
                basename="user_paginated_post")
router.register('personalised_post', PersonalisedPostViewSet,
                basename="personalised_post")
urlpatterns = router.urls
