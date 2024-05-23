from fastapi import APIRouter, Depends, UploadFile, File, Path
from starlette import status

from src.shared import handle_result
from ..application.create_deliverable import (CreateDeliverableCommand,
                                              CreateDeliverableCommandHandler,
                                              CreateDeliverableRequest)

from ..application.change_status import (ChangeStatusCommand,
                                         ChangeStatusCommandHandler,
                                         ChangeStatusRequest)

deliverables_router = APIRouter(prefix="/{project_id}/deliverables")


@deliverables_router.post("/", status_code=status.HTTP_201_CREATED)
async def create_deliverable(
        request: CreateDeliverableRequest,
        project_id: str = Path(..., description="The ID of the project"),
        handler: CreateDeliverableCommandHandler = Depends()):
    command = CreateDeliverableCommand(**request.model_dump(), project=project_id)

    result = await handler.handle(command)

    return handle_result(result)


@deliverables_router.post("/{deliverable_id}/changeStatus", status_code=status.HTTP_201_CREATED)
async def change_deliverable_status(
        request: ChangeStatusRequest,
        deliverable_id: str = Path(..., description="The ID of the deliverable"),
        handler: ChangeStatusCommandHandler = Depends()):
    command = ChangeStatusCommand(**request.model_dump(), deliverable_id=deliverable_id)

    result = await handler.handle(command)

    return handle_result(result)
