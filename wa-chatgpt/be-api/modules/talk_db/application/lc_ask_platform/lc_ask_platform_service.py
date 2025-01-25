from typing import final

from modules.shared.infrastructure.components.log import Log

from modules.talk_db.application.lc_ask_platform.lc_ask_platform_dto import LcAskPlatformDTO
from modules.talk_db.application.lc_ask_platform.lc_asked_platform_dto import LcAskedPlatformDTO

@final
class LcAskPlatformService:

    @staticmethod
    def get_instance() -> "LcAskPlatformService":
        return LcAskPlatformService()


    def invoke(self, lc_ask_platform: LcAskPlatformDTO) -> LcAskedPlatformDTO:
        str_response = ":)"
        return LcAskedPlatformDTO(chat_response=f"{str_response}")




