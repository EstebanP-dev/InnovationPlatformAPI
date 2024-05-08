from fastapi import Depends

from src.shared import Deleted, CommandHandler, Result, Error

from .command import DeleteProjectCommand

from ...infrastructure import ProjectsRepository


class DeleteProjectCommandHandler(CommandHandler[DeleteProjectCommand, Deleted]):
    def __init__(self,
                 repository: ProjectsRepository = Depends()):
        self._repository = repository

    async def handle(self, command: DeleteProjectCommand) -> Result[Deleted]:
        result = await self._repository.delete_entity({
            'project_id': command.project_id
        })

        if not result:
            return Result.failure(Error.unexpected('Could not delete project'))

        return Result.success(result)
