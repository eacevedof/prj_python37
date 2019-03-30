""""<project>/appposts/views.py"""

# imports Django
# from django.http import HttpResponse
from django.contrib.auth.decorators import login_required
from django.shortcuts import render


# utilities
from datetime import datetime

posts = [
    {
        "title": "Mont Blanc",
        "user": {
            "name": "User Name 10",
            "picture": "https://randomuser.me/api/portraits/men/10.jpg",
        },
        "timestamp": datetime.now().strftime("%b %dth, %Y - %H:%M hrs"),
        "photo": "https://picsum.photos/200/200/?image=1036",
    },
    {
        "title": "Vía Láctea",
        "user": {
            "name": "User Name 20",
            "picture": "https://randomuser.me/api/portraits/men/20.jpg",
        },
        "timestamp": datetime.now().strftime("%b %dth, %Y - %H:%M hrs"),
        "photo": "https://picsum.photos/200/200/?image=903",
    },
    {
        "title": "Nuevo Auditorio",
        "user": {
            "name": "User Name 30",
            "picture": "https://randomuser.me/api/portraits/men/30.jpg",
        },
        "timestamp": datetime.now().strftime("%b %dth, %Y - %H:%M hrs"),
        "photo": "https://picsum.photos/200/200/?image=1076",
    }
]

@login_required
def list_posts(request):
    """List existing posts"""

    return render(request,"posts/feed.html",{"posts":posts})
