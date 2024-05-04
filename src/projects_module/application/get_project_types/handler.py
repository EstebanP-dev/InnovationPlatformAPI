from src.shared import Depends, QueryHandler, Result, List
from ...infrastructure import ProjectsRepository
from .response import GetProjectTypesResponse
from .query import GetProjectTypesQuery


class GetProjectTypesQueryHandler(QueryHandler[GetProjectTypesQuery, List[GetProjectTypesResponse]]):
    def __init__(self, repository: ProjectsRepository = Depends()):
        self._repository = repository

    async def handle(self, query: GetProjectTypesQuery) -> Result[List[GetProjectTypesResponse]]:
        project_types = await self._repository.get_project_types()

        response = [GetProjectTypesResponse(
            id=project_type.get('id'),
            name=project_type.get('name')
        ) for project_type in project_types]

        return Result.success(response)
