from django.contrib import admin
from django.contrib.auth.models import Group
from .models import *

admin.site.site_header = "Learnlang -  Admin Pannel"

class AppArrayAdmin(admin.ModelAdmin):
    exclude = (
        "processflag","insert_platform","insert_user","insert_date"
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
