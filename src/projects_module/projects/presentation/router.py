from fastapi import APIRouter, Depends, UploadFile, File
from typing import List
from starlette import status

from src.shared import get_tenant_id, handle_result, get_user_id

from ..application.create_project import CreateProjectRequest, CreateProjectCommand, CreateProjectCommandHandler
from ..application.get_projects import GetProjectsQuery, GetProjectsQueryHandler
from ..application.get_total_projects_by_status import (GetTotalProjectsByStatusQuery,
                                                        GetTotalProjectsByStatusQueryHandler)

projects_router = APIRouter()


@projects_router.post("/", status_code=status.HTTP_201_CREATED)
async def create_project(
        request: CreateProjectRequest,
        files: List[UploadFile] = File(..., description="Files to upload"),
        tenant_id: str = Depends(get_tenant_id),
        handler: CreateProjectCommandHandler = Depends()):
    command = CreateProjectCommand(**request.model_dump(), branch=tenant_id, files=files)

    result = handler.handle(command)

    return handle_result(result)


@projects_router.get("/")
async def get_all_projects(
        user_id: str = Depends(get_user_id),
        handler: GetProjectsQueryHandler = Depends()):
    query = GetProjectsQuery(user_id)

    result = await handler.handle(query)

    return handle_result(result)


@projects_router.get("/status")
async def get_total_projects_by_status(
        user_id: str = Depends(get_user_id),
        handler: GetTotalProjectsByStatusQueryHandler = Depends()):
    query = GetTotalProjectsByStatusQuery(user_id=user_id)

    result = await handler.handle(query)

    return handle_result(result)
