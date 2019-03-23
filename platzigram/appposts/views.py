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
    contents = []
    for post in posts:
        contents.append("""
            <p><strong>{name}</strong></p>
            <p><strong>{user} - <i>{timestamp}</i></strong></p>
            <figure><img src="{picture}"/></figure>
        """.format(**post))

    return HttpResponse("<br/>".join(contents))
