import os
from pathlib import Path

from dotenv import load_dotenv

_bootstrapped = False


def __app_bootstrap() -> None:
    global _bootstrapped
    if _bootstrapped:
        return

    _bootstrapped = True

    from ddd.shared.domain.enums.envvars_keys_enum import EnvvarsKeysEnum

    env_file_path = Path(__file__).resolve().parent.parent / ".env"
    if not env_file_path.exists():
        raise FileNotFoundError(f"environment file not found in: {env_file_path}")

    load_dotenv(dotenv_path=str(env_file_path), override=False)

    raw_log_path = os.getenv(EnvvarsKeysEnum.APP_LOG_PATH)
    if raw_log_path:
        log_path = Path(raw_log_path)
        if not log_path.is_absolute():
            log_path = (env_file_path.parent / log_path).resolve()
        os.environ[EnvvarsKeysEnum.APP_LOG_PATH] = str(log_path)


__app_bootstrap()
