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

---

## Base de données

Créer une base de données MySQL :

```sql
CREATE DATABASE mentorlink_db;
```

Depuis le dossier `mentorlink_project`, exécuter les migrations :

```bash
python manage.py migrate
```

### Génération de données fictives

Pour générer des données de démonstration (utilisateurs, compétences, disponibilités et matches), exécuter :

```bash
cd scripts
python populate_db.py
```

Le script crée automatiquement :

* Des mentors et mentorés de démonstration
* Des compétences techniques
* Des disponibilités
* Des correspondances mentor/mentoré
* Des profils prêts pour les tests

> **Remarque :** Exécutez ce script uniquement sur une base de développement afin d'éviter les doublons de données.

### Comptes de test

Après l'exécution de `populate_db.py`, plusieurs utilisateurs de démonstration sont créés afin de tester les fonctionnalités de l'application.

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
