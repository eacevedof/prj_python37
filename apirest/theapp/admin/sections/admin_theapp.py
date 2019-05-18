s("theapp.admin.sections.admin_theapp")
from django.contrib import admin
from ...models.models import *
from vendor.theframework import utils as u

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