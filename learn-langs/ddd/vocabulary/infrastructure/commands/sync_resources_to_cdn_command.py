"""Comando CLI que sincroniza los recursos locales (audios/imagenes) al CDN.

Es el unico punto que captura excepciones (contrato DDD): mapea la excepcion de
dominio a exit code 1 y cualquier otra a exit code 2 (+ log). Vive en commands/
(no en controllers/) para no arrastrar los controllers de UI (flet/pygame) al
ejecutar el sync por linea de comandos.
"""

import json
import sys
import traceback
from typing import Any, Self, final

from ddd.shared.infrastructure.components.logger import Logger
from ddd.vocabulary.application.sync_resources_to_cdn.sync_resources_to_cdn_dto import (
    SyncResourcesToCdnDto,
)
from ddd.vocabulary.application.sync_resources_to_cdn.sync_resources_to_cdn_service import (
    SyncResourcesToCdnService,
)
from ddd.vocabulary.domain.exceptions.vocabulary_exception import VocabularyException


@final
class SyncResourcesToCdnCommand:
    """Entry point CLI del caso de uso SyncResourcesToCdn."""

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._sync_resources_to_cdn_service = SyncResourcesToCdnService.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def invoke(self, args: dict[str, Any]) -> int:
        try:
            sync_resources_to_cdn_result_dto = await self._sync_resources_to_cdn_service(
                SyncResourcesToCdnDto.from_primitives(args)
            )
            print(json.dumps(sync_resources_to_cdn_result_dto.to_dict(), ensure_ascii=False, indent=2))
            return 0 if sync_resources_to_cdn_result_dto.success else 1
        except VocabularyException as vocabulary_exception:
            print(f"[error] {vocabulary_exception.message}", file=sys.stderr)
            return 1
        except Exception as unexpected_error:
            self._logger.log_error(
                module="SyncResourcesToCdnCommand.invoke",
                message=str(unexpected_error),
                context={"traceback": traceback.format_exc()},
            )
            print(f"[error] {unexpected_error}", file=sys.stderr)
            return 2
