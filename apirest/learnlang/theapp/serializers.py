# theapp/serializers.py
from rest_framework import serializers
from .models import *
 
class AppArraySerializer(serializers.ModelSerializer):
    class Meta:
        model = AppArray
        fields = '__all__'

class AppExamSerializer(serializers.ModelSerializer):
    class Meta:
        model = AppExam
        fields = '__all__'
        
class AppExamsSentencesSerializer(serializers.ModelSerializer):
    class Meta:
        model = AppExamsSentences
        fields = '__all__'
        
class AppExamsUsersSerializer(serializers.ModelSerializer):
    class Meta:
        model = AppExamsUsers
        fields = '__all__'
        
class AppExamsUsersEvalhSerializer(serializers.ModelSerializer):
    class Meta:
        model = AppExamsUsersEvalh
        fields = '__all__'
        
class AppExamsUsersEvallSerializer(serializers.ModelSerializer):
    class Meta:
        model = AppExamsUsersEvall
        fields = '__all__'
        
class AppSentenceSerializer(serializers.ModelSerializer):
    class Meta:
        model = AppSentence
        fields = '__all__'
        
class AppSentenceImagesSerializer(serializers.ModelSerializer):
    class Meta:
        model = AppSentenceImages
        fields = '__all__'
        
class AppSentencesUsersSerializer(serializers.ModelSerializer):
    class Meta:
        model = AppSentencesUsers
        fields = '__all__'
        
class AppSentenceTagsSerializer(serializers.ModelSerializer):
    class Meta:
        model = AppSentenceTags
        fields = '__all__'
        
class AppSentenceTimesSerializer(serializers.ModelSerializer):
    class Meta:
        model = AppSentenceTimes
        fields = '__all__'
        
class AppSentenceTrSerializer(serializers.ModelSerializer):
    class Meta:
        model = AppSentenceTr
        fields = '__all__'
        
class AppTagSerializer(serializers.ModelSerializer):
    class Meta:
        model = AppTag
        fields = '__all__'
        
class BaseLanguageSerializer(serializers.ModelSerializer):
    class Meta:
        model = BaseLanguage
        fields = '__all__'
        
class BaseLanguageLangSerializer(serializers.ModelSerializer):
    class Meta:
        model = BaseLanguageLang
        fields = '__all__'
        
class BaseUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = BaseUser
        fields = '__all__'
        
class BaseUserArraySerializer(serializers.ModelSerializer):
    class Meta:
        model = BaseUserArray
        fields = '__all__'
        
class TemplateSerializer(serializers.ModelSerializer):
    class Meta:
        model = Template
        fields = '__all__'
        
class TemplateArraySerializer(serializers.ModelSerializer):
    class Meta:
        model = TemplateArray
        fields = '__all__'
        
class VersionDbSerializer(serializers.ModelSerializer):
    class Meta:
        model = VersionDb
        fields = '__all__'
