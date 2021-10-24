from os.path import exists

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
    file_put_contents(path, data)

def main():
    try:
        data = extract(PATH_SOURCE_FILE)
        data = transform(data)
        load(PATH_TARGET_FILE, data)
    except Exception:
        print("Exception")

main()
