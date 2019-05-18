s("theapp.admin.models.apparrayadmin")
from .theappmodel import TheappModelAdmin

class AppArrayAdmin(TheappModelAdmin):
    exclude = (
        "processflag",
        "insert_platform","insert_user","insert_date",
        "update_platform","update_user","update_date",
        "delete_platform","delete_user","delete_date",
        "cru_csvnote","is_erpsent","i","code_erp",
        "module","id_tosave","code_cache"
    )

    search_fields = (
        "id","description","type"
    )

    list_display = (
        "desc_id","id","description","order_by","is_enabled","insert_user","insert_date",
        "type","code_cache",
    )

    list_editable = ("description","order_by","is_enabled",)

    # readonly_fields = ("is_enabled", )

    ordering = ("id",)

    list_filter = (
        "description","type","module"
    )    

"""
    def get_readonly_fields(self, request, obj=None):
        if obj: # obj is not None, so this is an edit
            return ("is_enabled",) # Return a list or tuple of readonly fields' names
        else: # This is an addition
            return []
"""