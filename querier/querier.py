import requests
from tabulate import tabulate
from dotenv import load_dotenv
import os

load_dotenv()  # Carga el archivo .env

def __query(sql):
    url = os.getenv("API_ANUBIS_URL")
    headers = {
        "Content-Type": "application/json",
        "Authorization": os.getenv("API_ANUBIS_TOKEN")
    }
    data = {
        "sql": sql,
    }

    response = requests.post(url, headers=headers, json=data)
    if response.status_code != 200:
        return {
            "error": "Error en la petición",
            "status_code": response.status_code
        }

    return response.json()


def main():
    while True:
        sql = input("Introduce tu consulta SQL (o 'salir' para terminar): ")
        if sql.lower() == "salir":
            break

        data = __query(sql)
        rows = data.get("result", [])
        if not rows:
            print("Sin resultados.")
            continue

        headers = rows[0].keys()
        table = [row.values() for row in rows]
        print(tabulate(table, headers, tablefmt="grid"))

if __name__ == "__main__":
    main()