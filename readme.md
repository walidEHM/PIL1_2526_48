# IFRI MentorLink

Plateforme web de mise en relation entre mentors et mentorés développée avec Django.

## Fonctionnalités

* Authentification des utilisateurs
* Gestion des profils
* Matching intelligent mentor / mentoré
* Messagerie en temps réel via WebSocket
* Tableau de bord personnalisé
* Gestion des compétences
* Interface responsive

---

## Prérequis

* Python 3.13 ou supérieur
* Git
* MySQL Server

---

## Installation

### 1. Cloner le projet

```bash
git clone https://github.com/walidEHM/PIL1_2526_48.git
cd PIL1_2526_48
```

### 2. Créer un environnement virtuel

```bash
python -m venv env
```

### 3. Activer l'environnement virtuel

#### Windows

```bash
env\Scripts\activate
```

#### Linux / macOS

```bash
source env/bin/activate
```

### 4. Installer les dépendances

```bash
pip install -r requirements.txt
```

### 5. Configurer l'environnement

Depuis `mentorlink_project`, copier le modèle d'environnement puis adapter les valeurs locales :

```bash
copy .env.example .env
```

Sous Linux / macOS :

```bash
cp .env.example .env
```

Variables importantes :

* `SECRET_KEY` : clé secrète Django à générer pour chaque environnement
* `DEBUG` : `True` en développement, `False` en production
* `ALLOWED_HOSTS` : domaines autorisés, séparés par des virgules
* `REDIS_URL` : recommandé en production pour les WebSockets

---

## Base de données

Une sauvegarde de la base de données est fournie dans :

```text
mentorlink_project/database/mentorlink_db.sql
```

### Importation de la base de données

Créer une base de données MySQL :

```sql
CREATE DATABASE mentorlink_db;
```

Puis importer le fichier SQL.

#### Avec MySQL

```bash
mysql -u root -p mentorlink_db < mentorlink_project/database/mentorlink_db.sql
```

#### Avec phpMyAdmin

1. Créer une base de données nommée `mentorlink_db`
2. Cliquer sur **Importer**
3. Sélectionner le fichier :

```text
mentorlink_project/database/mentorlink_db.sql
```

4. Cliquer sur **Exécuter**


Si vous préférez partir d'une base vide, vous pouvez exécuter :

```bash
python manage.py migrate
```
---

## Lancement du projet

Depuis le dossier contenant `manage.py` :

```bash
cd mentorlink_project
daphne mentorlink.asgi:application
```

Le site sera accessible sur :

```text
http://127.0.0.1:8000
```

> **Important :** Le projet utilise Django Channels pour la messagerie en temps réel. Il est recommandé de lancer l'application avec Daphne afin d'activer les WebSockets.
---
## Vérifications

```bash
python manage.py check
python manage.py test
```

Pour exécuter les tests sans dépendre de MySQL :

```bash
set DATABASE_URL=sqlite:///test_mentorlink.sqlite3
python manage.py test
```

---
### Comptes de test

Des données de démonstration sont déjà présentes dans la sauvegarde de base de données fournie (`mentorlink_db.sql`), permettant de tester directement les fonctionnalités de matching et de messagerie.
## Structure du projet

```text
PIL1_2526_48/
│
├── mentorlink_project/
│   ├── manage.py
│   ├── mentorlink/
│   ├── accounts/
│   ├── matching/
│   ├── messaging/
│   ├── database/
│   │   └── mentorlink_db.sql
│   └── ...
│
├── requirements.txt
└── README.md
```
