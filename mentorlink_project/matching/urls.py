from django.urls import path
from . import views

urlpatterns = [
    path('dashboard/', views.dashboard, name='dashboard'),
    path('annonces/', views.annonces, name='annonces'),
    path('api/matches/', views.get_matches, name='get_matches'),
]