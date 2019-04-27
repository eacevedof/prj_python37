print("views.py\n")
# theapp/views.py
from django.shortcuts import render

from rest_framework import viewsets
from .models import *
from .serializers import *
from utils import utils as u

class AppArrayViewSet(viewsets.ModelViewSet):
    queryset = AppArray.objects.all()
    serializer_class = AppArraySerializer

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

class AppSentenceTimesViewSet(viewsets.ModelViewSet):
    queryset = AppSentenceTimes.objects.all()
    serializer_class = AppSentenceTimesSerializer

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

class TemplateViewSet(viewsets.ModelViewSet):
    queryset = Template.objects.all()
    serializer_class = TemplateSerializer

class TemplateArrayViewSet(viewsets.ModelViewSet):
    queryset = TemplateArray.objects.all()
    serializer_class = TemplateArraySerializer

class VersionDbViewSet(viewsets.ModelViewSet):
    queryset = VersionDb.objects.all()
    serializer_class = VersionDbSerializer


from rest_framework.views import APIView, Response
 
class CustomView(APIView):
    def get(self, request, format=None):
        return Response("Some Get Response")
 
    def post(self, request, format=None):
        return Response("Some Post Response")