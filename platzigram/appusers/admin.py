"""platzigram/appusers/admin.py"""
from django.contrib import admin
# Register your models here.
from .models import Profile
# admin.site.register(Profile)

#Para registrarlo en una sola linea se usa el decorador y se le pasa el modelo
@admin.register(Profile)
class ProfileAdmin(admin.ModelAdmin):
    """Profile admin."""
    # esta variable configura la visualización de las columnas del grid
    list_display = ("pk","user","phone_number","website","picture")
    # botones de enlaces en el listado para que vaya al detalle del perfil
    list_display_links = ("pk","user")
    # permitir que se editen campos directamente en el grid de perfiles
    # un campo o es un link o es editable
    list_editable = ("phone_number","website","picture")
    # campos por los que se desea buscar
    search_fields = ("user__username","user__email","user__first_name","user__last_name","phone_number")
    # filtros
    list_filter = ("user__is_active","user__is_staff","created","modified",)


