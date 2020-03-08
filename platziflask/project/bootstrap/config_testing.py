# project/bootstrap/config_testing.py
sc("project/bootstrap/config_testing.py")
from config import Config

class TestingConfig(Config):
    DEBUG = True

    DB_NAME = "development-db"
    DB_USERNAME = "root"
    DB_PASSWORD = "example"
    
    UPLOADS = "/home/username/app/app/static/images/uploads"