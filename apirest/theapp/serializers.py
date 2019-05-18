s("serializers.py")
# theapp/serializers.py

"""
https://youtu.be/RoxEX9DFF7s?t=578
Los serializadores. Son como los formularios de Django

"""
from rest_framework import serializers
from .models.models import *
from vendor.theframework import utils as u

class TheappSerializer(serializers.ModelSerializer):
    objuser = None

    def __init__(self, *args, **kwargs):
        self.objuser =  kwargs["context"]["request"].user
        pr(self.objuser.id,"TheappSerializer.self.objuser")
        # pr(self.context,"TheappSerializer.self.context")
        return super().__init__(*args, **kwargs)

    def create(self, validated_data):
        pr(self.context,"TheappSerializer.create")
        pr(validated_data,"create.validated_data")
        self.__load_sysfields(validated_data)
        return super().create(validated_data)
        # return self.Meta.model.objects.create(**validated_data)

    def update(self, instance, validated_data):
        pr(self.context,"TheappSerializer.update")
        pr(validated_data,"update.validated_data")
        self.__load_sysfields(validated_data,"u")
        return super().update(instance, validated_data)
    
    
    def __load_sysfields(self,validated_data, t="i"):
        strplatform = u.get_platform()
        strnow = u.get_now()

        validated_data["processflag"] 		=  0
        if t=="i":
            validated_data["insert_platform"] 	=  strplatform
            validated_data["insert_user"] 		=  self.objuser.id
            validated_data["insert_date"] 		=  strnow
            validated_data["is_enabled"]        =  1
            validated_data["code_cache"]        = u.get_uuid()
        elif t=="u":
            validated_data["update_platform"] 	=  strplatform
            validated_data["update_user"] 		=  self.objuser.id
            validated_data["update_date"] 		=  strnow
        elif t=="d":    
            validated_data["delete_platform"] 	=  strplatform
            validated_data["delete_user"] 		=  self.objuser.id
            validated_data["delete_date"] 		=  strnow

        validated_data["cru_csvnote"] = t
        validated_data["is_erpsent"] = None
        

            

# override serializers: 
# https://www.django-rest-framework.org/api-guide/serializers/
# source code:
# https://github.com/encode/django-rest-framework/blob/master/rest_framework/serializers.py
class AppArraySerializer(TheappSerializer):
    
    class Meta:
        model = AppArray
        # __all__ muestra y acepta todos los campos de la petición
        # fields = ("id","code_erp","type","module","id_tosave","description", "order_by")
        fields = ("id","type","description","module","order_by")
    

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
               
class VersionDbSerializer(serializers.ModelSerializer):
    class Meta:
        model = VersionDb
        fields = '__all__'
