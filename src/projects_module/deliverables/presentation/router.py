from fastapi import APIRouter, Depends, UploadFile, File, Path
from starlette import status

from src.shared import handle_result
from ..application.create_deliverable import (CreateDeliverableCommand,
                                              CreateDeliverableCommandHandler,
                                              CreateDeliverableRequest)

deliverables_router = APIRouter(prefix="/{project_id}/deliverables")


@deliverables_router.post("/", status_code=status.HTTP_201_CREATED)
async def create_deliverable(
        request: CreateDeliverableRequest,
        project_id: str = Path(..., description="The ID of the project"),
        file: UploadFile = File(..., description="The file to upload"),
        handler: CreateDeliverableCommandHandler = Depends()):
    command = CreateDeliverableCommand(**request, project=project_id, file=file)

    result = await handler.handle(command)

    return handle_result(result)
