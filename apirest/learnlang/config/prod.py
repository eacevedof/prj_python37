from .base import *

if ENV=="prod":
    STATIC_ROOT = '/home/eduardoaf/prj_python37/apirest/static/'

    DATABASES = {
        "default": {
                'ENGINE': 'django.db.backends.mysql',
                'NAME': 'dbname',
                'USER': 'dbuser',
                'PASSWORD': 'dbpwd',
                'HOST': 'dbhost',
                'PORT': '3306',
            },
    }