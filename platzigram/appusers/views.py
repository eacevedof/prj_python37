"""
platzigram/appusers/views.py
"""
from pprint import pprint
from django.contrib.auth import authenticate, login, logout
from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.db.utils import IntegrityError
import pdb 

#Models
from django.contrib.auth.models import User
from appusers.models import Profile

# Forms
from appusers.forms import ProfileForm

@login_required
def update_profile(request):
    """Update a users profile view."""
    pprint(request.FILES)
    profile = request.user.profile

    if request.method == "POST":
        form = ProfileForm(request.POST, request.FILES)
        if form.is_valid():
            data = form.cleaned_data
            profile.website = data["website"]
            profile.phone_number = data["phone_number"]
            profile.biography = data["biography"]
            profile.picture = data["picture"]
            profile.save()

            pprint("profile")
            pprint(profile)

            return redirect("update_profile")
    else:
        form = ProfileForm()

    return render(
        request=request
        ,template_name="users/update_profile.html",
        context = {
            "profile": profile,
            "user": request.user,
            "form": form
        })


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

def signup_view(request):
    """Sign up view"""
    # pdb.set_trace() # pausa la consola para meter comandos de depuración: request.POST

    if request.method == "POST":
        username = request.POST["signup-username"]
        passw = request.POST["signup-password"]
        password_confirmation = request.POST["signup-password-confirmation"]
    
        if passw != password_confirmation:
            return render(request,"users/signup.html",{"error":"Pass confrimation does not match!"})

        # try ya que puede fallar si ya existiera el username
        try:
            user = User.objects.create_user(username = username,password = passw)
        except IntegrityError:
            return render(request,"users/signup.html", {"error":"Username already exists"})

        #despues de guardar el usuario en la bd
        user.first_name = request.POST["signup-firstname"]
        user.last_name = request.POST["signup-lastname"]
        user.email = request.POST["signup-email"]
        user.save()

        #creamos inmediatamente el perfil
        profile = Profile(user=user)
        profile.save()
        return redirect("login")

    return render(request,"users/signup.html")

