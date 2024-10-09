import os

def __get_absolute_path(sub_path: str) -> str:
    return os.path.realpath(sub_path)

PATH_OF_PATHS_FILE = __get_absolute_path(__file__)
PATH_PROJECT_ROOT = __get_absolute_path(os.path.join(PATH_OF_PATHS_FILE, "../../"))

PATH_STORAGE_FOLDER = __get_absolute_path(os.path.join(PATH_PROJECT_ROOT, "storage"))
PATH_LOGS_FOLDER = __get_absolute_path(os.path.join(PATH_STORAGE_FOLDER, "logs"))
PATH_UPLOAD_FOLDER = __get_absolute_path(os.path.join(PATH_STORAGE_FOLDER, "uploads"))