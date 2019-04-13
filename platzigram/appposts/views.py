""""<project>/appposts/views.py"""

# imports Django
import sys
from pprint import pprint
from django.contrib.auth.decorators import login_required
from django.shortcuts import render, redirect

# Models
from appposts.models import Post

# Form
from appposts.forms import PostForm

@login_required
def list_posts(request):
    """List existing posts"""
    posts = Post.objects.all().order_by("-created")
    # pprint(posts)
    # sys.exit()
    return render(request,"posts/feed.html",{"posts":posts})

@login_required
def create_post(request):
    """Create new post"""
    if request.method == "POST":
        form = PostForm(request.POST,request.FILES)
        if form.is_valid():
            form.save()
            return redirect("feed")
    else:
        form = PostForm()

    return render(
        request=request,
        template_name="posts/new.html",
        context={
            "form": form,
            "user": request.user,
            "profile": request.user.profile
        }
    )
