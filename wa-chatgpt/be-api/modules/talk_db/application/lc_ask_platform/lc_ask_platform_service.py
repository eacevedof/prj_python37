from typing import final

from modules.shared.infrastructure.components.log import Log
from modules.shared.infrastructure.components.db.mysql_context_dto import MysqlContextDto


from modules.talk_db.application.lc_ask_platform.lc_ask_platform_dto import LcAskPlatformDTO
from modules.talk_db.application.lc_ask_platform.lc_asked_platform_dto import LcAskedPlatformDTO



@final
class LcAskPlatformService:

    @staticmethod
    def get_instance() -> "LcAskPlatformService":
        return LcAskPlatformService()


    def invoke(self, lc_ask_platform: LcAskPlatformDTO) -> LcAskedPlatformDTO:
        str_response = ":)"
        # obtener los datos del contexto desde postgres
        # montar el contexto en base a este resultado
        # obtener el esquema de tablas con sus campos
        # montar la informacion en sk_learn
        # obtener la query a ejecutar en mysql
        # ejecutar la query en mysql



        return LcAskedPlatformDTO(chat_response=f"{str_response}")




