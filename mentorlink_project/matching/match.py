from accounts.models import Utilisateur, UtilisateurCompetence, Disponibilite
from .models import Match
from django.utils import timezone


def preparer_competences(competences_mentor, competences_mentore):
    competences_communes = set(competences_mentor) & set(competences_mentore)
    commun = len(competences_communes)
    demandees = len(competences_mentore)
    return commun, demandees


def preparer_horaires(horaires_mentor, horaires_mentore):
    horaires_communs = set(horaires_mentor) & set(horaires_mentore)
    creneaux_communs = len(horaires_communs)
    creneaux_mentore = len(horaires_mentore)
    return creneaux_communs, creneaux_mentore


def calculer_score(mentor, mentore):
    # Compétences depuis la base
    competences_mentor = list(
        UtilisateurCompetence.objects.filter(
            idUtilisateur=mentor, typeUtilisateur_Competence='competence'
        ).values_list('idCompetence_id', flat=True)
    )
    lacunes_mentore = list(
        UtilisateurCompetence.objects.filter(
            idUtilisateur=mentore, typeUtilisateur_Competence='lacune'
        ).values_list('idCompetence_id', flat=True)
    )
    commun, demandees = preparer_competences(competences_mentor, lacunes_mentore)

    # Horaires depuis la base
    jours_mentor = list(
        Disponibilite.objects.filter(idUtilisateur=mentor)
        .values_list('jourDisponibilite', flat=True)
    )
    jours_mentore = list(
        Disponibilite.objects.filter(idUtilisateur=mentore)
        .values_list('jourDisponibilite', flat=True)
    )
    creneaux_communs, creneaux_mentore = preparer_horaires(jours_mentor, jours_mentore)

    # Filière
    meme_filiere = mentor.filiere_id == mentore.filiere_id

    # Niveau
    niveaux = ['L1', 'L2', 'L3', 'M1', 'M2']
    try:
        ecart = abs(niveaux.index(mentor.niveau) - niveaux.index(mentore.niveau))
    except (ValueError, TypeError):
        ecart = 2

    # Score final
    score_competences = (commun / demandees * 100) if demandees > 0 else 0
    score_horaires = (creneaux_communs / creneaux_mentore * 100) if creneaux_mentore > 0 else 0
    score_filiere = 100 if meme_filiere else 0
    score_niveau = 100 / (2 ** ecart)

    return round(
        score_competences * 0.60 +
        score_horaires    * 0.20 +
        score_filiere     * 0.10 +
        score_niveau      * 0.10,
        2
    )


def generer_matches_pour_utilisateur(utilisateur):
    SEUIL = 30.0
    matches_crees = 0

    autres = Utilisateur.objects.exclude(pk=utilisateur.pk)

    for autre in autres:
        # Cas 1 : utilisateur est mentoré, autre est mentor
        score1 = calculer_score(mentor=autre, mentore=utilisateur)
        if score1 >= SEUIL:
            match, created = Match.objects.get_or_create(
                idMentor=autre,
                idMentore=utilisateur,
                defaults={
                    'score_compatibiliteMatch': score1,
                    'statutMatches': 'en_attente',
                    'date_modificationMatches': timezone.now(),
                }
            )
            if not created:
                match.score_compatibiliteMatch = score1
                match.date_modificationMatches = timezone.now()
                match.save()
            else:
                matches_crees += 1

        # Cas 2 : utilisateur est mentor, autre est mentoré
        score2 = calculer_score(mentor=utilisateur, mentore=autre)
        if score2 >= SEUIL:
            match, created = Match.objects.get_or_create(
                idMentor=utilisateur,
                idMentore=autre,
                defaults={
                    'score_compatibiliteMatch': score2,
                    'statutMatches': 'en_attente',
                    'date_modificationMatches': timezone.now(),
                }
            )
            if not created:
                match.score_compatibiliteMatch = score2
                match.date_modificationMatches = timezone.now()
                match.save()
            else:
                matches_crees += 1

    return matches_crees







