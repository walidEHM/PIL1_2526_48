from django.contrib import admin

from .models import Annonce, Match


@admin.register(Annonce)
class AnnonceAdmin(admin.ModelAdmin):
    list_display = ('matiereAnnonce', 'typeAnnonce', 'formatAnnonce', 'statutAnnonce', 'idUtilisateur', 'date_creationAnnonce')
    list_filter = ('typeAnnonce', 'formatAnnonce', 'statutAnnonce')
    search_fields = ('matiereAnnonce', 'descriptionAnnonce', 'idUtilisateur__email')


@admin.register(Match)
class MatchAdmin(admin.ModelAdmin):
    list_display = ('idMentor', 'idMentore', 'score_compatibiliteMatch', 'statutMatches', 'date_modificationMatches')
    list_filter = ('statutMatches',)
    search_fields = ('idMentor__email', 'idMentore__email')
