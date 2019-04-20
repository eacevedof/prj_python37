# learnlang/urls.py
"""learnlang URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.2/topics/http/urls/
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
from django.urls import path

from django.conf import settings
from django.conf.urls import url, include

urlpatterns = [
    url(r'^admin/', admin.site.urls),
    # include de las rutas de la app
    url(r'^api/', include('learnlang.theapp.urls')),
]

'''
^^^
if settings.DEBUG:
    from django.conf.urls.static import static
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
 
RAISES AN ERROR
 
File "/Users/fernandorodrigues/Documents/projects-angular/arin.ai/project/urls.py", line 18, in 
urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
File "/Users/fernandorodrigues/Documents/projects-angular/arin.ai/env/lib/python3.6/site-packages/django/conf/urls/static.py", line 21, in static
raise ImproperlyConfigured("Empty static prefix not permitted")
django.core.exceptions.ImproperlyConfigured: Empty static prefix not permitted
'''