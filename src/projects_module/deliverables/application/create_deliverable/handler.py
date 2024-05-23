from fastapi import Depends
import uuid

from src.shared import CommandHandler, Result, Created
from .command import CreateDeliverableCommand
from ...domain import InsertDeliverableEntity
from ...infrastructure import DeliverablesRepository


class CreateDeliverableCommandHandler(CommandHandler[CreateDeliverableCommand, Created]):
    def __init__(self, deliverable_repository: DeliverablesRepository = Depends()):
        self._deliverable_repository = deliverable_repository

    async def handle(self, command: CreateDeliverableCommand) -> Result[Created]:
        deliverable = InsertDeliverableEntity(
            project_id=command.project,
            type_id=command.type,
            deliverable_id=str(uuid.uuid4()),
            deliverable_status=command.status,
            deliverable_name=command.name,
            deliverable_url=command.url,
            deliverable_description=command.description
        )

        await self._deliverable_repository.insert_entity(deliverable)

        return Result.success(Created())
