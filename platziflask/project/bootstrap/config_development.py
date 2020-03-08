# project/bootstrap/config_development.py
sc("project/bootstrap/config_development.py")
from config import Config

class DevelopmentConfig(Config):
    DEBUG = True

    