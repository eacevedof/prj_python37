"""platzigram\middleware.py"""

# Django
import pdb
from django.shortcuts import redirect
from django.urls import reverse

class ProfileCompletionMiddleware:
    """Profile completion middleware
    
    Ensure every user that has picture and biography
    """

    def __init__(self, fn_get_response):
        self.get_response = fn_get_response

    # __call__ implements function call operator.
    # de modo que se pueda hacer un o = Foo() o(call_arg1,call_arg2...)
    def __call__(self, request):
        """Code to be executed for each request before the view is called."""
        if not request.user.is_anonymous:
            profile = request.user.profile
            # pdb.set_trace()
            if not profile.picture or not profile.biography:
                # si la url es update_profile o logout no se aplica el redirect
                if request.path not in [reverse("update_profile"),reverse("logout")]:
                    return redirect("update_profile")

        # pdb.set_trace()
        # get_response es una función
        response = self.get_response(request)
        return response


