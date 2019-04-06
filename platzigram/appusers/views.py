"""
platzigram/appusers/views.py
"""
from django.contrib.auth import authenticate, login, logout
from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required

def login_view(request):
    """Login view."""
    if request.method == "POST":
        print("*" * 10)
        username = request.POST["username"]
        password = request.POST["password"]
        print(username,":",password)
        print("*" * 10)
        user = authenticate(request,username=username,password=password)
        if user:
            print("logged")
            login(request, user)
            return redirect("feed")
        else:
            print("bad loggin")
            return render(request, "users/login.html", {"error":"Invalid username and password"})

    return render(request, "users/login.html")

@login_required
def logout_view(request):
    """
    Logout a user.
    """
    logout(request)
    return redirect("login")