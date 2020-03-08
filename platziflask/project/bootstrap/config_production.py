# project/app/config.py
sc("project/app/config.py")
class Config:
    SECRET_KEY = "SUPER_SECRET"
    MAIL_SERVER = "smtp.gmail.com"
    MAIL_PORT = 465
    MAIL_USE_SSL = True
    MAIL_USERNAME = "username@gmail.com"
    MAIL_PASSWORD = "xome paxxworld"
    # self.flaskapp.config["MAIL_USERNAME"] = "@gmail.com"
    # self.flaskapp.config["MAIL_PASSWORD"] = ""

class ProductionConfig(Config):
    DATABASE_URI = "mysql://user@localhost/foo"

class DevelopmentConfig(Config):
    DEBUG = True

class TestingConfig(Config):
    TESTING = True

    