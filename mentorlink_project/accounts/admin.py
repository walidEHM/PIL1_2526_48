from django.contrib import admin
from .models import Competence, Disponibilite, Filiere, Utilisateur, UtilisateurCompetence


@admin.register(Utilisateur)
class UtilisateurAdmin(admin.ModelAdmin):
    list_display = ('email', 'telephone', 'first_name', 'last_name', 'filiere', 'niveau', 'is_active')
    list_filter = ('filiere', 'niveau', 'is_active')
    search_fields = ('email', 'telephone', 'first_name', 'last_name')


@admin.register(Filiere)
class FiliereAdmin(admin.ModelAdmin):
    search_fields = ('nomFiliere',)


@admin.register(Competence)
class CompetenceAdmin(admin.ModelAdmin):
    search_fields = ('nomCompetence',)


@admin.register(UtilisateurCompetence)
class UtilisateurCompetenceAdmin(admin.ModelAdmin):
    list_display = ('idUtilisateur', 'idCompetence', 'typeUtilisateur_Competence')
    list_filter = ('typeUtilisateur_Competence',)
    search_fields = ('idUtilisateur__email', 'idCompetence__nomCompetence')


@admin.register(Disponibilite)
class DisponibiliteAdmin(admin.ModelAdmin):
    list_display = ('idUtilisateur', 'jourDisponibilite', 'heure_debutDisponibilite', 'heure_finDisponibilite', 'statutDisponibilite')
    list_filter = ('jourDisponibilite', 'statutDisponibilite')
    search_fields = ('idUtilisateur__email',)