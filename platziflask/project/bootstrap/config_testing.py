# project/bootstrap/config_testing.py
sc("project/bootstrap/config_testing.py")
from config import Config

class TestingConfig(Config):
    TESTING = True

    