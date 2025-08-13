from dataclasses import dataclass, field
from typing import final
import os
import json
from datetime import datetime, timedelta
from config.paths import PATH_CACHE_FOLDER

@final
@dataclass(frozen=True)
class Cacher:

    __PATH_CACHE_FOLDER = PATH_CACHE_FOLDER
    cache_file_name: str
    __cache_file_path: str = field(init=False, repr=False)

    def __post_init__(self):
        object.__setattr__(
            self,
            "_Cacher__cache_file_path",
            os.path.join(self.__PATH_CACHE_FOLDER, self.cache_file_name)
        )

    @staticmethod
    def get_instance(cache_file_name: str) -> "Cacher":
        return Cacher(cache_file_name)

    def get(self, key: str) -> any:
        try:
            with open(self.__cache_file_path, "r", encoding="utf-8") as fr:
                file_raw_data = fr.read()
                data_as_json = json.loads(file_raw_data)
                value_found = data_as_json.get(key)

                if value_found:
                    now = datetime.now().timestamp() * 1000
                    if now < value_found["expiry"]:
                        return value_found["value"]

                    del data_as_json[key]
                    # se actualiza ahora sin la key expirada
                    with open(self.__cache_file_path, "w", encoding="utf-8") as fw:
                        fw.write(json.dumps(data_as_json, indent=2))
                    return None

                return None

        except FileNotFoundError:
            return None
        except Exception as error:
            raise error


    def add(self, key: str, value: any, ttl_minutes: int) -> None:
        data_as_json = {}
        try:
            with open(self.__cache_file_path, "r", encoding="utf-8") as fr:
                file_raw_data = fr.read()
                data_as_json = json.loads(file_raw_data)
        except FileNotFoundError:
            pass
        except Exception as error:
            raise error

        now = datetime.now().timestamp() * 1000
        expiry = now + ttl_minutes * 60 * 1000  # Convert minutes to milliseconds

        data_as_json[key] = {"value": value, "expiry": expiry}
        os.makedirs(self.__PATH_CACHE_FOLDER, exist_ok=True)
        with open(self.__cache_file_path, "w", encoding="utf-8") as fw:
            fw.write(json.dumps(data_as_json, indent=2))
