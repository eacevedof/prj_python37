"""
DJANGO
<project>/platzigram/appposts/models.py
"""

from django.db import models
from django.contrib.auth.models import User


# video 18
# appposts.models.post
class Post(models.Model):
    """Post Model"""
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    # <modulo>.<modelo> para evitar referencias circulares
    profile = models.ForeignKey("appusers.Profile",on_delete=models.CASCADE)

    title = models.CharField(max_length=255)
    photo = models.ImageField(upload_to="posts/photos")

    created = models.DateTimeField(auto_now_add=True)
    modified = models.DateTimeField(auto_now=True)

    def __str__(self):
        """Returns the Post data"""
        return "user: {},profile: {},title: {},photo: {},created: {},modified: {}".format(
            self.user,self.profile,self.title,self.photo,self.created,self.modified
        )


