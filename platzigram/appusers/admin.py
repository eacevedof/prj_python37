"""platzigram/appusers/admin.py"""
from django.contrib import admin
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin

# Models
from django.contrib.auth.models import User
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

    # configuración del detalle del perfil
    fieldsets = (
        # Profile es el texto de la barra azul
        ("Profile",{
            "fields":(
                ("user","picture"),
                # ("phone_number", "website"),
            ),
        }),
        ("Extra info", {
            "fields": (
                ("website", "phone_number"),
                ("biography"),
            ),
        }),
        ("Metadata", {
            "fields": (
                ("created", "modified"),
            ),
        }),
    )

    # para poder declarar los campos como metadata deben estar en readonly_fields ya que estos no
    # se pueden modificar
    readonly_fields = ("created","modified")

# sirve para gestionar el perfil en el detalle del usuario
class ProfileInline(admin.StackedInline):
    """Profile in-line admin for users"""
    model = Profile
    can_delete = False
    verbose_name_plural = "Profiles INLINE"


class UserAdmin(BaseUserAdmin):
    """Add profile admin to base user admin """
    inlines = (ProfileInline,)
    list_display = ("username","email","first_name","last_name","is_active","is_staff")


admin.site.unregister(User)
admin.site.register(User,UserAdmin)
