import os


def get_absolute_path(sub_path: str) -> str:
    return os.path.realpath(sub_path)


def is_file(path: str) -> bool:
    return os.path.isfile(path)
