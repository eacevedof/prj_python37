from typing import Any, Dict, Protocol, final
from fastapi import Request

from app.shared.infrastructure.enums.environment_enum import EnvironmentEnum
from app.shared.infrastructure.bootstrap.app_global_map import AppGlobalMap
from app.shared.infrastructure.repositories.configuration.environment_reader_raw_repository import EnvironmentReaderRawRepository
from app.shared.infrastructure.components.logger import Logger
from app.shared.infrastructure.components.cli.cli_color import CliColor


class ControllerProtocol(Protocol):
    async def invoke(self, lz_request: Dict[str, Any]) -> Any:
        ...


@final
class Invoker:
    @staticmethod
    def get_instance():
        return Invoker()
    
    async def async_invoke_controller(
        self,
        request: Request,
        controller: ControllerProtocol
    ) -> Dict[str, Any]:
        environment_reader = EnvironmentReaderRawRepository.get_instance()
        
        # Create lz_request from FastAPI request
        lz_request = await self.__get_default_lz_request_by_request(request)
        lz_request["body"] = await self.__get_resolved_request_body(request)
        
        if not environment_reader.is_production():
            print("async_invoke_controller.lz_request\n", lz_request)
        
        AppGlobalMap.get_instance()
        Logger.get_instance({
            "request_ip": lz_request["remote_ip"],
            "request_uri": lz_request["url"],
        })
        
        lz_response = await controller.invoke(lz_request)
        primitives = lz_response.to_primitives() if hasattr(lz_response, 'to_primitives') else lz_response
        
        return primitives
    
    async def __get_default_lz_request_by_request(self, request: Request) -> Dict[str, Any]:
        return {
            "remote_ip": request.client.host if request.client else "",
            "url": str(request.url),
            "method": request.method,
            "headers": dict(request.headers),
            "query_params": dict(request.query_params),
        }
    
    async def __get_resolved_request_body(self, request: Request) -> Dict[str, Any]:
        try:
            content_type = request.headers.get("content-type", "")
            
            if "application/json" in content_type:
                return await request.json()
            elif "application/x-www-form-urlencoded" in content_type:
                form_data = await request.form()
                return dict(form_data)
            elif "multipart/form-data" in content_type:
                form_data = await request.form()
                return dict(form_data)
            else:
                CliColor.echo_yellow("unknown body type, skipping input data")
                return {}
        except Exception:
            return {}