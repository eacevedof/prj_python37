from django import forms
from ...models.models import *

class ArrayForm(forms.ModelForm):
    class Meta:
        fields = ("id","description","module","order_by","is_enabled")
        model = AppArray