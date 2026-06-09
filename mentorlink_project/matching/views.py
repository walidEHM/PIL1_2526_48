from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.http import JsonResponse
from .models import Match
from .match import generer_matches_pour_utilisateur
from accounts.models import UtilisateurCompetence
from django.db.models import Q
from messaging.models import Message

@login_required
def dashboard(request):
    user = request.user

    competences = UtilisateurCompetence.objects.filter(
        idUtilisateur=user
    ).select_related('idCompetence')
    
    messages_non_lus = Message.objects.filter(
        Q(idConversation__idMatches__idMentor=request.user) |
        Q(idConversation__idMatches__idMentore=request.user),
        luMessage=False
    ).exclude(id_expediteurMessage=request.user).count()

    context = {
        'user': user,
        'competences': competences,
        'messages_non_lus': messages_non_lus,
    }
    return render(request, 'dashboard.html', context)


@login_required
def get_matches(request):
    user = request.user
    generer_matches_pour_utilisateur(user)

    matches = Match.objects.filter(
        Q(idMentor=user) | Q(idMentore=user),
        statutMatches='en_attente'
    ).order_by('-score_compatibiliteMatch').select_related(
        'idMentor', 'idMentor__filiere',
        'idMentore', 'idMentore__filiere'
    )

    data = []
    seen_pairs = set()            # <-- pour éviter les doublons

    for match in matches:
        # Déterminer l'autre utilisateur
        if match.idMentor == user:
            autre = match.idMentore
        else:
            autre = match.idMentor

        # Créer une clé unique pour la paire (peu importe l'ordre)
        pair = tuple(sorted([user.pk, autre.pk]))
        if pair in seen_pairs:
            continue                  # on ignore le doublon
        seen_pairs.add(pair)

        data.append({
            'score': round(match.score_compatibiliteMatch),
            'prenom': autre.last_name,
            'nom': autre.first_name,
            'filiere': autre.filiere.nomFiliere if autre.filiere else '',
            'niveau': autre.niveau or '',
            'initiale': (autre.last_name[0] if autre.last_name else '?').upper(),
            'photo': autre.photo.url if autre.photo else None,
            'user_id': autre.pk,
        })

    return JsonResponse({'matches': data, 'count': len(data)})