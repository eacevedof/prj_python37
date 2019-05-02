from .base import *
s("settings.dev.py")

if DEBUG:

    def custom_show_toolbar(request):
        """ Only show the debug toolbar to users with the superuser flag. """
        #return request.user.is_superuser
        if request.is_ajax():
            return False
        return True

    INSTALLED_APPS += [
        'debug_toolbar',
    ]

    MIDDLEWARE += [
        'debug_toolbar.middleware.DebugToolbarMiddleware',
    ]

    INTERNAL_IPS = ('127.0.0.1', )

    DEBUG_TOOLBAR_CONFIG = {
        'INTERCEPT_REDIRECTS': False,
        # 'SHOW_TOOLBAR_CALLBACK': 'core.settings.custom_show_toolbar',
        'HIDE_DJANGO_SQL': True,
        'TAG': 'body',
        'SHOW_TEMPLATE_CONTEXT': True,
        'ENABLE_STACKTRACES': True,
    }
