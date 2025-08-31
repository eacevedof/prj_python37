from fastapi import APIRouter, Request, Depends
from fastapi.responses import HTMLResponse, FileResponse
from typing import Dict, Any

# Import controllers
from app.modules.documentation.infrastructure.controllers.documentation_web_controller import DocumentationWebController
from app.modules.documentation.infrastructure.controllers.changelog_web_controller import ChangelogWebController
from app.modules.healthcheck.infrastructure.controllers.get_health_check_status_controller import GetHealthCheckStatusController
from app.modules.users.infrastructure.controllers.create_user_controller import CreateUserController
from app.modules.devops.infrastructure.controllers.check_app_controller import CheckAppController
from app.modules.static_assets.infrastructure.controllers.static_assets_controller import StaticAssetsController

# Import route enums
from app.modules.documentation.infrastructure.enums.documentation_route_enum import DocumentationRouteEnum
from app.modules.healthcheck.infrastructure.enums.healthcheck_route_enum import HealthCheckRouteEnum
from app.modules.users.infrastructure.enums.users_route_enum import UsersRouteEnum

router = APIRouter()

# Documentation routes
@router.get(DocumentationRouteEnum.V1_DOCUMENTATION.value, response_class=HTMLResponse)
async def documentation(request: Request):
    return await DocumentationWebController.get_instance().invoke(request)

@router.get(DocumentationRouteEnum.CHANGELOG.value, response_class=HTMLResponse)
async def changelog(request: Request):
    return await ChangelogWebController.get_instance().invoke(request)

# Health check route
@router.get(HealthCheckRouteEnum.HEALTH_CHECK_V1.value)
async def health_check(request: Request):
    controller_response = await GetHealthCheckStatusController.get_instance().invoke(request)
    return controller_response.dict()

# Users routes
@router.post(UsersRouteEnum.CREATE_USER_V1.value)
async def create_user(request: Request, body: Dict[str, Any]):
    controller_response = await CreateUserController.get_instance().invoke(request, body)
    return controller_response.dict()

# Devops routes
@router.get("/devops/check-app")
async def check_app(request: Request):
    controller_response = await CheckAppController.get_instance().invoke(request)
    return controller_response.dict()

# Static assets route
@router.get("/static/{file_path:path}")
async def static_assets(file_path: str):
    return await StaticAssetsController.get_instance().serve_file(file_path)