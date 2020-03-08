# project/bootstrap/config.py
sc("project/bootstrap/config.py")

class Config:
    DEBUG = False
    TESTING = False

    SECRET_KEY = "SUPER_SECRET"

    MAIL_SERVER = "smtp.gmail.com"
    MAIL_PORT = 465
    MAIL_USE_SSL = True
    MAIL_USERNAME = "username@gmail.com"
    MAIL_PASSWORD = "xome paxxworld"

    DB_NAME = "production-db"
    DB_USERNAME = "root"
    DB_PASSWORD = "example"
    
    UPLOADS = "/home/username/app/app/static/images/uploads"

    SESSION_COOKIE_SECURE = True

# from config_development import DevelopmentConfig
# from config_production import ProductionConfig
# from config_testing import TestingConfig

