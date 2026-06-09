from django import forms
from django.contrib.auth.forms import UserCreationForm
from .models import Utilisateur, Competence, Disponibilite, Filiere


class InscriptionForm(UserCreationForm):
    telephone = forms.CharField(max_length=255)
    filiere = forms.ModelChoiceField(
        queryset=Filiere.objects.none(),
        required=False,
        empty_label='Choisir'
    )
    niveau = forms.ChoiceField(choices=[
        ('L1', 'Licence 1'), ('L2', 'Licence 2'), ('L3', 'Licence 3'),
        ('M1', 'Master 1'), ('M2', 'Master 2')
    ])
    bio = forms.CharField(widget=forms.Textarea, required=False)


    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['filiere'].queryset = Filiere.objects.all()

    def save(self, commit=True):
        user = super().save(commit=False)
    # email est maintenant disponible via cleaned_data
        if not user.username:
            user.username = self.cleaned_data.get('email', '')
        if commit:
            user.save()
        return user

    class Meta:
        model = Utilisateur
        fields = [
            'first_name', 'last_name', 'email',
            'telephone', 'filiere', 'niveau',
            'bio', 'photo', 'password1', 'password2'
        ]


class ConnexionForm(forms.Form):
    identifiant = forms.CharField(label='E-mail ou téléphone')
    mot_de_passe = forms.CharField(widget=forms.PasswordInput)


class ProfilForm(forms.ModelForm):
    class Meta:
        model = Utilisateur
        fields = [
            'first_name', 'last_name', 'telephone',
            'filiere', 'niveau', 'bio',
            'centres_interet', 'photo'
        ]
