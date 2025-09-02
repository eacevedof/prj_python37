import uvicorn
from typing import final

from app.shared.infrastructure.enums.env_key_enum import EnvKeyEnum
from app.shared.infrastructure.components.date_timer import DateTimer
from app.shared.infrastructure.components.cli.cli_color import CliColor
from app.shared.infrastructure.repositories.configuration.environment_reader_raw_repository import EnvironmentReaderRawRepository
from app.main import app # uvicorn starter


@final
class FrontController:

    @staticmethod
    def invoke() -> None:
        env_reader = EnvironmentReaderRawRepository.get_instance()
        date_timer = DateTimer.get_instance()
        now = date_timer.get_now_ymd_his()
        
        print(f"[{now}]", env_reader.get_env_vars())
        
        port = int(env_reader._get_env(EnvKeyEnum.APP_PORT) or "8000")
        host = env_reader._get_env(EnvKeyEnum.APP_HOST) or "0.0.0.0"
        
        CliColor.echo_green(f"[{now}] running FastAPI server on {host}:{port}")
        
        uvicorn.run(
            app,
            host=host,
            port=port,
            log_level="info"
        )


if __name__ == "__main__":
    FrontController.invoke()