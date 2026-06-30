import re
from typing import final
from pathlib import Path

from ddd.devops.domain.enums.local_project_const import LocalProjectConst
from ddd.devops.infrastructure.repositories.abstract_local_project_repository import (
    AbstractLocalProjectRepository,
)


@final
class LocalProjectReaderFileRepository(AbstractLocalProjectRepository):
    """Repository for reading local project setup data from files."""

    async def get_next_available_port(self, vhosts_file: str) -> int:
        """Detect the next available port from ci-apps.conf."""
        vhosts_path = Path(vhosts_file)
        content = vhosts_path.read_text(encoding="utf-8")
        ports = [int(m.group(1)) for m in re.finditer(r"Listen (\d+)", content)]

        if not ports:
            return LocalProjectConst.DEFAULT_PORT

        return max(ports) + 1
