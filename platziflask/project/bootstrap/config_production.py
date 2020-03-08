# project/app/config_production.py
sc("project/app/config_production.py")
from config import Config

class ProductionConfig(Config):
    DATABASE_URI = "mysql://user@localhost/foo"

    