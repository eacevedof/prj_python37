"""
appposts\forms.py
Post forms.
"""

# Django
from django import forms
# models
from appposts.models import Post

class PostForm(forms.ModelForm):
    """Post model form."""

    class Meta:
        "Form settings"
        model = Post
        fields = ("user","profile","title","photo")