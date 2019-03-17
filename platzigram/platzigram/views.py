"""views.py"""

from django.http import HttpResponse

def hello_world(request):
    """Returns a greeting."""
    return HttpResponse("Hello World")
