"""views.py"""

import pdb
from django.http import HttpResponse
from datetime import datetime
import json

def hello_world(request):
    """Returns a greeting."""
    return HttpResponse("Oh, hi! current server time is {now}".format(
        now=datetime.now().strftime("%b $dth, %Y - %H:%M hrs")
    ))



def sort_integers(request):
    """sort_integers."""
    # request.GET = <QueryDict: {'numbers': ['10,4,50,32']}>
    numbers = [int(i) for i in request.GET["numbers"].split(",")]
    nsorted = sorted(numbers)

    data = {
        "status": "ok",
        "numbers": nsorted,
        "message": "Integers sorted susccesfully."
    }

    # pdb.set_trace()
    return HttpResponse(
        json.dumps(data,indent=4),
        content_type="application/json"
    )

def say_hi(request,name,age):
    """hi/<str:name>/<int:age>/"""
    # pdb.set_trace()
    # con GET no va, pq realmente no hay nada en la url como: ?k=v&k2=v2
    # name = request.GET["nombre"]
    # age = request.GET["edad"]
    if age<12:
        message = "Sorry {}, you are not allowed here".format(name)
    else:
        message = "Hello {}!, Welcome to Platzigram".format(name)
    return HttpResponse(message)
