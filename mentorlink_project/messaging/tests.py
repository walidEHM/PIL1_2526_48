from django.test import TestCase
from django.urls import reverse

from accounts.models import Utilisateur
from matching.models import Annonce, Match
from .models import Conversation


class ConversationTests(TestCase):
    def setUp(self):
        self.user = Utilisateur.objects.create_user(
            email='user@ifri.test',
            password='Motdepasse123!',
            telephone='+22963000001',
        )
        self.other = Utilisateur.objects.create_user(
            email='other@ifri.test',
            password='Motdepasse123!',
            telephone='+22963000002',
        )
        self.client.force_login(self.user)

    def test_demarrage_conversation_refuse_sans_match_ni_annonce(self):
        response = self.client.get(reverse('messaging:demarrer_conversation', args=[self.other.pk]))

        self.assertEqual(response.status_code, 302)
        self.assertFalse(Conversation.objects.exists())

    def test_demarrage_conversation_depuis_match_existant(self):
        Match.objects.create(
            idMentor=self.other,
            idMentore=self.user,
            score_compatibiliteMatch=82,
            statutMatches='en_attente',
        )

        response = self.client.get(reverse('messaging:demarrer_conversation', args=[self.other.pk]))

        self.assertEqual(response.status_code, 302)
        self.assertTrue(Conversation.objects.exists())

    def test_demarrage_conversation_depuis_annonce_active(self):
        Annonce.objects.create(
            idUtilisateur=self.other,
            typeAnnonce='offre',
            matiereAnnonce='SQL',
            descriptionAnnonce='Session SQL disponible.',
            formatAnnonce='en_ligne',
            joursAnnonce='Lun',
            statutAnnonce='active',
        )

        response = self.client.get(reverse('messaging:demarrer_conversation', args=[self.other.pk]))

        self.assertEqual(response.status_code, 302)
        self.assertTrue(Conversation.objects.exists())
