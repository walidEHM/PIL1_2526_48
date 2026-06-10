from django.db import models
from accounts.models import Utilisateur


class Annonce(models.Model):
    TYPE_CHOICES = (
        ('offre', 'Offre'),
        ('demande', 'Demande'),
    )
    FORMAT_CHOICES = (
        ('presentiel', 'Présentiel'),
        ('en_ligne', 'En ligne'),
        ('hybride', 'Hybride'),
    )
    STATUT_CHOICES = (
        ('active', 'Active'),
        ('archivee', 'Archivée'),
    )

    idAnnonce = models.AutoField(primary_key=True)
    idUtilisateur = models.ForeignKey(
        Utilisateur, on_delete=models.CASCADE,
        db_column='idUtilisateur', related_name='annonces'
    )
    typeAnnonce = models.CharField(max_length=20, choices=TYPE_CHOICES)
    matiereAnnonce = models.CharField(max_length=255)
    descriptionAnnonce = models.TextField()
    formatAnnonce = models.CharField(max_length=30, choices=FORMAT_CHOICES)
    joursAnnonce = models.CharField(max_length=255, blank=True)
    statutAnnonce = models.CharField(max_length=20, choices=STATUT_CHOICES, default='active')
    date_creationAnnonce = models.DateTimeField(auto_now_add=True)
    date_modificationAnnonce = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = 'annonce'
        ordering = ['-date_creationAnnonce']

    def __str__(self):
        return f"{self.get_typeAnnonce_display()} - {self.matiereAnnonce}"


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
        unique_together = ('idMentor', 'idMentore')
        indexes = [
            models.Index(fields=['idMentor', 'idMentore']),
            models.Index(fields=['statutMatches', '-score_compatibiliteMatch']),
        ]

    def __str__(self):
        return f"Match {self.idMatches} - {self.statutMatches}"