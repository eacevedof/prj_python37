import os
from printer import *
import sys
from dotenv import load_dotenv
import requests
from tabulate import tabulate
from tokenizer import *
from prompt_toolkit import PromptSession
from prompt_toolkit.key_binding import KeyBindings
from prompt_toolkit.formatted_text import HTML
from prompt_toolkit.history import InMemoryHistory


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
    env_choice = input("select environment (dev or prod): ").strip()
    env_choice = f".{env_choice}" if env_choice in ["dev", "prod"] else ".dev"

    os.system("cls")
    is_prod = False
    if env_choice == ".prod":
        is_prod = True
        pr_red("WARNING: You are in production environment\n")
    else:
        pr_green("You are in development environment\n")

    load_dotenv(dotenv_path=env_choice)

    url = os.getenv("API_ANUBIS_DOMAIN") + os.getenv("API_ANUBIS_ENDPOINT")
    auth_token = get_anubis_auth_token()
    auth_token = get_auth_raw_token()

    pr_lemon(f"\nurl: {url}")
    pr_blue(f"token: {auth_token}\n")
    pr_yellow("paste your sql. (quit para salir, clear para limpiar)")

    history = InMemoryHistory()
    prompt_session = PromptSession(multiline=True, history=history)
    bindings = KeyBindings()

    @bindings.add("c-m")
    def _(event):
        event.app.exit(result=event.app.current_buffer.text)

    while True:
        try:
            prompt = get_red("anubis> ") if is_prod else get_green("anubis> ")
            sql = input(prompt)

            # no permite navegar por el historial :(
            # html_prompt = HTML('<ansired>anubis&gt; </ansired>') if is_prod else HTML('<ansigreen>anubis&gt; </ansigreen>')
            # sql = prompt_session.prompt(html_prompt, key_bindings=bindings)
            if sql.strip() == "":
                continue

            if sql.lower().strip() == "clear":
                os.system("cls")
                continue

            if sql.lower().strip() == "help":
                pr_blue(f"\nurl: {url}\ntoken: {auth_token}\n")
                continue

            if sql.lower().strip() == "quit":
                break

            result = __query(sql)
            if result.get("error"):
                pr_red(f"error: {result["status_code"]} {result["error"]}")
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
            pr_yellow("\nCtrl+C detected, exiting...")
            sys.exit(0)


if __name__ == "__main__":
    main()