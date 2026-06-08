from django.urls import path
from . import views

app_name = 'messaging'

urlpatterns = [
    path('', views.liste_conversations, name='liste_conversations'),
    path('<int:conversation_id>/', views.detail_conversation, name='detail_conversation'),
    path('demarrer/<int:user_id>/', views.demarrer_conversation, name='demarrer_conversation'),
    path('<int:conversation_id>/envoyer/', views.envoyer_message, name='envoyer_message'),
    path('non-lus/', views.messages_non_lus, name='messages_non_lus'),
]