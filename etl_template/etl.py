PATH_SOURCE_FILE = "./data/source.txt"
PATH_DESTINY_FILE = ""

def get_file_content(path: str) -> str:
    with open(path) as f:
        return f.read()

def file_put_contents(path: str, data: str) -> None:
    with open(path, "a") as f:
        f.write(data)

def extract():
    return ""

def transform(data):
    return ""

def load(data):
    file_put_contents(PATH_DESTINY_FILE)

def main():
    try:
        data = extract()
        data = transform(data)
        load(data)
    except Exception:
        print("Exception")

main()
