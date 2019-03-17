"""views.py"""

from django.http import HttpResponse
from datetime import datetime


def hello_world(request):
    """Returns a greeting."""
    return HttpResponse("Oh, hi! current server time is {now}".format(
        now=datetime.now().strftime("%b $dth, %Y - %H:%M hrs")
    ))
