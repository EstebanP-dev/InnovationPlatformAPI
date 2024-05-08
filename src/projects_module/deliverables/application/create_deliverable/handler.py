from fastapi import Depends

from src.shared import CommandHandler, Result, Error, Created, FirebaseProvider, List

from .command import CreateDeliverableCommand

from ...domain import InsertDeliverableEntity
from ...infrastructure import DeliverablesRepository


class CreateDeliverableCommandHandler(CommandHandler[CreateDeliverableCommand, Created]):
    def __init__(self,
                 deliverable_repository: DeliverablesRepository = Depends(),
                 firebase_provider: FirebaseProvider = Depends()):
        self._deliverable_repository = deliverable_repository
        self._firebase_provider = firebase_provider

    async def handle(self, command: CreateDeliverableCommand) -> Result[Created]:
        deliverable_file_name = f"{command.project}/{command.identifier}.{command.file.filename.split('.')[-1]}"
        deliverable_url = await self._firebase_provider.upload_file(deliverable_file_name, command.file)

        deliverable = InsertDeliverableEntity(
            type=command.type,
            name=command.name,
            url=deliverable_url,
            description=command.description
        )

        await self._deliverable_repository.insert_deliverable(deliverable)

        return Result.success(Created(data=deliverable.dict()))
