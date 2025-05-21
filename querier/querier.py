import requests
from tabulate import tabulate
from dotenv import load_dotenv
import os

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
    url = os.getenv("API_ANUBIS_URL")
    auth_token = os.getenv("API_ANUBIS_TOKEN")
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
            "error": f"url: {url}, token: {auth_token}, consulta: {sql}",
            "status_code": response.status_code
        }

    return response.json()

def main():
    while True:
        try:
            sql = input("Introduce tu consulta SQL (o 'salir' para terminar):\n\t> ")
        except EOFError:
            print()
            break
        if sql.lower() == "salir":
            break

        result = __query(sql)
        if result.get("error"):
            print(f"error: {result['status_code']} {result['error']}")
            continue

        rows = result.get("result", [])
        if not rows:
            print("Sin resultados.")
            continue

        headers = rows[0].keys()
        table = [row.values() for row in rows]
        print(tabulate(table, headers, tablefmt="grid"))

if __name__ == "__main__":
    main()