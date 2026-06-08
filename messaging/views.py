from django.shortcuts import render, get_object_or_404, redirect
from django.contrib.auth.decorators import login_required
from django.contrib.auth import get_user_model
from django.http import JsonResponse
from django.views.decorators.http import require_POST
import json
from .models import Conversation, Message

User = get_user_model()

@login_required
def liste_conversations(request):
    conversations = request.user.conversations.all().order_by('-date_creation')
    return render(request, 'messaging/liste_conversations.html', {
        'conversations': conversations
    })

@login_required
def detail_conversation(request, conversation_id):
    conversation = get_object_or_404(
        Conversation, id=conversation_id, participants=request.user
    )
    Message.objects.filter(
        conversation=conversation, lu=False
    ).exclude(expediteur=request.user).update(lu=True)
    messages = conversation.messages.all()
    return render(request, 'messaging/chat.html', {
        'conversation': conversation,
        'messages': messages
    })

@login_required
def demarrer_conversation(request, user_id):
    autre_user = get_object_or_404(User, id=user_id)
    conversations_communes = Conversation.objects.filter(
        participants=request.user
    ).filter(participants=autre_user)
    if conversations_communes.exists():
        conversation = conversations_communes.first()
    else:
        conversation = Conversation.objects.create()
        conversation.participants.add(request.user, autre_user)
    return redirect('messaging:detail_conversation',
                   conversation_id=conversation.id)

@login_required
@require_POST
def envoyer_message(request, conversation_id):
    conversation = get_object_or_404(
        Conversation, id=conversation_id, participants=request.user
    )
    try:
        data = json.loads(request.body)
        contenu = data.get('contenu', '').strip()
    except json.JSONDecodeError:
        contenu = request.POST.get('contenu', '').strip()
    if contenu:
        message = Message.objects.create(
            conversation=conversation,
            expediteur=request.user,
            contenu=contenu
        )
        return JsonResponse({
            'success': True,
            'message': {
                'id': message.id,
                'contenu': message.contenu,
                'expediteur': message.expediteur.username,
                'date_envoi': message.date_envoi.strftime('%H:%M'),
                'lu': message.lu
            }
        })
    return JsonResponse({'success': False, 'error': 'Message vide'})

@login_required
def messages_non_lus(request):
    count = Message.objects.filter(
        conversation__participants=request.user,
        lu=False
    ).exclude(expediteur=request.user).count()
    return JsonResponse({'non_lus': count})