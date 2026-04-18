from fastapi import APIRouter, Depends

from ddd.workitems.infrastructure.controllers import (
    CreateEpicRequestPyd,
    CreateEpicController,
    CreateTaskRequestPyd,
    CreateTaskController,
    GetTasksRequestPyd,
    GetTasksController,
    UpdateTaskRequestPyd,
    UpdateTaskController,
)

router = APIRouter(prefix="/workitems", tags=["workitems"])

@router.post("/epics")
async def create_epic(request_pyd: CreateEpicRequestPyd):
    response = await CreateEpicController.get_instance()(request_pyd)
    return response.to_dict()


@router.post("/tasks")
async def create_task(request_pyd: CreateTaskRequestPyd):
    response = await CreateTaskController.get_instance()(request_pyd)
    return response.to_dict()


@router.get("/tasks")
async def get_tasks(request_pyd: GetTasksRequestPyd = Depends()):
    response = await GetTasksController.get_instance()(request_pyd)
    return response.to_dict()


@router.patch("/tasks/{task_id}")
async def update_task(task_id: int, request_pyd: UpdateTaskRequestPyd):
    response = await UpdateTaskController.get_instance()(task_id, request_pyd)
    return response.to_dict()
