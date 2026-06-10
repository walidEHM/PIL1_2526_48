from django.test import TestCase
from django.urls import reverse

from .models import Utilisateur


class AuthentificationTests(TestCase):
    def test_connexion_par_email(self):
        Utilisateur.objects.create_user(
            email='mentor@ifri.test',
            password='Motdepasse123!',
            telephone='+22961000000',
        )

        response = self.client.post(reverse('accounts:connexion'), {
            'identifiant': 'mentor@ifri.test',
            'mot_de_passe': 'Motdepasse123!',
        })

        self.assertEqual(response.status_code, 302)
        self.assertTrue(response.wsgi_request.user.is_authenticated)

    def test_connexion_par_telephone(self):
        Utilisateur.objects.create_user(
            email='mentore@ifri.test',
            password='Motdepasse123!',
            telephone='+22962000000',
        )

        response = self.client.post(reverse('accounts:connexion'), {
            'identifiant': '+22962000000',
            'mot_de_passe': 'Motdepasse123!',
        })

        self.assertEqual(response.status_code, 302)
        self.assertTrue(response.wsgi_request.user.is_authenticated)
