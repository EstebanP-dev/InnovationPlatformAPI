from fastapi import UploadFile, File

from src.shared import Depends, List
from src.shared.presentation import APIRouter, status, handle_result, get_user_id, get_tenant_id
from ...application import (
    CreateProjectCommand,
    CreateProjectCommandHandler,
    CreateProjectRequest,
    GetProjectsQuery,
    GetProjectsQueryHandler,
    GetTotalProjectsByStatusQuery,
    GetTotalProjectsByStatusQueryHandler)

from .project_assessors_router import project_assessors_router
from .authorial_members_router import authorial_members_router
from .project_types_router import project_types_router

projects_router = APIRouter(prefix="/projects", tags=["Projects"])

projects_router.include_router(authorial_members_router)
projects_router.include_router(project_assessors_router)
projects_router.include_router(project_types_router)


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


@projects_router.get("/status/total")
async def get_total_projects_by_status(
        user_id: str = Depends(get_user_id),
        handler: GetTotalProjectsByStatusQueryHandler = Depends()):
    query = GetTotalProjectsByStatusQuery(user_id=user_id)

    result = await handler.handle(query)

    return handle_result(result)
