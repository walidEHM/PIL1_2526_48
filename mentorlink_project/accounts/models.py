from django.contrib.auth.models import BaseUserManager, AbstractUser, UnicodeUsernameValidator
from django.db import models
from django.utils import timezone

class Filiere(models.Model):
    idFiliere = models.AutoField(primary_key=True)
    nomFiliere = models.CharField(max_length=255)

    class Meta:
        db_table = 'filiere'

    def __str__(self):
        return self.nomFiliere


class CustomUserManager(BaseUserManager):
    def create_user(self, email, password=None, **extra_fields):
        if not email:
            raise ValueError("L'email est obligatoire")
        email = self.normalize_email(email)
        extra_fields.setdefault('username', email)
        user = self.model(email=email, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, email, password=None, **extra_fields):
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)
        return self.create_user(email, password, **extra_fields)

class Utilisateur(AbstractUser):
    id = models.BigAutoField(primary_key=True, db_column='idUtilisateur')
    username = models.CharField(
        error_messages={'unique': 'A user with that username already exists.'},
        help_text='Required. 150 characters or fewer. Letters, digits and @/./+/-/_ only.',
        max_length=150,
        unique=True,
        validators=[UnicodeUsernameValidator()],
        db_column='username',
        blank=True,
        null=True,
        verbose_name='username'
    )
    first_name = models.CharField(max_length=150, blank=True, db_column='nomUtilisateur')
    last_name = models.CharField(max_length=150, blank=True, db_column='prenomUtilisateur')
    email = models.EmailField(max_length=254, blank=True, unique=True, db_column='emailUtilisateur')
    password = models.CharField(max_length=128, verbose_name='password', db_column='mot_de_passeUtilisateur')
    is_staff = models.BooleanField(default=False, db_column='is_staff')
    is_active = models.BooleanField(default=True, db_column='is_active')
    is_superuser = models.BooleanField(default=False, db_column='is_superuser')
    last_login = models.DateTimeField(blank=True, null=True, db_column='last_login')
    date_joined = models.DateTimeField(default=timezone.now, verbose_name='date joined', db_column='date_CreationUtilisateur')
    telephone = models.CharField(
        max_length=255,
        unique=True,
        null=True,
        blank=True,
        db_column='telephoneUtilisateur'
    )
    photo = models.ImageField(
        upload_to='profils/',
        null=True,
        blank=True,
        db_column='photoUtilisateur'
    )
    filiere = models.ForeignKey(
        Filiere, on_delete=models.SET_NULL,
        null=True, blank=True, db_column='idFiliere'
    )
    niveau = models.CharField(max_length=255, null=True, blank=True, db_column='niveauUtilisateur')
    bio = models.TextField(null=True, blank=True, db_column='bioUtilisateur')
    centres_interet = models.TextField(null=True, blank=True, db_column='centres_interetUtilisateur')
    

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []
    objects = CustomUserManager()

    class Meta:
        db_table = 'utilisateur'

    def __str__(self):
        return self.email or self.username or ''


class Competence(models.Model):
    idCompetence = models.AutoField(primary_key=True)
    nomCompetence = models.CharField(max_length=255)

    class Meta:
        db_table = 'competence'

    def __str__(self):
        return self.nomCompetence


class UtilisateurCompetence(models.Model):
    idUtilisateur = models.ForeignKey(
        Utilisateur, on_delete=models.CASCADE, db_column='idUtilisateur'
    )
    idCompetence = models.ForeignKey(
        Competence, on_delete=models.CASCADE, db_column='idCompetence'
    )
    typeUtilisateur_Competence = models.CharField(max_length=255)

    class Meta:
        db_table = 'utilisateur_competence'
        unique_together = ('idUtilisateur', 'idCompetence')


class Disponibilite(models.Model):
    idDisponibilite = models.AutoField(primary_key=True)
    idUtilisateur = models.ForeignKey(
        Utilisateur, on_delete=models.CASCADE, db_column='idUtilisateur'
    )
    jourDisponibilite = models.CharField(max_length=255)
    heure_debutDisponibilite = models.TimeField()
    heure_finDisponibilite = models.TimeField()
    statutDisponibilite = models.CharField(max_length=255)
    date_creationDisponibilite = models.DateTimeField(auto_now_add=True)
    date_modificationDisponibilite = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = 'disponibilite'


