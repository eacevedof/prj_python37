"""
platzigram\appusers\forms.py
User.forms
"""
from django import forms

class ProfileForm(forms.Form):
    """Profile form."""
    # para estas validaciones nos podemos apoyar en la configuración del modelo
    website = forms.URLField(max_length=200, required=True)
    biography = forms.CharField(max_length=500, required=False)
    phone_number = forms.CharField(max_length=20, required=False)
    picture = forms.ImageField()