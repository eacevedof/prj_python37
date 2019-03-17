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

    numbers = [int(i) for i in request.GET["numbers"].split(",")]
    nsorted = sorted(numbers)
    # pdb.set_trace()
    return HttpResponse(json.dumps(nsorted), content_type="application/json")
