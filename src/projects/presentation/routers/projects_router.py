from src.shared import Depends
from src.shared.presentation import APIRouter, status, handle_result, get_user_id
from ...application import (
    CreateProjectCommand,
    CreateProjectCommandHandler,
    CreateProjectRequest,
    GetProjectsQuery,
    GetProjectsQueryHandler)

projects_router = APIRouter()


@projects_router.post("/", status_code=status.HTTP_201_CREATED)
async def create_project(
        request: CreateProjectRequest,
        user_id: str = Depends(get_user_id),
        handler: CreateProjectCommandHandler = Depends()):
    command = CreateProjectCommand(**request.model_dump(), user_id=user_id)

    result = handler.handle(command)

    return handle_result(result)


@projects_router.get("/")
async def get_all_projects(
        user_id: str = Depends(get_user_id),
        handler: GetProjectsQueryHandler = Depends()):
    query = GetProjectsQuery(user_id)

    result = await handler.handle(query)

    return handle_result(result)
