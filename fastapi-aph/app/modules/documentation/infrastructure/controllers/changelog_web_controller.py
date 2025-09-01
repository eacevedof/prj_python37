import os
from datetime import datetime
from fastapi import Request
from fastapi.responses import HTMLResponse
from jinja2 import Template
from typing import final
from app.shared.infrastructure.components.logger import Logger

@final
class ChangelogWebController:
    def __init__(self):
        self.logger = Logger.get_instance()
    
    @classmethod
    def get_instance(cls):
        return cls()
    
    async def invoke(self, request: Request) -> HTMLResponse:
        try:
            # Load changelog template
            changelog_path = os.path.join(
                os.path.dirname(__file__),
                "..",
                "views",
                "changelog.md"
            )
            
            with open(changelog_path, 'r', encoding='utf-8') as f:
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
                content="<h1>Error loading changelog</h1>",
                status_code=500
            )
    
    def _markdown_to_html(self, markdown_content: str) -> str:
        """Basic markdown to HTML conversion"""
        html = markdown_content
        
        # Headers
        html = html.replace('#### ', '<h4>').replace('\\n', '</h4>\\n')
        html = html.replace('### ', '<h3>').replace('\\n', '</h3>\\n')
        html = html.replace('## ', '<h2>').replace('\\n', '</h2>\\n')
        html = html.replace('# ', '<h1>').replace('\\n', '</h1>\\n')
        
        # Lists
        lines = html.split('\\n')
        processed_lines = []
        in_list = False
        
        for line in lines:
            if line.strip().startswith('- '):
                if not in_list:
                    processed_lines.append('<ul>')
                    in_list = True
                processed_lines.append(f'<li>{line.strip()[2:]}</li>')
            else:
                if in_list:
                    processed_lines.append('</ul>')
                    in_list = False
                processed_lines.append(line)
        
        if in_list:
            processed_lines.append('</ul>')
        
        html = '\\n'.join(processed_lines)
        
        # Basic HTML structure
        return f"""
<!DOCTYPE html>
<html>
<head>
    <title>FastAPI Anti Phishing API Changelog</title>
    <style>
        body {{ font-family: Arial, sans-serif; margin: 20px; line-height: 1.6; }}
        h1, h2, h3, h4 {{ color: #333; }}
        ul {{ padding-left: 20px; }}
        li {{ margin: 5px 0; }}
    </style>
</head>
<body>
    {html}
</body>
</html>
        """