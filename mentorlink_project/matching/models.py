from django.db import models
from accounts.models import Utilisateur


class Match(models.Model):
    idMatches = models.AutoField(primary_key=True)
    idMentor = models.ForeignKey(
        Utilisateur, on_delete=models.CASCADE,
        db_column='idMentor', related_name='matches_mentor'
    )
    idMentore = models.ForeignKey(
        Utilisateur, on_delete=models.CASCADE,
        db_column='idMentore', related_name='matches_mentore'
    )
    score_compatibiliteMatch = models.FloatField()
    statutMatches = models.CharField(max_length=255)
    date_creationMatches = models.DateTimeField(auto_now_add=True)
    date_modificationMatches = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = 'matches'  # pointe vers la table existante en base

    def __str__(self):
        return f"Match {self.idMatches} - {self.statutMatches}"