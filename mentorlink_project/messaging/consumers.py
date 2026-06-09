import json
from channels.generic.websocket import AsyncWebsocketConsumer
from channels.db import database_sync_to_async
from .models import Conversation, Message
from django.contrib.auth import get_user_model

User = get_user_model()

class ChatConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        self.conversation_id = self.scope['url_route']['kwargs']['conversation_id']
        self.room_group_name = f'chat_{self.conversation_id}'

        # Vérification que l'utilisateur a bien accès à la conversation
        if not await self.has_access():
            await self.close()
            return

        # Rejoindre le groupe
        await self.channel_layer.group_add(
            self.room_group_name,
            self.channel_name
        )
        await self.accept()

    async def disconnect(self, close_code):
        await self.channel_layer.group_discard(
            self.room_group_name,
            self.channel_name
        )

    async def receive(self, text_data):
        data = json.loads(text_data)
        message_content = data.get('message', '').strip()
        if not message_content:
            return

        # Sauvegarder le message en base
        message = await self.save_message(message_content)

        # Envoyer le message au groupe
        await self.channel_layer.group_send(
            self.room_group_name,
            {
                'type': 'chat_message',
                'message': {
                    'id': message.idMessage,
                    'contenu': message.contenuMessage,
                    'expediteur_id': message.id_expediteurMessage_id,
                    'expediteur_nom': message.id_expediteurMessage.username,  # ou prenom
                    'date_envoi': message.date_creationMessage.strftime('%H:%M'),
                    'lu': message.luMessage,
                }
            }
        )

    async def chat_message(self, event):
        # Envoyer le message au WebSocket
        await self.send(text_data=json.dumps(event['message']))

    @database_sync_to_async
    def has_access(self):
        try:
            conversation = Conversation.objects.get(idConversation=self.conversation_id)
        except Conversation.DoesNotExist:
            return False
        user = self.scope['user']
        return (conversation.idMatches.idMentor == user or
                conversation.idMatches.idMentore == user)

    @database_sync_to_async
    def save_message(self, content):
        conversation = Conversation.objects.get(idConversation=self.conversation_id)
        user = self.scope['user']
        return Message.objects.create(
            idConversation=conversation,
            id_expediteurMessage=user,
            contenuMessage=content
        )