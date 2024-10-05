import logging
import os

import os

def get_project_root() -> str:
    return os.path.dirname(os.path.abspath(__file__))

# Example usage
project_root = get_project_root()
print(f"Project root directory: {project_root}")



def file_put_contents(path_file: str, str_data:str) -> None:
    try:
        with open(path_file, "a") as f:
            f.write(str_data)
    except IOError:
        logging.error(f"__file_put_contents: error writing to file: {path_file}")



class Log:
    @staticmethod
    def log_debug(mixed, title=""):
        if not callable(logging.debug):
            return

        content = mixed if isinstance(mixed, str) else repr(mixed)
        if title:
            content = f"\n{title}\n\t{content}"
        content = f"[DEBUG]\n{content}"
        logging.debug(content)

    @staticmethod
    def log_sql(sql, title=""):
        if not callable(logging.info):
            return

        content = sql
        if title:
            content = f"\n{title}\n\t{content}"
        content = f"[SQL]\n{content}"
        logging.info(content)

    @staticmethod
    def log_error(mixed, title=""):
        if not callable(logging.error):
            return

        content = mixed if isinstance(mixed, str) else repr(mixed)
        if title:
            content = f"\n{title}\n\t{content}"
        content = f"[ERROR]\n{content}"
        logging.error(content)

    @staticmethod
    def log_exception(throwable, title="ERROR"):
        content = []
        if title:
            content.append(title)

        content.append(f"ex file:\n\t{throwable.__traceback__.tb_frame.f_code.co_filename}")
        content.append(f"ex line:\n\t{throwable.__traceback__.tb_lineno}")
        content.append(f"ex code:\n\t{type(throwable).__name__}")
        content.append(f"ex message:\n\t{str(throwable)}")
        #content.append(f"ex trace:\n\t{''.join(throwable.__traceback__.format())}")
        content = "\n".join(content)
        content = f"[ERROR]\n{content}"
        file_put_contents(project_root + "/logs/exceptions.log", content)
        logging.error(content)