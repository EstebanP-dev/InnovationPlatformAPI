from fastapi import APIRouter, Depends
from starlette import status

from src.shared import get_tenant_id, handle_result, get_user_id
from ..application.create_project import CreateProjectRequest, CreateProjectCommand, CreateProjectCommandHandler
from ..application.delete_project import DeleteProjectCommand, DeleteProjectCommandHandler
from ..application.get_projects import GetProjectsQuery, GetProjectsQueryHandler
from ..application.get_total_projects_by_status import (GetTotalProjectsByStatusQuery,
                                                        GetTotalProjectsByStatusQueryHandler)
from ..application.update_project import UpdateProjectCommand, UpdateProjectCommandHandler

projects_router = APIRouter()


@projects_router.post("/", status_code=status.HTTP_201_CREATED)
async def create_project(
        request: CreateProjectRequest,
        tenant_id: str = Depends(get_tenant_id),
        handler: CreateProjectCommandHandler = Depends()):
    command = CreateProjectCommand(**request.model_dump(), branch=tenant_id)

    result = await handler.handle(command)

    return handle_result(result)


@projects_router.put("/{project_id}", status_code=status.HTTP_200_OK)
async def update_project(
        project_id: str,
        request: CreateProjectRequest,
        tenant_id: str = Depends(get_tenant_id),
        handler: UpdateProjectCommandHandler = Depends()):
    command = UpdateProjectCommand(project_id, **request.model_dump(), branch=tenant_id)

    result = await handler.handle(command)

    return handle_result(result)


@projects_router.get("/")
async def get_all_projects(
        user_id: str = Depends(get_user_id),
        handler: GetProjectsQueryHandler = Depends()):
    query = GetProjectsQuery(user_id=user_id)

    result = await handler.handle(query)

    return handle_result(result)


@projects_router.get("/status")
async def get_total_projects_by_status(
        user_id: str = Depends(get_user_id),
        handler: GetTotalProjectsByStatusQueryHandler = Depends()):
    query = GetTotalProjectsByStatusQuery(user_id=user_id)

    result = await handler.handle(query)

    return handle_result(result)


@projects_router.get("/{project_id}")
async def get_project(
        project_id: str,
        handler: GetProjectsQueryHandler = Depends()):
    query = GetProjectsQuery(project_id=project_id)

    result = await handler.handle(query)

    return handle_result(result)


@projects_router.delete("/{project_id}", status_code=status.HTTP_200_OK)
async def delete_project(
        project_id: str,
        handler: DeleteProjectCommandHandler = Depends()):
    command = DeleteProjectCommand(project_id=project_id)

    result = await handler.handle(command)

    return handle_result(result)
