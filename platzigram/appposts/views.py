""""<project>/appposts/views.py"""

# imports Django
from django.http import HttpResponse

# utilities
from datetime import datetime

posts = [
    {
        "name": "Mont Blanc",
        "user": "Fist User",
        "timestamp": datetime.now().strftime("%b $dth, %Y - %H:%M hrs"),
        "picture": "https://picsum.photos/200/200/?image=1036",
    },
    {
        "name": "Vía Láctea",
        "user": "Second User",
        "timestamp": datetime.now().strftime("%b $dth, %Y - %H:%M hrs"),
        "picture": "https://picsum.photos/200/200/?image=903",
    },
    {
        "name": "Nuevo Auditorio",
        "user": "Third User",
        "timestamp": datetime.now().strftime("%b $dth, %Y - %H:%M hrs"),
        "picture": "https://picsum.photos/200/200/?image=1076",
    }
]

def list_posts(request):
    """List existing posts"""
    posts = [1,2,3,4]
    return HttpResponse(str(posts))
