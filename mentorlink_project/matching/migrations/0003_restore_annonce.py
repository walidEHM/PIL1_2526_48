from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('matching', '0002_alter_annoncecompetence_unique_together_and_more'),
    ]

    operations = [
        migrations.CreateModel(
            name='Annonce',
            fields=[
                ('idAnnonce', models.AutoField(primary_key=True, serialize=False)),
                ('typeAnnonce', models.CharField(choices=[('offre', 'Offre'), ('demande', 'Demande')], max_length=20)),
                ('matiereAnnonce', models.CharField(max_length=255)),
                ('descriptionAnnonce', models.TextField()),
                ('formatAnnonce', models.CharField(choices=[('presentiel', 'Présentiel'), ('en_ligne', 'En ligne'), ('hybride', 'Hybride')], max_length=30)),
                ('joursAnnonce', models.CharField(blank=True, max_length=255)),
                ('statutAnnonce', models.CharField(choices=[('active', 'Active'), ('archivee', 'Archivée')], default='active', max_length=20)),
                ('date_creationAnnonce', models.DateTimeField(auto_now_add=True)),
                ('date_modificationAnnonce', models.DateTimeField(auto_now=True)),
                ('idUtilisateur', models.ForeignKey(db_column='idUtilisateur', on_delete=django.db.models.deletion.CASCADE, related_name='annonces', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'db_table': 'annonce',
                'ordering': ['-date_creationAnnonce'],
            },
        ),
    ]
