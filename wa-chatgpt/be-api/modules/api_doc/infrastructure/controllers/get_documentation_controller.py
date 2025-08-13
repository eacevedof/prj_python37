from flask import Request

from modules.api_doc.infrastructure.views.documentation_tpl import render


def invoke(request: Request) -> str:
    return render()
