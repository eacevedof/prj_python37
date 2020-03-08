# project/bootstrap/config.py
sc("project/bootstrap/config.py")

class Config:
    DEBUG = True
    TESTING = True

    SECRET_KEY = "SUPER_SECRET"

    MAIL_SERVER = "smtp.gmail.com"
    MAIL_PORT = 465
    # MAIL_USE_TLS = False
    MAIL_USE_SSL = True
    MAIL_USERNAME = "aa@gmail.com"
    MAIL_PASSWORD = "bb"
    # MAIL_SENDER = "elsender@gmail.com"

    DB_NAME = "production-db"
    DB_USERNAME = "root"
    DB_PASSWORD = "example"
    
    UPLOADS = "/home/username/app/app/static/images/uploads"

    SESSION_COOKIE_SECURE = True

class ProductionConfig(Config):
    DATABASE_URI = "mysql://user@localhost/foo"


class DevelopmentConfig(Config):
    DEBUG = True
    
    DB_NAME = "production-db"
    DB_USERNAME = "root"
    DB_PASSWORD = "example"

    UPLOADS = "/home/username/app/app/static/images/uploads"

    SESSION_COOKIE_SECURE = False


class TestingConfig(Config):
    DEBUG = True

    DB_NAME = "development-db"
    DB_USERNAME = "root"
    DB_PASSWORD = "example"
    
    UPLOADS = "/home/username/app/app/static/images/uploads"

