from typing import Any
from modules.api_doc.infrastructure.views.documentation_tpl import render


def invoke(request: Any) -> str:
    return render()