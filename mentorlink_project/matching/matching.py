def preparer_competences( competences_mentor,competences_mentore):
   #Convertir les listes en ensemble pour trouver les élements commun
   competences_communes =set( competences_mentor) & set(competences_mentore)

   #Compter les competences en commun
   commun = len( competences_communes)

   #Compter les competences demandées par le mentoré
   demandees = len ( compentences_mentore)

   return commun, demandees
  
def preparer_horaires ( horaires_mentor, horaire_mentore):
   horaires_communs = set(horaires_mentor) & set( horaires_mentore)
   crenaux_communs= len ( horaires_communs)
   crenaux_mentore= len (horaires_mentore)
   return crenaux_communs , crenaux_mentore

 def calculer_score ( commun, demandees, crenaux_communs, crenaux_mentore, meme_filiere , ecart_niveau):
   if demandees == 0
      score_competences = 0
   else:
       score_competences = ( commun / demandees) * 100
   if crenaux_mentore == 0
       score_horaires = 0
   else:
   score_horaires = ( crenaux_communs / crenaux_mentore) * 100
    
