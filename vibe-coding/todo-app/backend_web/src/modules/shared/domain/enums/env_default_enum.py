from typing import final

from src.modules.shared.domain.enums.environment_enum import EnvironmentEnum


@final
class EnvDefaultEnum:
    """Que vale cada variable cuando NO esta definida.

    Estan aqui juntos, y no repartidos como segundo argumento de cada `get()`,
    porque un valor por defecto es una DECISION: es lo que pasa cuando alguien se
    olvida de configurar algo. Verlos todos en una pantalla permite preguntarse
    "¿y si falta esta?" de un vistazo.

    La eleccion importante es **ENVIRONMENT = production**. Si `APP_ENV` no
    llega, la aplicacion se comporta como si estuviera en produccion: sin
    depuracion y sin trazas hacia fuera.

    Es lo contrario de lo comodo, y es a proposito. El olvido tipico es
    desplegar sin `APP_ENV`; si el valor por defecto fuera `local`, ese olvido
    abriria la depuracion en un servidor publico y nadie se enteraria. Con este,
    el olvido solo hace que veas menos informacion de la que querias, que se
    arregla en diez segundos.
    """

    ENVIRONMENT = EnvironmentEnum.PRODUCTION.value
    DEBUG = "0"
    LOG_PATH = "storage/logs"
    DB_PATH = "storage/database/todo_app.db"
    TIME_ZONE = "UTC"
    # La apikey NO tiene valor por defecto, y eso tambien es una decision: sin
    # ella la API rechaza todo con 401. Una credencial por defecto seria una
    # credencial conocida.
    API_KEY = ""
