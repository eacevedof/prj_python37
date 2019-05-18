s("views.py")
# theapp/views.py
from django.shortcuts import render

from rest_framework import viewsets
from .models.models import *
from .serializers import *
from vendor.theframework import utils as u

class AppViewSet(viewsets.ModelViewSet):

   def destroy(self, request, *args, **kwargs):
        """
        Realiza soft-delete
        """
        objmodel = self.get_object()
        pr(objmodel,"AppViewSet.destroy.objmodel")
        objmodel.delete_date = u.get_now()
        objmodel.delete_user = request.user.id 
        objmodel.delete_platform = u.get_platform()
        objmodel.save()
        return Response(data='delete success')
 


class AppArrayViewSet(AppViewSet):
    # queryset = AppArray.objects.all()
    queryset = AppArray.objects.filter(delete_date=None)
    serializer_class = AppArraySerializer

    def __init__(self, *args, **kwargs):
        # pr(dir(self),"AppArrayViewSet.__init__.self.request")
        pr(args,"AppArrayViewSet.__init__.self.args")
        pr(kwargs,"AppArrayViewSet.__init__.self.kwargs")
        return super().__init__(*args, **kwargs)

    # https://www.django-rest-framework.org/api-guide/viewsets/
    # https://stackoverflow.com/questions/30650008/django-rest-framework-override-create-in-modelserializer-passing-an-extra-par

class AppExamViewSet(viewsets.ModelViewSet):
    queryset = AppExam.objects.all()
    serializer_class = AppExamSerializer

class AppExamsSentencesViewSet(viewsets.ModelViewSet):
    queryset = AppExamsSentences.objects.all()
    serializer_class = AppExamsSentencesSerializer

class AppExamsUsersViewSet(viewsets.ModelViewSet):
    queryset = AppExamsUsers.objects.all()
    serializer_class = AppExamsUsersSerializer

class AppExamsUsersEvalhViewSet(viewsets.ModelViewSet):
    queryset = AppExamsUsersEvalh.objects.all()
    serializer_class = AppExamsUsersEvalhSerializer

class AppExamsUsersEvallViewSet(viewsets.ModelViewSet):
    queryset = AppExamsUsersEvall.objects.all()
    serializer_class = AppExamsUsersEvallSerializer

class AppSentenceViewSet(viewsets.ModelViewSet):
    queryset = AppSentence.objects.all()
    serializer_class = AppSentenceSerializer
        
class AppSentenceImagesViewSet(viewsets.ModelViewSet):
    queryset = AppSentenceImages.objects.all()
    serializer_class = AppSentenceImagesSerializer

class AppSentencesUsersViewSet(viewsets.ModelViewSet):
    queryset = AppSentencesUsers.objects.all()
    serializer_class = AppSentencesUsersSerializer

class AppSentenceTagsViewSet(viewsets.ModelViewSet):
    queryset = AppSentenceTags.objects.all()
    serializer_class = AppSentenceTagsSerializer

class AppSentenceTrViewSet(viewsets.ModelViewSet):
    queryset = AppSentenceTr.objects.all()
    serializer_class = AppSentenceTrSerializer

class AppTagViewSet(viewsets.ModelViewSet):
    queryset = AppTag.objects.all()
    serializer_class = AppTagSerializer

class BaseLanguageViewSet(viewsets.ModelViewSet):
    queryset = BaseLanguage.objects.all()
    serializer_class = BaseLanguageSerializer

class BaseLanguageLangViewSet(viewsets.ModelViewSet):
    queryset = BaseLanguageLang.objects.all()
    serializer_class = BaseLanguageLangSerializer

class BaseUserViewSet(viewsets.ModelViewSet):
    queryset = BaseUser.objects.all()
    serializer_class = BaseUserSerializer
	
class BaseUserArrayViewSet(viewsets.ModelViewSet):
    queryset = BaseUserArray.objects.all()
    serializer_class = BaseUserArraySerializer

class VersionDbViewSet(viewsets.ModelViewSet):
    queryset = VersionDb.objects.all()
    serializer_class = VersionDbSerializer


from rest_framework.views import APIView, Response
 
class CustomView(APIView):
    def get(self, request, format=None):
        return Response("Some Get Response")
 
    def post(self, request, format=None):
        return Response("Some Post Response")