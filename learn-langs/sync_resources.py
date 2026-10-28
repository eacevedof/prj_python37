"""CLI: sincroniza los audios/imagenes locales al CDN (resources.theframework.es).

Uso:
    python sync_resources.py [--scope all|audios|images] [--dry-run]

Aplica primero las migraciones pendientes (crea las columnas *_url / *_synced_md5
si faltan) y luego sube al CDN lo que falte o haya cambiado, guardando la URL en la BD.
"""

import asyncio
import sys

from dotenv import load_dotenv

from ddd.shared.infrastructure.components.sqlite_connector import SqliteConnector
from ddd.vocabulary.infrastructure.commands.sync_resources_to_cdn_command import (
    SyncResourcesToCdnCommand,
)


def _get_args() -> dict[str, object]:
    argv = sys.argv[1:]
    scope = "all"
    dry_run = False
    index = 0
    while index < len(argv):
        arg = argv[index]
        if arg == "--scope" and index + 1 < len(argv):
            scope = argv[index + 1]
            index += 1
        elif arg.startswith("--scope="):
            scope = arg.split("=", 1)[1]
        elif arg in ("--dry-run", "--dry"):
            dry_run = True
        index += 1
    return {"scope": scope, "dry_run": dry_run}


async def _main() -> int:
    load_dotenv()
    await SqliteConnector.get_instance().initialize_database()
    return await SyncResourcesToCdnCommand.get_instance().invoke(_get_args())


if __name__ == "__main__":
    raise SystemExit(asyncio.run(_main()))
