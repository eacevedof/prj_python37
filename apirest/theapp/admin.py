s("admin.py")
from django.contrib import admin
from django.contrib.auth.models import Group
from vendor.theframework import utils as u
from .models import *

admin.site.site_header = "Learnlang -  Admin Pannel"

class TheappModelAdmin(admin.ModelAdmin):
    objuser = None

    def __load_sysfields(self, objmodel, t="i"):
        strplatform = u.get_platform()
        strnow = u.get_now()
        # bug(self.objuser,"objuser en load")
        user = "anonym" if not self.objuser else str(self.objuser.id)

        if t=="i":
            objmodel.insert_platform 	=  strplatform
            objmodel.insert_user 		=  user
            objmodel.insert_date 		=  strnow
            objmodel.is_enabled         =  "1"
            objmodel.code_cache         = u.get_uuid()
        elif t=="u":
            objmodel.update_platform 	=  strplatform
            objmodel.update_user 		=  user
            objmodel.update_date 		=  strnow
        elif t=="d":    
            objmodel.delete_platform 	=  strplatform
            objmodel.delete_user 		=  user
            objmodel.delete_date 		=  strnow

        objmodel.cru_csvnote = t
        objmodel.is_erpsent = None


    def save_model(self, request, obj, form, change):
        sc("TheappModelAdmin.save_model executed...")
        # necesito el usuario para cargar sysfields
        self.objuser = request.user
        # No se porque estas 2 trazas me fastidian el guardado
        pr(obj,"AppModelAdmin.save_model.obj")
        pr(self.objuser,"TheappModelAdmin.self.objuser")
        pr(request,"AppModelAdmin.save_model.request")
        pr(form,"AppModelAdmin.save_model.form")
        pr(change,"AppModelAdmin.save_model.change")

        # indica si es insert o update
        t = "u" if change else "i"
        self.__load_sysfields(obj,t)
        # obj.update_user = request.user.id
        super().save_model(request, obj, form, change)



# @admin.register(AppArray)
# @admin.register(AppArrayAdmin)
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

admin.site.register(AppArray,AppArrayAdmin)
admin.site.register(AppExam)
admin.site.register(AppExamsSentences)
admin.site.register(AppExamsUsers)
admin.site.register(AppExamsUsersEvalh)
admin.site.register(AppExamsUsersEvall)
admin.site.register(AppSentence)
admin.site.register(AppSentenceImages)
admin.site.register(AppSentencesUsers)
admin.site.register(AppSentenceTags)
admin.site.register(AppSentenceTimes)
admin.site.register(AppSentenceTr)
admin.site.register(AppTag)
admin.site.register(BaseLanguage)
admin.site.register(BaseLanguageLang)
admin.site.register(BaseUser)
admin.site.register(BaseUserArray)
admin.site.register(VersionDb)
