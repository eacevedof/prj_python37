# print("admin.py\n")
from django.contrib import admin
from django.contrib.auth.models import Group
from utils import utils as u
from .models import *

admin.site.site_header = "Learnlang -  Admin Pannel"

class AppModelAdmin(admin.ModelAdmin):
    objuser = None

    def __init__(self, *args, **kwargs):
        bug("h")
        u.pr(args,"AppModelAdmin.__init__.args")
        u.pr(kwargs,"AppModelAdmin.__init__.kwargs")
     
        return super().__init__(*args, **kwargs)


    def __load_sysfields(self, objmodel, t="i"):
        strplatform = u.get_platform()
        strnow = u.get_now()

        if t=="i":
            objmodel.insert_platform 	=  strplatform
            objmodel.insert_user 		=  self.objuser.id
            objmodel.insert_date 		=  strnow
            objmodel.is_enabled         =  1
            objmodel.code_cache         = u.get_uuid()
        elif t=="u":
            objmodel.update_platform 	=  strplatform
            objmodel.update_user 		=  self.objuser.id
            objmodel.update_date 		=  strnow
        elif t=="d":    
            objmodel.delete_platform 	=  strplatform
            objmodel.delete_user 		=  self.objuser.id
            objmodel.delete_date 		=  strnow

        objmodel.cru_csvnote = t
        objmodel.is_erpsent = None

    def save_model(self, request, obj, form, change):
        mypr("hola")
        u.pr(request,"AppModelAdmin.save_model.request")
        u.pr(obj,"AppModelAdmin.save_model.obj")
        u.pr(form,"AppModelAdmin.save_model.form")
        u.pr(change,"AppModelAdmin.save_model.change")

        # obj.update_user = request.user.id
        super().save_model(request, obj, form, change)

class AppArrayAdmin(AppModelAdmin):
    exclude = (
        "processflag",
        "insert_platform","insert_user","insert_date",
        "update_platform","update_user","update_date",
        "delete_platform","delete_user","delete_date",
        "cru_csvnote","is_erpsent","is_enabled","i","code_erp",
        "module","id_tosave","code_cache"
    )

    list_display = (
        "insert_user","insert_date",
        "id","description","type","order_by","code_cache"
    )

    list_filter = (
        "description","type","module"
    )

    search_fields = (
        "id","description","type"
    )



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
