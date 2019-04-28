# print("main-urls.py\n")
# main url
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
    # include de las rutas de la app
    url(r'^api/v1/', include('learnlang.theapp.urls')),
    # se podría dar este caso para la sig version de la api
    # url(r'^api/v2/', include('learnlang.theapp.urls2')),    
    url(r'^api-auth/', include("rest_framework.urls", namespace="rest_framework")),
    url(r'^admin/', admin.site.urls),

]


if settings.DEBUG:
    import debug_toolbar
    urlpatterns += [
        url(r'^bug/', include(debug_toolbar.urls)),
    ] 
