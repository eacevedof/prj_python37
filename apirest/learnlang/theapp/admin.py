from django.contrib import admin
from django.contrib.auth.models import Group
from .models import *

admin.site.site_header = "Learnlang -  Admin Pannel"

class AppArrayAdmin(admin.ModelAdmin):
    exclude = (
        "processflag",
        "insert_platform","insert_user","insert_date",
        "update_platform","update_user","update_date",
        "delete_platform","delete_user","delete_date",
        "cru_csvnote","is_erpsent","is_enabled","i","code_erp"
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
