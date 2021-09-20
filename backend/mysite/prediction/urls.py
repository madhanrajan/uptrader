from rest_framework.routers import DefaultRouter
from .views import *

router = DefaultRouter()

router.register(r"", PredictionViewSet, "prediction")
urlpatterns = router.urls
