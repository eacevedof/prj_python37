"""
https://www.mytecbits.com/internet/python/connect-sql-server-from-python-on-macos

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap microsoft/mssql-release https://github.com/Microsoft/homebrew-mssql-release
brew update
brew install msodbcsql18 mssql-tools
xcode-select --install
"""
import pyodbc

CONFIG = {
    "driver": "{ODBC Driver 18 for SQL Server}",
    "server": "tcp:localhost,1433",
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
