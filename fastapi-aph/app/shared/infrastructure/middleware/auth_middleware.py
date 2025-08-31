from fastapi import Request, HTTPException
from starlette.middleware.base import BaseHTTPMiddleware
from starlette.responses import Response
from app.shared.infrastructure.components.logger import Logger

class AuthMiddleware(BaseHTTPMiddleware):
    def __init__(self, app):
        super().__init__(app)
        self.logger = Logger.get_instance()
        
        # Routes that don't require authentication
        self.public_routes = [
            "/",
            "/changelog",
            "/health",
            "/docs",
            "/redoc",
            "/openapi.json",
            "/static"
        ]
    
    async def dispatch(self, request: Request, call_next):
        # Skip authentication for public routes
        if self._is_public_route(request.url.path):
            return await call_next(request)
        
        # Skip authentication for static assets
        if request.url.path.startswith("/static/"):
            return await call_next(request)
        
        # Log request for security monitoring
        self._log_request(request)
        
        response = await call_next(request)
        return response
    
    def _is_public_route(self, path: str) -> bool:
        """Check if route is in public routes list"""
        return any(path.startswith(route) for route in self.public_routes)
    
    def _log_request(self, request: Request):
        """Log request details for security monitoring"""
        self.logger.log_info("API Request", {
            "method": request.method,
            "path": request.url.path,
            "remote_ip": request.client.host if request.client else "unknown",
            "user_agent": request.headers.get("user-agent", "unknown"),
            "headers": dict(request.headers)
        })