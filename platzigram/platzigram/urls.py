"""urls.py"""
from django.urls import path
from django.contrib import admin
from platzigram import views as local_views
from appposts import views as posts_views

urlpatterns = [
    path('admin/', admin.site.urls),
    path("hello-world/",local_views.hello_world),
    path("sorted/",local_views.sort_integers),
    path("hi/<str:name>/<int:age>/",local_views.say_hi),
    path("posts/",posts_views.list_posts),
]
