from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.conf import settings
from django.http import JsonResponse
from django.shortcuts import redirect, render
from django.utils import timezone
from datetime import timedelta
from .forms import AnnonceForm
from .models import Annonce, Match
from .match import generer_matches_pour_utilisateur
from accounts.models import UtilisateurCompetence
from django.db.models import Q
from messaging.models import Message


def _matches_a_recalculer(user):
    dernier_match = Match.objects.filter(
        Q(idMentor=user) | Q(idMentore=user)
    ).order_by('-date_modificationMatches').first()
    if not dernier_match:
        return True

    delai = timedelta(minutes=settings.MATCH_RECALCULATE_MINUTES)
    return dernier_match.date_modificationMatches < timezone.now() - delai


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
def annonces(request):
    if request.method == 'POST':
        form = AnnonceForm(request.POST)
        if form.is_valid():
            annonce = form.save(commit=False)
            annonce.idUtilisateur = request.user
            annonce.save()
            messages.success(request, "Annonce publiée avec succès.")
            return redirect('matching:annonces')
        messages.error(request, "Veuillez corriger les informations de l'annonce.")
    else:
        form = AnnonceForm()

    annonces_list = Annonce.objects.filter(statutAnnonce='active').select_related(
        'idUtilisateur', 'idUtilisateur__filiere'
    )
    return render(request, 'matching/annonces.html', {
        'annonces': annonces_list,
        'form': form,
    })


@login_required
def get_matches(request):
    user = request.user
    if request.GET.get('refresh') == '1' or _matches_a_recalculer(user):
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