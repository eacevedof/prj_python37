from os.path import exists, realpath
from os import unlink
import json
from pprint import pprint

PATH_SOURCE_FILE = "./data/source.txt"
PATH_TARGET_FILE = "./data/target.json"


def get_file_content(path: str) -> str:
    if not exists(path):
        return ""
    with open(path) as f:
        return f.read()


def file_put_contents(path: str, data: str) -> None:
    with open(path, "a") as f:
        f.write(data)


def extract(path: str) -> str:
    content = get_file_content(path)
    return content.strip(" ")

def load(path, data) -> None:
    if exists(path):
        unlink(path)
    file_put_contents(path, data)


def handle_exception(ex: Exception) -> None:
    if hasattr(ex, "message"):
        print(ex.message)
    else:
        print(repr(ex))


def transform(data: str) -> str:
    if not data:
        return ""

    lines = data.split("\n")
    content = []
    for line in lines:
        values = line.split(";")
        content.append({
            "id": values[0],
            "value": values[1]
        })
    return json.dumps(content)


def main():
    print("process start")
    try:
        print("- Extracting ...")
        data = extract(PATH_SOURCE_FILE)
        print("- Transforming ...")
        data = transform(data)
        pprint(data)
        print("- Loading ...")
        load(PATH_TARGET_FILE, data)
        target_path = realpath(PATH_TARGET_FILE)
        print(f"etl finished!\nrun command:\n\ncat {target_path}\n")
    except Exception as ex:
        handle_exception(ex)


main()
