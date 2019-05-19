s("theapp.admin.sections.admin_apparray")
from .admin_theapp import TheappModelAdmin
from vendor.theframework import utils as u


class AppArrayAdmin(TheappModelAdmin):

    #no se mostrarán en el form de detalle
    exclude = (
        "processflag",
        "insert_platform","insert_user","insert_date",
        "update_platform","update_user","update_date",
        "delete_platform","delete_user","delete_date",
        "cru_csvnote","is_erpsent","i","code_erp",
        "module","id_tosave","code_cache"
    )

    # caja de texto
    search_fields = (
        "id","description","type","module"
    )

    # links de filtrado
    list_display = (
        "desc_id","type","id","description","order_by","is_enabled","insert_user","insert_date",
        "code_cache",
    )

    list_editable = ("order_by","is_enabled",)

    # readonly_fields = ("is_enabled", )

    ordering = ("id",)

    list_filter = (
        "type","module","is_enabled","insert_date"
    )    

    # desplegable con acciones
    actions = ["soft_delete"]

    def soft_delete(modeladmin,request,queryset):
        queryset.update(
            delete_user = request.user.id,
            delete_date = u.get_now(),
            delete_platform = u.get_platform())

    soft_delete.short_description = "Soft delete"

"""
    def get_readonly_fields(self, request, obj=None):
        if obj: # obj is not None, so this is an edit
            return ("is_enabled",) # Return a list or tuple of readonly fields' names
        else: # This is an addition
            return []
"""