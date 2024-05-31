import uuid

from src.shared import (Depends,
                        CommandHandler,
                        Result,
                        Error,
                        Updated)
from .command import UpdateProjectCommand
from ...domain import UpdateProjectEntity
from ...infrastructure import ProjectsRepository
from ....deliverable_types import DeliverableTypesRepository


class UpdateProjectCommandHandler(CommandHandler[UpdateProjectCommand, Updated]):
    def __init__(self,
                 project_repository: ProjectsRepository = Depends(),
                 deliverable_types_repository: DeliverableTypesRepository = Depends()):
        self._project_repository = project_repository
        self._deliverable_types_repository = deliverable_types_repository

    async def handle(self, command: UpdateProjectCommand) -> Result[Updated]:
        authors_str = None

        if command.authors:
            authors_str = ','.join(command.authors)

        entity = UpdateProjectEntity(
            project_id=command.project_id,
            assessor_id=command.assessor,
            project_type_id=command.type,
            project_title=command.title,
            project_description=command.description,
            project_status=command.status,
            project_authors_str=authors_str
        )

        result = await self._project_repository.update_entity(entity)
        if not result:
            return Result.failure(Error.unexpected('Could not update the project'))

        return Result.success(Updated())
