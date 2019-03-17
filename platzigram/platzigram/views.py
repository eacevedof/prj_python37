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



def hi(request):
    """Hi."""
    # request.GET = <QueryDict: {'numbers': ['10,4,50,32']}>
    # print(request)
    # pdb.set_trace() # frena la ejecución y permite interactuar con la consola
    # return HttpResponse("hi")
    sNumbers = request.GET["numbers"]
    lstNumbers = sNumbers.split(",")
    lstNumbers = [int(sI) for sI in lstNumbers]
    lstNumbers.sort()
    return HttpResponse(json.dumps(lstNumbers), content_type="application/json")
