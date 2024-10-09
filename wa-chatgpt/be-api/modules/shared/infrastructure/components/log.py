import logging
import os
from datetime import datetime
from modules.shared.infrastructure.components.var_export import dump

PATH_LOGS_FOLDER = os.path.dirname(os.path.abspath(__file__))
PATH_LOGS_FOLDER = PATH_LOGS_FOLDER + "../../../storage/logs"
PATH_LOGS_FOLDER = os.path.abspath(PATH_LOGS_FOLDER)

TODAY = datetime.today().strftime("%Y-%m-%d")


def file_put_contents(path_file: str, str_data:str) -> None:
    try:
        print(path_file)
        with open(path_file, "a") as f:
            f.write(str_data)
    except IOError:
        logging.error(f"__file_put_contents: error writing to file: {path_file}")


class Log:

    @staticmethod
    def __get_today() -> str:
        return datetime.today().strftime("%Y-%m-%d")


    @staticmethod
    def __get_now() -> str:
        return datetime.today().strftime("%Y-%m-%d %H:%M:%S")


    @staticmethod
    def __log_in_file(content: str, file_name: str) -> None:
        today = Log.__get_today()
        now = Log.__get_now()
        content = f"\n[{now}]\n{content}"
        extension = "log"
        if file_name == "sql":
            extension = "sql"
        file_put_contents(f"{PATH_LOGS_FOLDER}/{file_name}-{today}.{extension}", content)


    @staticmethod
    def log_debug(mixed, title=""):
        if not callable(logging.debug):
            return

        content = mixed if isinstance(mixed, str) else dump(mixed)
        if title:
            content = f"{title}\n\t{content}"

        logging.info(f"{content}")
        Log.__log_in_file(content, "debug")


    @staticmethod
    def log_sql(sql, title=""):
        if not callable(logging.info):
            return

        content = sql
        if title:
            content = f"{title}\n\t{content}"

        logging.info(f"{content}")
        Log.__log_in_file(content, "sql")


    @staticmethod
    def log_error(mixed, title="ERROR"):
        if not callable(logging.error):
            return

        content = mixed if isinstance(mixed, str) else dump(mixed)
        if title:
            content = f"{title}\n\t{content}"

        logging.error(f"{content}")
        Log.__log_in_file(content, "error")


    @staticmethod
    def log_exception(throwable, title="EXCEPTION"):
        content = []
        if title:
            content.append(title)

        content.append(f"ex file:\n\t{throwable.__traceback__.tb_frame.f_code.co_filename}")
        content.append(f"ex line:\n\t{throwable.__traceback__.tb_lineno}")
        content.append(f"ex code:\n\t{type(throwable).__name__}")
        content.append(f"ex message:\n\t{str(throwable)}")
        #content.append(f"ex trace:\n\t{''.join(throwable.__traceback__.format())}")
        content = "\n".join(content)
        logging.error(f"{content}")
        Log.__log_in_file(content, "error")