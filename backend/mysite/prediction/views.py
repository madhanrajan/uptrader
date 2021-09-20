from rest_framework import viewsets
from .models import Prediction
from .serializers import PredictionSerializer
from custom_user.permissions import IsFirebaseAuthenticated

# Create your views here.


class PredictionViewSet(viewsets.ModelViewSet):
    queryset = Prediction.objects.all()
    serializer_class = PredictionSerializer
    # permission_classes = [IsFirebaseAuthenticated]
