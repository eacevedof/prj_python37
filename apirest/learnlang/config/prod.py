from .base import *

if ENV=="prod":
    STATIC_ROOT = '/home/eduardoaf/prj_python37/apirest/static/'

    DATABASES = {
        "default": {
                'ENGINE': 'django.db.backends.mysql',
                'NAME': 'db_learnlang',
                'USER': 'root',
                'PASSWORD': '',
                'HOST': 'eduardoaf.mysql.pythonanywhere-services.com',
                'PORT': '3306',
            },
    }