import os
from datetime import datetime
from fastapi import Request
from fastapi.responses import HTMLResponse
from jinja2 import Template
from app.shared.infrastructure.components.logger import Logger

class DocumentationWebController:
    def __init__(self):
        self.logger = Logger.get_instance()
    
    @classmethod
    def get_instance(cls):
        return cls()
    
    async def invoke(self, request: Request) -> HTMLResponse:
        try:
            # Load documentation template
            documentation_path = os.path.join(
                os.path.dirname(__file__),
                "..",
                "views",
                "documentation.md"
            )
            
            with open(documentation_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # Template variables
            template_vars = {
                "app_version": os.getenv("APP_VERSION", "1.0.0"),
                "app_version_update": datetime.now().strftime("%Y-%m-%d"),
                "app_base_url": str(request.base_url).rstrip('/')
            }
            
            # Render template
            template = Template(content)
            rendered_content = template.render(**template_vars)
            
            # Convert markdown to HTML (basic conversion)
            html_content = self._markdown_to_html(rendered_content)
            
            return HTMLResponse(content=html_content)
            
        except Exception as error:
            self.logger.log_exception(error)
            return HTMLResponse(
                content="<h1>Error loading documentation</h1>",
                status_code=500
            )
    
    def _markdown_to_html(self, markdown_content: str) -> str:
        """Basic markdown to HTML conversion"""
        html = markdown_content
        
        # Headers
        html = html.replace('### ', '<h3>').replace('\\n', '</h3>\\n')
        html = html.replace('## ', '<h2>').replace('\\n', '</h2>\\n')
        html = html.replace('# ', '<h1>').replace('\\n', '</h1>\\n')
        
        # Code blocks
        html = html.replace('```json', '<pre><code class="json">')
        html = html.replace('```', '</code></pre>')
        
        # Inline code
        html = html.replace('`', '<code>', 1).replace('`', '</code>', 1)
        
        # Basic HTML structure
        return f"""
<!DOCTYPE html>
<html>
<head>
    <title>FastAPI Anti Phishing API Documentation</title>
    <style>
        body {{ font-family: Arial, sans-serif; margin: 20px; line-height: 1.6; }}
        pre {{ background: #f4f4f4; padding: 10px; border-radius: 5px; overflow-x: auto; }}
        code {{ background: #f4f4f4; padding: 2px 4px; border-radius: 3px; }}
        h1, h2, h3 {{ color: #333; }}
        .json {{ color: #d14; }}
    </style>
</head>
<body>
    {html}
</body>
</html>
        """