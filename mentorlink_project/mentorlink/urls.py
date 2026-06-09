"""
URL configuration for mentorlink project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static
from django.views.generic import TemplateView, RedirectView

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', TemplateView.as_view(template_name='landing.html'), name='landing'),
    path('register/', RedirectView.as_view(pattern_name='accounts:inscription', permanent=False), name='register'),
    path('login/', RedirectView.as_view(pattern_name='accounts:connexion', permanent=False), name='login'),
    path('Inscription.html', RedirectView.as_view(pattern_name='accounts:inscription', permanent=False)),
    path('inscription.html', RedirectView.as_view(pattern_name='accounts:inscription', permanent=False)),
    path('Connexion.html', RedirectView.as_view(pattern_name='accounts:connexion', permanent=False)),
    path('connexion.html', RedirectView.as_view(pattern_name='accounts:connexion', permanent=False)),
    path('register.html', RedirectView.as_view(pattern_name='accounts:inscription', permanent=False)),
    path('login.html', RedirectView.as_view(pattern_name='accounts:connexion', permanent=False)),
    path('dashboard/', RedirectView.as_view(pattern_name='matching:dashboard', permanent=False)),
    path('annonces.html', RedirectView.as_view(pattern_name='matching:annonces', permanent=False)),
    path('chat.html', RedirectView.as_view(pattern_name='messaging:liste_conversations', permanent=False)),
    path('', include(('accounts.urls', 'accounts'), namespace='accounts')),
    path('matching/', include(('matching.urls', 'matching'), namespace='matching')),
    path('messaging/', include(('messaging.urls', 'messaging'), namespace='messaging')),
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
