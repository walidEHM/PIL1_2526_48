from datetime import time

from django.test import TestCase
from django.urls import reverse

from accounts.models import Competence, Disponibilite, Filiere, Utilisateur, UtilisateurCompetence
from .match import calculer_score, generer_matches_pour_utilisateur
from .models import Annonce, Match


class MatchingTests(TestCase):
    def setUp(self):
        self.filiere = Filiere.objects.create(nomFiliere='GL')
        self.python = Competence.objects.create(nomCompetence='Python')
        self.sql = Competence.objects.create(nomCompetence='SQL')
        self.mentor = Utilisateur.objects.create_user(
            email='mentor@ifri.test',
            password='Motdepasse123!',
            telephone='+22961000001',
            filiere=self.filiere,
            niveau='L3',
        )
        self.mentore = Utilisateur.objects.create_user(
            email='mentore@ifri.test',
            password='Motdepasse123!',
            telephone='+22961000002',
            filiere=self.filiere,
            niveau='L2',
        )
        UtilisateurCompetence.objects.create(
            idUtilisateur=self.mentor,
            idCompetence=self.python,
            typeUtilisateur_Competence='competence',
        )
        UtilisateurCompetence.objects.create(
            idUtilisateur=self.mentor,
            idCompetence=self.sql,
            typeUtilisateur_Competence='competence',
        )
        UtilisateurCompetence.objects.create(
            idUtilisateur=self.mentore,
            idCompetence=self.python,
            typeUtilisateur_Competence='lacune',
        )
        for user in (self.mentor, self.mentore):
            Disponibilite.objects.create(
                idUtilisateur=user,
                jourDisponibilite='Lundi',
                heure_debutDisponibilite=time(8, 0),
                heure_finDisponibilite=time(12, 0),
                statutDisponibilite='disponible',
            )

    def test_score_matching_est_positif_pour_profil_compatible(self):
        score = calculer_score(self.mentor, self.mentore)

        self.assertGreaterEqual(score, 70)

    def test_generation_matches_cree_un_match_attendu(self):
        generer_matches_pour_utilisateur(self.mentore)

        self.assertTrue(Match.objects.filter(idMentor=self.mentor, idMentore=self.mentore).exists())

    def test_publication_annonce_persiste_en_base(self):
        self.client.force_login(self.mentor)

        response = self.client.post(reverse('matching:annonces'), {
            'typeAnnonce': 'offre',
            'matiereAnnonce': 'Programmation Python',
            'formatAnnonce': 'en_ligne',
            'descriptionAnnonce': 'Aide sur les bases Python.',
            'jours': ['Lun', 'Mer'],
        })

        self.assertRedirects(response, reverse('matching:annonces'))
        self.assertTrue(Annonce.objects.filter(matiereAnnonce='Programmation Python').exists())
