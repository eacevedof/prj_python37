from typing import Self, final

from src.modules.{{modulo}}_mod.application.{{caso_de_uso}}.{{caso_de_uso}}_dto import {{CasoDeUso}}Dto
from src.modules.{{modulo}}_mod.application.{{caso_de_uso}}.{{caso_de_uso}}_result_dto import (
    {{CasoDeUso}}ResultDto,
)
from src.modules.{{modulo}}_mod.domain.exceptions.{{modulo}}_exception import {{Modulo}}Exception
from src.modules.{{modulo}}_mod.infrastructure.repositories.{{modulo}}_writer_sqlite_repository import (
    {{Modulo}}WriterSqliteRepository,
)


@final
class {{CasoDeUso}}Service:
    """Caso de uso: <describe en una linea que hace>."""

    # 1. Los colaboradores se DECLARAN aqui, con su tipo. De aqui saca el tipo el
    #    test de contratos para comprobar que los metodos que llamas existen.
    _{{caso_de_uso}}_dto: {{CasoDeUso}}Dto
    _{{modulo}}_writer_sqlite_repository: {{Modulo}}WriterSqliteRepository

    def __init__(self) -> None:
        # 2. Siempre con get_instance(). Nunca Clase() directo.
        self._{{modulo}}_writer_sqlite_repository = {{Modulo}}WriterSqliteRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def __call__(self, {{caso_de_uso}}_dto: {{CasoDeUso}}Dto) -> {{CasoDeUso}}ResultDto:
        """Ejecuta el caso de uso.

        Returns:
            {{CasoDeUso}}ResultDto: <que devuelve>.

        Raises:
            {{Modulo}}Exception: 400 entrada invalida, 404 no existe.
        """
        # 3. Lo primero: guardar el DTO y validar.
        self._{{caso_de_uso}}_dto = {{caso_de_uso}}_dto
        self._fail_if_wrong_input()

        # 4. La logica. SIN try/except: si algo falla, sube al controller.

        return {{CasoDeUso}}ResultDto.from_primitives({})

    def _fail_if_wrong_input(self) -> None:
        """Toda la validacion de entrada, junta y al principio."""
        if not self._{{caso_de_uso}}_dto:
            {{Modulo}}Exception.bad_request_custom("<campo> es obligatorio")
