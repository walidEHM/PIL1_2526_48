from django import forms

from .models import Annonce


class AnnonceForm(forms.ModelForm):
    jours = forms.MultipleChoiceField(
        choices=[
            ('Lun', 'Lun'),
            ('Mar', 'Mar'),
            ('Mer', 'Mer'),
            ('Jeu', 'Jeu'),
            ('Ven', 'Ven'),
            ('Sam', 'Sam'),
        ],
        required=False,
    )

    class Meta:
        model = Annonce
        fields = ['typeAnnonce', 'matiereAnnonce', 'formatAnnonce', 'descriptionAnnonce']

    def save(self, commit=True):
        annonce = super().save(commit=False)
        annonce.joursAnnonce = ', '.join(self.cleaned_data.get('jours', []))
        if commit:
            annonce.save()
        return annonce
