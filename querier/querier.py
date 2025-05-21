import sys
from dotenv import load_dotenv
import requests
from tabulate import tabulate
from printer import *
from tokenizer import *

load_dotenv()

def __query_history():
    import readline
    import atexit
    # Configura historial de consultas
    histfile = ".sql_query_history"
    try:
        readline.read_history_file(histfile)
    except FileNotFoundError:
        pass
    atexit.register(readline.write_history_file, histfile)


def __query(sql):
    url = os.getenv("API_ANUBIS_DOMAIN") + os.getenv("API_ANUBIS_ENDPOINT")
    auth_token = get_anubis_auth_token()
    auth_token = get_auth_raw_token()

    headers = {
        "Content-Type": "application/json",
        "Authorization": auth_token
    }
    data = {
        "sql": sql,
    }

    response = requests.post(url, headers=headers, json=data)
    if response.status_code != 200:
        return {
            "error": f"url: {url}, token: {auth_token}, query: {sql}",
            "status_code": response.status_code
        }

    return response.json()


def main():
    url = os.getenv("API_ANUBIS_DOMAIN") + os.getenv("API_ANUBIS_ENDPOINT")
    auth_token = get_anubis_auth_token()
    auth_token = get_auth_raw_token()

    pr_blue(f"\nurl: {url}\ntoken: {auth_token}\n")
    pr_yellow("SQL or (quit + enter), (ctrl+c)")

    while True:
        try:
            sql = input(get_yellow("anubis> "))
            if sql == "":
                continue

            if sql.lower() == "clear":
                os.system("cls")
                continue

            if sql.lower() == "help":
                pr_blue(f"\nurl: {url}\ntoken: {auth_token}\n")
                continue

            if sql.lower() == "quit" or (len(sql) == 1 and ord(sql) == 24):  # Ctrl+X es 24 en ASCII
                break

            result = __query(sql)
            if result.get("error"):
                pr_red(f"error: {result['status_code']} {result['error']}")
                continue

            rows = result.get("result", [])
            if not rows:
                pr_blue("empty result")
                continue

            headers = rows[0].keys()
            table = [row.values() for row in rows]
            pr_white(tabulate(table, headers, tablefmt="grid"))

        except EOFError:
            pr_red("EOF")
            break
        except KeyboardInterrupt:
            pr_yellow("\nCtrl+C detected quiting...")
            sys.exit(0)


if __name__ == "__main__":
    main()