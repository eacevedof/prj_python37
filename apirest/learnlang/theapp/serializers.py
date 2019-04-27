print("serializers.py\n")
# theapp/serializers.py

"""
https://youtu.be/RoxEX9DFF7s?t=578
Los serializadores. Son como los formularios de Django

"""
from rest_framework import serializers
from .models import *
from utils import utils as u

# override serializers: 
# https://www.django-rest-framework.org/api-guide/serializers/
# source code:
# https://github.com/encode/django-rest-framework/blob/master/rest_framework/serializers.py
class AppArraySerializer(serializers.ModelSerializer):
    objuser = None

    def __init__(self, *args, **kwargs):
        # self.objuser = kwargs["context"]["request"]
        # AppArray.objuser = self.objuser
        u.pr(self.objuser,"AppArraySerializer.__init__.objuser")
        u.pr(args,"AppArraySerializer.__init__.args")
        u.pr(kwargs,"AppArraySerializer.__init__.kwargs")
      
        return super().__init__(*args, **kwargs)

    class Meta:
        model = AppArray
        # __all__ muestra y acepta todos los campos de la petición
        fields = '__all__'

        def __init__(self, *args, **kwargs):
            # self.model.objuser = self.objuser
            u.pr(self.objuser,"AppArraySerializer.Meta.__init__.objuser")
            u.pr(args,"AppArraySerializer.Meta.__init__.args")
            u.pr(kwargs,"AppArraySerializer.Meta.__init__.kwargs")            
            return super().__init__(*args, **kwargs)

    def createXXX(self, validated_data):
        u.pr("AppArraySerializer.create","serializers.py")
        objmodel = AppArray(**validated_data)
        return objmodel

    def updateXXX(self, instance, validated_data):
        u.pr("AppArraySerializer.update","serializers.py")
        """
        user_id = self.user_id
        print(user_id)        
        user = self.context['request'].user

        if user_id is None or user_id == '':
            instance.players.remove(user)
        else:
            instance.players.remove(user_id)
        instance.save()
        """
        return instance

    
    

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
