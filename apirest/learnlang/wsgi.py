"""
WSGI config for learnlang project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/2.2/howto/deployment/wsgi/
"""

import os
from vendor.theframework.builtins_ext import *
from django.core.wsgi import get_wsgi_application
s("wsgi.py")
# sirve archivos estaticos

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'learnlang.settings')
application = get_wsgi_application()
