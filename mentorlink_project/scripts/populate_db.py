# scripts/populate_db.py
import os
import sys
import django

# Setup Django
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'mentorlink.settings')
django.setup()

from accounts.models import Utilisateur, Filiere, Competence, UtilisateurCompetence, Disponibilite
from matching.models import Match

# ─── 1. COMPÉTENCES ───────────────────────────────────────────────
print("Création des compétences...")
competences_noms = ['Python', 'SQL', 'Algorithmique', 'Mathématiques', 'Java', 'HTML/CSS', 'Machine Learning', 'C/C++']
competences = {}
for nom in competences_noms:
    c, _ = Competence.objects.get_or_create(nomCompetence=nom)
    competences[nom] = c
print(f"  ✓ {len(competences)} compétences")

# ─── 2. UTILISATEURS ──────────────────────────────────────────────
print("Création des utilisateurs...")

filieres = {f.nomFiliere: f for f in Filiere.objects.all()}

utilisateurs_data = [
    {
        'email': 'amina.sow@ifri.com',
        'password': 'Test1234!',
        'first_name': 'SOW',        # nomUtilisateur
        'last_name': 'Amina',       # prenomUtilisateur
        'telephone': '+22960000001',
        'filiere': 'GL',
        'niveau': 'L3',
        'bio': 'Passionnée par le développement logiciel.',
        'competences': ['Python', 'SQL', 'Algorithmique'],
        'lacunes': ['Machine Learning'],
        'disponibilites': [
            ('Lundi', '08:00', '12:00'),
            ('Mercredi', '14:00', '18:00'),
        ]
    },
    {
        'email': 'kofi.mensah@ifri.com',
        'password': 'Test1234!',
        'first_name': 'MENSAH',
        'last_name': 'Kofi',
        'telephone': '+22960000002',
        'filiere': 'IA',
        'niveau': 'L2',
        'bio': 'Intéressé par l\'IA et le machine learning.',
        'competences': ['Machine Learning', 'Python', 'Mathématiques'],
        'lacunes': ['SQL', 'Algorithmique'],
        'disponibilites': [
            ('Mardi', '10:00', '14:00'),
            ('Jeudi', '08:00', '12:00'),
        ]
    },
    {
        'email': 'fatou.diallo@ifri.com',
        'password': 'Test1234!',
        'first_name': 'DIALLO',
        'last_name': 'Fatou',
        'telephone': '+22960000003',
        'filiere': 'GL',
        'niveau': 'L2',
        'bio': 'Aime résoudre des problèmes complexes.',
        'competences': ['Java', 'Algorithmique', 'C/C++'],
        'lacunes': ['Python', 'SQL'],
        'disponibilites': [
            ('Lundi', '14:00', '18:00'),
            ('Vendredi', '08:00', '12:00'),
        ]
    },
    {
        'email': 'yves.kouassi@ifri.com',
        'password': 'Test1234!',
        'first_name': 'KOUASSI',
        'last_name': 'Yves',
        'telephone': '+22960000004',
        'filiere': 'SI',
        'niveau': 'L3',
        'bio': 'Spécialiste des systèmes d\'information.',
        'competences': ['SQL', 'HTML/CSS', 'Java'],
        'lacunes': ['Machine Learning', 'C/C++'],
        'disponibilites': [
            ('Mercredi', '08:00', '12:00'),
            ('Samedi', '10:00', '14:00'),
        ]
    },
    {
        'email': 'aisha.barry@ifri.com',
        'password': 'Test1234!',
        'first_name': 'BARRY',
        'last_name': 'Aisha',
        'telephone': '+22960000005',
        'filiere': 'IA',
        'niveau': 'L3',
        'bio': 'Passionnée par les mathématiques appliquées.',
        'competences': ['Mathématiques', 'Machine Learning', 'Python'],
        'lacunes': ['HTML/CSS', 'Java'],
        'disponibilites': [
            ('Jeudi', '14:00', '18:00'),
            ('Vendredi', '14:00', '18:00'),
        ]
    },
]

users_crees = []
for data in utilisateurs_data:
    if Utilisateur.objects.filter(email=data['email']).exists():
        print(f"  - {data['email']} existe déjà, ignoré")
        user = Utilisateur.objects.get(email=data['email'])
    else:
        user = Utilisateur.objects.create_user(
            email=data['email'],
            password=data['password'],
            first_name=data['first_name'],
            last_name=data['last_name'],
            telephone=data['telephone'],
            filiere=filieres.get(data['filiere']),
            niveau=data['niveau'],
            bio=data['bio'],
        )

        # Compétences
        for nom in data['competences']:
            if nom in competences:
                UtilisateurCompetence.objects.get_or_create(
                    idUtilisateur=user,
                    idCompetence=competences[nom],
                    defaults={'typeUtilisateur_Competence': 'competence'}
                )

        # Lacunes
        for nom in data['lacunes']:
            if nom in competences:
                UtilisateurCompetence.objects.get_or_create(
                    idUtilisateur=user,
                    idCompetence=competences[nom],
                    defaults={'typeUtilisateur_Competence': 'lacune'}
                )

        # Disponibilités
        for jour, debut, fin in data['disponibilites']:
            Disponibilite.objects.create(
                idUtilisateur=user,
                jourDisponibilite=jour,
                heure_debutDisponibilite=debut,
                heure_finDisponibilite=fin,
                statutDisponibilite='disponible',
                date_modificationDisponibilite='2026-06-09 00:00:00',
            )

        print(f"  ✓ {user.last_name} {user.first_name} créé")

    users_crees.append(user)

# ─── 3. MATCHES ───────────────────────────────────────────────────
print("Création des matches...")

# Récupère aussi l'utilisateur déjà existant (toi)
toi = Utilisateur.objects.get(email='elwalid2008@gmail.com')

matches_data = [
    # (mentor, mentoré, score, statut)
    (users_crees[0], toi,           88.5, 'en_attente'),   # Amina → toi
    (users_crees[1], toi,           75.0, 'en_attente'),   # Kofi → toi
    (users_crees[4], toi,           92.0, 'en_attente'),   # Aisha → toi
    (users_crees[2], users_crees[1], 80.0, 'en_attente'),  # Fatou → Kofi
    (users_crees[3], users_crees[2], 65.0, 'accepté'),     # Yves → Fatou
]

for mentor, mentore, score, statut in matches_data:
    match, created = Match.objects.get_or_create(
        idMentor=mentor,
        idMentore=mentore,
        defaults={
            'score_compatibiliteMatch': score,
            'statutMatches': statut,
            'date_modificationMatches': '2026-06-09 00:00:00',
        }
    )
    if created:
        print(f"  ✓ Match {mentor.last_name} → {mentore.last_name} ({score}%)")
    else:
        print(f"  - Match {mentor.last_name} → {mentore.last_name} existe déjà")

print("\n✅ Données fictives créées avec succès !")
print(f"   {Utilisateur.objects.count()} utilisateurs")
print(f"   {Competence.objects.count()} compétences")
print(f"   {Match.objects.count()} matches")
print(f"   {Disponibilite.objects.count()} disponibilités")