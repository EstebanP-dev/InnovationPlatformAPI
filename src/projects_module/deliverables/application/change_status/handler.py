from fastapi import Depends

from src.shared import CommandHandler, Result, Created

from .command import ChangeStatusCommand

from ...infrastructure import DeliverablesRepository


class ChangeStatusCommandHandler(CommandHandler[ChangeStatusCommand, Created]):
    def __init__(self, deliverable_repository: DeliverablesRepository = Depends()):
        self._deliverable_repository = deliverable_repository

    async def handle(self, command: ChangeStatusCommand) -> Result[Created]:
        await self._deliverable_repository.execute_stored_procedure_with_in_params(
            "sp_change_project_deliverable_status",
            {
                "deliverable_id": command.deliverable_id,
                "deliverable_status": command.status
            })

        return Result.success(Created())
