"""platzigram/appusers/admin.py"""
from django.contrib import admin
# Register your models here.
from .models import Profile
admin.site.register(Profile)