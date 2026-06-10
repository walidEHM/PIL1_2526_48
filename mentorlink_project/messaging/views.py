from django.shortcuts import render, get_object_or_404, redirect
from django.contrib.auth.decorators import login_required
from django.contrib.auth import get_user_model
from django.contrib import messages
from django.db.models import Max, F, Q
from django.db.models.functions import Coalesce
from django.http import JsonResponse
from django.views.decorators.http import require_POST
import json
from .models import Conversation, Message
from matching.models import Annonce, Match

User = get_user_model()

@login_required
def liste_conversations(request):
    # Récupération des conversations avec annotation de la date du dernier message
    conversations = Conversation.objects.filter(
        Q(idMatches__idMentor=request.user) | Q(idMatches__idMentore=request.user)
    ).annotate(
        dernier_msg_date=Coalesce(
            Max('message__date_creationMessage'),
            F('date_creationConversation')
        )
    ).order_by('-dernier_msg_date')

    for conversation in conversations:
        conversation.other_user = (
            conversation.idMatches.idMentore
            if conversation.idMatches.idMentor == request.user
            else conversation.idMatches.idMentor
        )
        conversation.dernier_message = conversation.message_set.order_by('-date_creationMessage').first()
        conversation.non_lus = Message.objects.filter(
            idConversation=conversation,
            luMessage=False
        ).exclude(id_expediteurMessage=request.user).count()

    return render(request, 'messaging/liste_conversations.html', {'conversations': conversations})

@login_required
def detail_conversation(request, conversation_id):
    conversation = get_object_or_404(
        Conversation,
        Q(idMatches__idMentor=request.user) | Q(idMatches__idMentore=request.user),
        idConversation=conversation_id
    )
    # Marquer les messages comme lus
    Message.objects.filter(
        idConversation=conversation,
        luMessage=False
    ).exclude(id_expediteurMessage=request.user).update(luMessage=True)

    messages = Message.objects.filter(idConversation=conversation).order_by('date_creationMessage')
    other_user = (conversation.idMatches.idMentore 
                  if conversation.idMatches.idMentor == request.user 
                  else conversation.idMatches.idMentor)

    # Requête pour toutes les conversations (sidebar)
    conversations = Conversation.objects.filter(
        Q(idMatches__idMentor=request.user) | Q(idMatches__idMentore=request.user)
    ).annotate(
        dernier_msg_date=Coalesce(
            Max('message__date_creationMessage'),
            F('date_creationConversation')
        )
    ).order_by('-dernier_msg_date')

    for conv in conversations:
        conv.other_user = (conv.idMatches.idMentore 
                           if conv.idMatches.idMentor == request.user 
                           else conv.idMatches.idMentor)
        conv.dernier_message = conv.message_set.order_by('-date_creationMessage').first()
        conv.non_lus = Message.objects.filter(
            idConversation=conv,
            luMessage=False
        ).exclude(id_expediteurMessage=request.user).count()

    # Réponse AJAX (inchangée)
    if request.headers.get('x-requested-with') == 'XMLHttpRequest' or request.GET.get('format') == 'json':
        message_list = []
        for message in messages:
            message_list.append({
                'id': message.idMessage,
                'contenu': message.contenuMessage,
                'expediteur_id': message.id_expediteurMessage.pk,   # <-- indispensable pour le WebSocket
                'expediteur': message.id_expediteurMessage.username,
                'date_envoi': message.date_creationMessage.strftime('%H:%M'),
                'lu': message.luMessage,
            })
        return JsonResponse({'messages': message_list})

    return render(request, 'messaging/chat.html', {
        'conversation': conversation,
        'messages': messages,
        'other_user': other_user,
        'conversations': conversations,
    })
    
    
@login_required
def demarrer_conversation(request, user_id):
    autre_user = get_object_or_404(User, id=user_id)
    conversation = Conversation.objects.filter(
        Q(idMatches__idMentor=request.user, idMatches__idMentore=autre_user) |
        Q(idMatches__idMentor=autre_user, idMatches__idMentore=request.user)
    ).first()
    if not conversation:
        match = Match.objects.filter(
            Q(idMentor=request.user, idMentore=autre_user) |
            Q(idMentor=autre_user, idMentore=request.user)
        ).first()
        if not match:
            annonce_active = Annonce.objects.filter(
                idUtilisateur=autre_user,
                statutAnnonce='active',
            ).exists()
            if not annonce_active:
                messages.error(request, "Aucun match ou annonce active ne permet d'ouvrir cette conversation.")
                return redirect('matching:dashboard')

            match = Match.objects.create(
                idMentor=autre_user,
                idMentore=request.user,
                score_compatibiliteMatch=0.0,
                statutMatches='annonce'
            )
        conversation = Conversation.objects.create(idMatches=match)
    return redirect('messaging:detail_conversation', conversation_id=conversation.idConversation)

@login_required
@require_POST
def envoyer_message(request, conversation_id):
    conversation = get_object_or_404(
        Conversation,
        Q(idMatches__idMentor=request.user) | Q(idMatches__idMentore=request.user),
        idConversation=conversation_id
    )
    try:
        data = json.loads(request.body)
        contenu = data.get('contenu', '').strip()
    except json.JSONDecodeError:
        contenu = request.POST.get('contenu', '').strip()
    if contenu:
        message = Message.objects.create(
            idConversation=conversation,
            id_expediteurMessage=request.user,
            contenuMessage=contenu
        )
        return JsonResponse({
            'success': True,
            'message': {
                'id': message.idMessage,
                'contenu': message.contenuMessage,
                'expediteur': message.id_expediteurMessage.username,
                'date_envoi': message.date_creationMessage.strftime('%H:%M'),
                'lu': message.luMessage
            }
        })
    return JsonResponse({'success': False, 'error': 'Message vide'})

@login_required
def messages_non_lus(request):
    count = Message.objects.filter(
        Q(idConversation__idMatches__idMentor=request.user) | Q(idConversation__idMatches__idMentore=request.user),
        luMessage=False
    ).exclude(id_expediteurMessage=request.user).count()
    return JsonResponse({'non_lus': count})
