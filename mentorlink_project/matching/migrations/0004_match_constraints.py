from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('matching', '0003_restore_annonce'),
    ]

    operations = [
        migrations.AlterUniqueTogether(
            name='match',
            unique_together={('idMentor', 'idMentore')},
        ),
        migrations.AddIndex(
            model_name='match',
            index=models.Index(fields=['idMentor', 'idMentore'], name='matching_ma_idMento_22fa20_idx'),
        ),
        migrations.AddIndex(
            model_name='match',
            index=models.Index(fields=['statutMatches', '-score_compatibiliteMatch'], name='matching_ma_statutM_f1e65b_idx'),
        ),
    ]
