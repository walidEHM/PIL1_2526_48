from django.shortcuts import render, redirect
from django.contrib.auth import login, logout, authenticate
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from .forms import InscriptionForm, ConnexionForm, ProfilForm
from .models import Utilisateur, Competence, UtilisateurCompetence


from .models import Utilisateur, Competence, UtilisateurCompetence, Disponibilite

def inscription(request):
    if request.method == 'POST':
        form = InscriptionForm(request.POST, request.FILES)
        if form.is_valid():
            user = form.save()

            # Compétences : noms en texte libre → get_or_create
            for nom in request.POST.getlist('competences[]'):
                nom = nom.strip()
                if nom:
                    comp, _ = Competence.objects.get_or_create(nomCompetence=nom)
                    UtilisateurCompetence.objects.create(
                        idUtilisateur=user,
                        idCompetence=comp,
                        typeUtilisateur_Competence='competence'
                    )
            for nom in request.POST.getlist('lacunes[]'):
                nom = nom.strip()
                if nom:
                    comp, _ = Competence.objects.get_or_create(nomCompetence=nom)
                    UtilisateurCompetence.objects.create(
                        idUtilisateur=user,
                        idCompetence=comp,
                        typeUtilisateur_Competence='lacune'
                    )

            # Disponibilités
            jours = request.POST.getlist('jours[]')
            heure_debut = request.POST.get('heure_debut')
            heure_fin = request.POST.get('heure_fin')
            if jours and heure_debut and heure_fin:
                for jour in jours:
                    Disponibilite.objects.create(
                        idUtilisateur=user,
                        jourDisponibilite=jour,
                        heure_debutDisponibilite=heure_debut,
                        heure_finDisponibilite=heure_fin,
                        statutDisponibilite='disponible'
                    )

            messages.success(request, 'Compte créé. Vous pouvez vous connecter.')
            return redirect('accounts:connexion')
    else:
        form = InscriptionForm()
    return render(request, 'accounts/register.html', {'form': form})


def connexion(request):
    if request.user.is_authenticated:
        return redirect('accounts:dashboard')
    if request.method == 'POST':
        form = ConnexionForm(request.POST)
        if form.is_valid():
            login_value = form.cleaned_data['identifiant']
            password = form.cleaned_data['mot_de_passe']
            user = None
            try:
                user_obj = Utilisateur.objects.get(email=login_value)
                user = authenticate(request, username=user_obj.email, password=password)
            except Utilisateur.DoesNotExist:
                try:
                    user_obj = Utilisateur.objects.get(telephone=login_value)
                    user = authenticate(request, username=user_obj.email, password=password)
                except Utilisateur.DoesNotExist:
                    user = None
            if user:
                login(request, user)
                return redirect('accounts:dashboard')
            messages.error(request, 'Identifiants incorrects.')
    else:
        form = ConnexionForm()
    return render(request, 'accounts/login.html', {'form': form})


def deconnexion(request):
    logout(request)
    return redirect('accounts:connexion')


@login_required
def profil(request):
    if request.method == 'POST':
        form = ProfilForm(
            request.POST, request.FILES, instance=request.user
        )
        if form.is_valid():
            form.save()
            messages.success(request, 'Profil mis à jour.')
            return redirect('accounts:profil')
    else:
        form = ProfilForm(instance=request.user)
    competences = UtilisateurCompetence.objects.filter(
        idUtilisateur=request.user,
        typeUtilisateur_Competence='competence'
    )
    lacunes = UtilisateurCompetence.objects.filter(
        idUtilisateur=request.user,
        typeUtilisateur_Competence='lacune'
    )
    return render(request, 'accounts/profile.html', {
        'form': form,
        'competences': competences,
        'lacunes': lacunes
    })


@login_required
def dashboard(request):
    return redirect('matching:dashboard')