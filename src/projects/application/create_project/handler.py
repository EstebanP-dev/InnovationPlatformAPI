from src.shared import (Depends,
                        CommandHandler,
                        Result,
                        Error,
                        Created)
from .command import CreateProjectCommand
from ...infrastructure import ProjectsRepository


class CreateProjectCommandHandler(CommandHandler[CreateProjectCommand, Created]):
    def __init__(self, project_repository: ProjectsRepository = Depends()):
        self._project_repository = project_repository

    async def handle(self, command: CreateProjectCommand) -> Result[Created]:
        result = await self._project_repository.insert_project(command)

        if not result:
            return Result.failure(Error.unexpected('Could not create project'))

        return Result.success(Created())
