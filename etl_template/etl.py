from os.path import exists, realpath
from os import unlink

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

def transform(data) -> str:
    return ""

def load(path, data) -> None:
    if exists(path):
        unlink(path)
    file_put_contents(path, data)

def main():
    print("process start")
    try:
        print("- Extracting ...")
        data = extract(PATH_SOURCE_FILE)
        print("- Transforming ...")
        data = transform(data)
        print("- Loading ...")
        load(PATH_TARGET_FILE, data)
        target_path = realpath(PATH_TARGET_FILE)
        print(f"etl finished!\nrun command:\n\ncat {target_path}\n")
    except Exception:
        print("Exception")

main()
