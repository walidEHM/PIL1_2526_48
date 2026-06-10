import os
import django
from django.conf import settings
from django.test import Client

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'mentorlink.settings')
django.setup()
settings.ALLOWED_HOSTS.append('testserver')
client = Client()
urls = [
    '/',
    '/inscription/',
    '/connexion/',
    '/deconnexion/',
    '/profil/',
    '/matching/dashboard/',
    '/matching/annonces/',
    '/messaging/',
    '/messaging/non-lus/',
]
for url in urls:
    response = client.get(url)
    redirect = response.url if response.status_code in (301, 302) else ''
    print(f'{url} {response.status_code} {redirect}')
