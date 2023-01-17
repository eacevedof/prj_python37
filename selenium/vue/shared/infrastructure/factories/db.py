import pyodbc

CONFIG = {
    "driver": "{ODBC Driver 18 for SQL Server}",
    "server": "tcp:localhost",
    "database": "local_laciahub",
    "user": "sa",
    "password": "EafEaf1234",
}


def get_db() -> object:
    driver = CONFIG.get("driver")
    server = CONFIG.get("server")
    database = CONFIG.get("database")
    username = CONFIG.get("user")
    password = CONFIG.get("password")
    cnxn = pyodbc.connect(
        f"DRIVER={driver};SERVER={server};DATABASE={database};ENCRYPT=yes;UID={username};PWD={password}"
    )
    cursor = cnxn.cursor()
    return cursor
