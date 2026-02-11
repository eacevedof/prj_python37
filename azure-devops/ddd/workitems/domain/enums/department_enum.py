from enum import Enum
from typing import final


@final
class DepartmentEnum(str, Enum):
    DESARROLLO = "desarrollo"
    SISOPS = "sisops"
    HELPDESK = "helpdesk"
    NEGOCIO = "negocio"
    QA = "qa"
