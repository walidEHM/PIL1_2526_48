from accounts.models import Utilisateur, UtilisateurCompetence, Disponibilite
from .models import Match
from django.utils import timezone

SEUIL_MATCH = 30.0
NIVEAUX = ['L1', 'L2', 'L3', 'M1', 'M2']


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


def _calculer_score_depuis_cache(mentor, mentore, competences, lacunes, disponibilites):
    commun, demandees = preparer_competences(
        competences.get(mentor.pk, set()),
        lacunes.get(mentore.pk, set())
    )
    creneaux_communs, creneaux_mentore = preparer_horaires(
        disponibilites.get(mentor.pk, set()),
        disponibilites.get(mentore.pk, set())
    )

    try:
        ecart = abs(NIVEAUX.index(mentor.niveau) - NIVEAUX.index(mentore.niveau))
    except (ValueError, TypeError):
        ecart = 2

    score_competences = (commun / demandees * 100) if demandees > 0 else 0
    score_horaires = (creneaux_communs / creneaux_mentore * 100) if creneaux_mentore > 0 else 0
    score_filiere = 100 if mentor.filiere_id == mentore.filiere_id else 0
    score_niveau = 100 / (2 ** ecart)

    return round(
        score_competences * 0.60 +
        score_horaires * 0.20 +
        score_filiere * 0.10 +
        score_niveau * 0.10,
        2
    )


def _indexer_donnees_utilisateurs(utilisateurs):
    ids = [utilisateur.pk for utilisateur in utilisateurs]
    competences = {}
    lacunes = {}
    disponibilites = {}

    for utilisateur_id, competence_id, type_competence in UtilisateurCompetence.objects.filter(
        idUtilisateur_id__in=ids
    ).values_list('idUtilisateur_id', 'idCompetence_id', 'typeUtilisateur_Competence'):
        cible = competences if type_competence == 'competence' else lacunes
        cible.setdefault(utilisateur_id, set()).add(competence_id)

    for utilisateur_id, jour in Disponibilite.objects.filter(
        idUtilisateur_id__in=ids
    ).values_list('idUtilisateur_id', 'jourDisponibilite'):
        disponibilites.setdefault(utilisateur_id, set()).add(jour)

    return competences, lacunes, disponibilites


def _enregistrer_match(mentor, mentore, score, matches_existants, maintenant):
    cle = (mentor.pk, mentore.pk)
    match = matches_existants.get(cle)

    if match:
        match.score_compatibiliteMatch = score
        match.statutMatches = 'en_attente'
        match.date_modificationMatches = maintenant
        match.save(update_fields=[
            'score_compatibiliteMatch',
            'statutMatches',
            'date_modificationMatches',
        ])
        return 0

    matches_existants[cle] = Match.objects.create(
        idMentor=mentor,
        idMentore=mentore,
        score_compatibiliteMatch=score,
        statutMatches='en_attente',
        date_modificationMatches=maintenant,
    )
    return 1


def generer_matches_pour_utilisateur(utilisateur):
    matches_crees = 0
    maintenant = timezone.now()

    autres = list(Utilisateur.objects.exclude(pk=utilisateur.pk).select_related('filiere'))
    utilisateurs = [utilisateur, *autres]
    competences, lacunes, disponibilites = _indexer_donnees_utilisateurs(utilisateurs)
    matches_existants = {
        (match.idMentor_id, match.idMentore_id): match
        for match in Match.objects.filter(idMentor__in=utilisateurs, idMentore__in=utilisateurs)
    }

    for autre in autres:
        score1 = _calculer_score_depuis_cache(autre, utilisateur, competences, lacunes, disponibilites)
        if score1 >= SEUIL_MATCH:
            matches_crees += _enregistrer_match(
                mentor=autre,
                mentore=utilisateur,
                score=score1,
                matches_existants=matches_existants,
                maintenant=maintenant,
            )

        score2 = _calculer_score_depuis_cache(utilisateur, autre, competences, lacunes, disponibilites)
        if score2 >= SEUIL_MATCH:
            matches_crees += _enregistrer_match(
                mentor=utilisateur,
                mentore=autre,
                score=score2,
                matches_existants=matches_existants,
                maintenant=maintenant,
            )

    return matches_crees
