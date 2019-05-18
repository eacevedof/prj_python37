s("theapp.managers.py")
from django.db import models

"""
https://youtu.be/rjUmA_pkGtw?t=382
Los managers añaden funcionalidad a la propiedad objects, agrega metodos

objects = MiManager()

otra forma de hacer esto es con los models.QuerySet

objects = MiQuerySet.as_manager()

[queryset](https://youtu.be/rjUmA_pkGtw?t=596)

class PostQuerySet(models.QuerySet):
    def smaller_than(self, size):
        return self.filter(comments__lt=size)

    def greater_than(self, size):
        return self.filter(comments_gt=size)

    def get_matts_posts(self,username):
        retun self.filter(author__username=username)        

class PostManager(models.Manager):

    def smaller_than(self, size):
        return self.filter(comments__lt=size)

    def get_queryset(self):
        return PostQuerySet(self.model, using=self._db)  <--- ^^

    def get_users_posts(self,username)
        # en get_queryset() se devuelve una instancia del queryset de este modelo
        # el QuerySet es una interfaz para lanzar consultas
        return self.get_queryset().get_users_posts(username)
"""