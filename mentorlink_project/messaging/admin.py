from django.contrib import admin

from .models import Conversation, Message


@admin.register(Conversation)
class ConversationAdmin(admin.ModelAdmin):
    list_display = ('idConversation', 'idMatches', 'date_creationConversation')
    search_fields = ('idMatches__idMentor__email', 'idMatches__idMentore__email')


@admin.register(Message)
class MessageAdmin(admin.ModelAdmin):
    list_display = ('idMessage', 'idConversation', 'id_expediteurMessage', 'luMessage', 'date_creationMessage')
    list_filter = ('luMessage',)
    search_fields = ('contenuMessage', 'id_expediteurMessage__email')
