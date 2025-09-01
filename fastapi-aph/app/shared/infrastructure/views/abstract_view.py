from abc import ABC
from typing import Dict

from app.shared.infrastructure.components.replacer import Replacer


class AbstractView(ABC):
    def __init__(self):
        self.replacer = Replacer.get_instance()
    
    def _render_body_content(self, body_content: str) -> str:
        return self._get_header() + self._get_body(body_content) + self._get_footer()
    
    def _get_header(self) -> str:
        return """
    <!DOCTYPE html>
    <html>
    <head>
    <title>Lazarus Anti Phishing API</title>
    <link rel="alternate icon" type="image/png" href="https://lazarus.es/assets/imgs/template/favicon.png">
    <link rel="stylesheet" href="/assets/Modules/Documentation/Css/documentation.css">
    </head>
    """
    
    def _get_body(self, html_body: str) -> str:
        return f"""
    <body>
    {html_body}
    </body>
    """
    
    def _get_footer(self) -> str:
        return """
    <footer></footer>
    </html>
    """
    
    def _get_replaced_content(self, content: str, to_replace: Dict[str, str]) -> str:
        return self.replacer.get_replaced_content(content, to_replace)