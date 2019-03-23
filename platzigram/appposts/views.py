""""<project>/appposts/views.py"""

# imports Django
from django.http import HttpResponse


def list_posts(request):
    """List existing posts"""
    posts = [1,2,3,4]
    return HttpResponse(str(posts))
