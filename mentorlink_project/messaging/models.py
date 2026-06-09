from django.db import models
from accounts.models import Utilisateur

class Conversation(models.Model):
    idConversation = models.AutoField(primary_key=True)
    # Utilisation d'une chaîne pour éviter l'import direct
    idMatches = models.ForeignKey(
        'matching.Match', on_delete=models.CASCADE, db_column='idMatches'
    )
    date_creationConversation = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'conversation'

class Message(models.Model):
    idMessage = models.AutoField(primary_key=True)
    idConversation = models.ForeignKey(
        Conversation, on_delete=models.CASCADE, db_column='idConversation'
    )
    id_expediteurMessage = models.ForeignKey(
        Utilisateur, on_delete=models.CASCADE, db_column='id_expediteurMessage'
    )
    contenuMessage = models.TextField()
    luMessage = models.BooleanField(default=False)
    date_creationMessage = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'message'