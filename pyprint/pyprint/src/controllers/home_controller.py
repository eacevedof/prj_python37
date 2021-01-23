from src.services.home_service import HomeService
import sys
import os

class HomeController:
    def __init__(self):
        pass

    def index(self):
        r = (HomeService()).get_index()
        return r
