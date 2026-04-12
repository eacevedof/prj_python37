import traceback

from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.exceptions import RequestValidationError
from fastapi.responses import JSONResponse

from ddd.shared.domain.enums.response_code_enum import ResponseCodeEnum
from ddd.shared.infrastructure.routes import workitems_router
from ddd.shared.infrastructure.components.logger import Logger

fast_api = FastAPI(
    title="Azure DevOps Work Items API",
    description="API para gestionar work items en Azure DevOps",
    version="1.0.0",
)

fast_api.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@fast_api.exception_handler(RequestValidationError)
async def pydantic_validation_exception_handler(
    http_request: Request,
    request_validation_error: RequestValidationError
) -> JSONResponse:
    logger = Logger.get_instance()
    try:
        body = await http_request.body()
        body = body.decode("utf-8")
    except Exception:
        body = "<could not read body>"

    logger.write_error(
        module="azure_devops.py pydantic_validation_exception_handler",
        message=str(request_validation_error),
        context={
            "url": str(http_request.url),
            "method": http_request.method,
            "body": body,
            "errors": request_validation_error.errors(),
        }
    )
    return JSONResponse(
        status_code=ResponseCodeEnum.BAD_REQUEST,
        content={
            "code": ResponseCodeEnum.BAD_REQUEST,
            "status": "error",
            "message": "Invalid request body",
            "errors": request_validation_error.errors(),
        }
    )


@fast_api.exception_handler(Exception)
async def general_exception_handler(
    http_request: Request,
    exception_obj: Exception
) -> JSONResponse:
    logger = Logger.get_instance()
    logger.write_error(
        module="azure_devops.py general_exception_handler",
        message=str(exception_obj),
        context={
            "url": str(http_request.url),
            "method": http_request.method,
            "traceback": traceback.format_exc(),
        }
    )
    return JSONResponse(
        status_code=ResponseCodeEnum.INTERNAL_SERVER_ERROR,
        content={
            "code": ResponseCodeEnum.INTERNAL_SERVER_ERROR,
            "status": "error",
            "message": "Internal server error",
        }
    )


fast_api.include_router(workitems_router)


@fast_api.get("/health", tags=["health"])
async def health_check():
    return {"status": "ok"}
