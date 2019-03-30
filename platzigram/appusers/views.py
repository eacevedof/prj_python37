"""
platzigram/appusers/views.py
"""
from django.contrib.auth import authenticate, login
from django.shortcuts import render, redirect


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
