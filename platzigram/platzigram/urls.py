"""urls.py"""
from django.urls import path
from django.contrib import admin
# sirve para poder dar soporte a datos tipo mime
from django.conf.urls.static import static

# imports de la app
# settings es el fichero platizgram/settings.py
from django.conf import settings
from platzigram import views as local_views
from appposts import views as posts_views
from appusers import views as users_views

urlpatterns = [

# PUBLICO
    path("", local_views.hello_world, name="home"),
    path("sorted/", local_views.sort_integers, name="sort"),
    path("posts/", posts_views.list_posts, name="feed"),
    path("posts/new/", posts_views.create_post, name="create_post"),

# ADMIN
    path('admin/', admin.site.urls),
    path("users/login/", users_views.login_view, name="login"),
    path("users/logout/", users_views.logout_view, name="logout"),
    path("users/signup/", users_views.signup_view, name="signup"),
    path("users/me/profile/", users_views.update_profile, name="update_profile"),

] + static(settings.MEDIA_URL,document_root=settings.MEDIA_ROOT)
