s("theapp.admin.sections.register.py")
from django.contrib import admin
from .admin_theapp import *
from .admin_apparray import *

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
admin.site.register(AppSentenceTr)
admin.site.register(AppTag)
admin.site.register(BaseLanguage)
admin.site.register(BaseLanguageLang)
admin.site.register(BaseUser)
admin.site.register(BaseUserArray)
admin.site.register(VersionDb)
