from enum import Enum
from typing import final


@final
class DepartmentEnum(str, Enum):
    """Department names for work item assignment."""

    DESARROLLO = "desarrollo"
    SISOPS = "sisops"
    HELPDESK = "helpdesk"
    NEGOCIO = "negocio"
    QA = "qa"
