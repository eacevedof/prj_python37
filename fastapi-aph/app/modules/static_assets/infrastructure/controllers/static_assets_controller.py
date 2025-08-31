import os
from fastapi import HTTPException
from fastapi.responses import FileResponse
from app.shared.infrastructure.components.logger import Logger

class StaticAssetsController:
    def __init__(self):
        self.logger = Logger.get_instance()
        self.static_dir = os.path.join(
            os.path.dirname(__file__),
            "..",
            "static"
        )
    
    @classmethod
    def get_instance(cls):
        return cls()
    
    async def serve_file(self, file_path: str) -> FileResponse:
        """Serve static files (CSS, JS, images)"""
        try:
            # Security check: prevent directory traversal
            if ".." in file_path or file_path.startswith("/"):
                raise HTTPException(status_code=403, detail="Access denied")
            
            full_path = os.path.join(self.static_dir, file_path)
            
            # Check if file exists
            if not os.path.exists(full_path) or not os.path.isfile(full_path):
                raise HTTPException(status_code=404, detail="File not found")
            
            # Determine media type based on extension
            media_type = self._get_media_type(file_path)
            
            return FileResponse(
                path=full_path,
                media_type=media_type,
                headers={"Cache-Control": "public, max-age=3600"}  # 1 hour cache
            )
            
        except HTTPException:
            raise
        except Exception as error:
            self.logger.log_exception(error)
            raise HTTPException(status_code=500, detail="Internal server error")
    
    def _get_media_type(self, file_path: str) -> str:
        """Determine media type based on file extension"""
        extension = os.path.splitext(file_path)[1].lower()
        
        media_types = {
            '.css': 'text/css',
            '.js': 'application/javascript',
            '.png': 'image/png',
            '.jpg': 'image/jpeg',
            '.jpeg': 'image/jpeg',
            '.gif': 'image/gif',
            '.svg': 'image/svg+xml',
            '.ico': 'image/x-icon',
            '.woff': 'font/woff',
            '.woff2': 'font/woff2',
            '.ttf': 'font/ttf',
            '.eot': 'application/vnd.ms-fontobject'
        }
        
        return media_types.get(extension, 'application/octet-stream')