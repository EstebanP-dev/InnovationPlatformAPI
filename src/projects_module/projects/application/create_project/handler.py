import uuid

from src.shared import (Depends,
                        CommandHandler,
                        Result,
                        Error,
                        FirebaseProvider)
from .command import CreateProjectCommand
from ...domain import ProjectEntity
from ...infrastructure import ProjectsRepository
from ....deliverable_types import DeliverableTypesRepository


class CreateProjectCommandHandler(CommandHandler[CreateProjectCommand, str]):
    def __init__(self,
                 project_repository: ProjectsRepository = Depends(),
                 deliverable_types_repository: DeliverableTypesRepository = Depends(),
                 firebase_provider: FirebaseProvider = Depends()):
        self._project_repository = project_repository
        self._deliverable_types_repository = deliverable_types_repository
        self._firebase_provider = firebase_provider

    async def handle(self, command: CreateProjectCommand) -> Result[str]:
        project_id = uuid.uuid4()

        authors_str = ','.join(command.authors)

        entity = ProjectEntity(
            assessor_id=command.assessor,
            project_id=project_id,
            project_type_id=command.type,
            project_title=command.title,
            project_description=command.description,
            project_status=command.status,
            authors_str=authors_str
        )

        result = await self._project_repository.insert_project(entity)
        if not result:
            return Result.failure(Error.unexpected('Could not create project'))

        return Result.success(result)
