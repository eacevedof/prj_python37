import hmac
from typing import Self, final


@final
class Tokener:
    """Comparacion de secretos.

    Parece innecesario -es una linea- y sin embargo existe por dos motivos:

    1. `hmac.compare_digest` compara en TIEMPO CONSTANTE: tarda lo mismo tanto si
       las cadenas difieren en el primer caracter como en el ultimo. Un `==`
       normal corta en cuanto encuentra una diferencia, y ese tiempo distinto,
       medido muchas veces, permite adivinar la clave caracter a caracter. Se
       llama ataque de temporizacion.
    2. Al estar en un componente, la comparacion es testeable y esta en un sitio
       con nombre, en vez de ser un `==` perdido en el front controller.

    Es un COMPONENTE: solo depende de la libreria estandar, no captura excepciones
    y no escribe logs.
    """

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def is_same_secret(self, left: str, right: str) -> bool:
        return hmac.compare_digest(left, right)
