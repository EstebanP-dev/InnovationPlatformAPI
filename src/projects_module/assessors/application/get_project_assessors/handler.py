from src.shared import Depends, QueryHandler, Result, List
from .query import GetProjectAssessorsQuery
from .response import GetProjectAssessorsResponse
from ...infrastructure import ProjectAssessorsRepository


class GetProjectAssessorsQueryHandler(QueryHandler[GetProjectAssessorsQuery, List[GetProjectAssessorsResponse]]):
    def __init__(self, repository: ProjectAssessorsRepository = Depends()):
        self._repository = repository

    async def handle(self, query: GetProjectAssessorsQuery) -> Result[List[GetProjectAssessorsResponse]]:
        project_assessors = await self._repository.get_assessors()

        response = [GetProjectAssessorsResponse(
            id=assessor.get('id'),
            avatar=assessor.get('avatar'),
            full_name=f"{assessor.get('given_name')} {assessor.get('family_name')}"
        ) for assessor in project_assessors]

        return Result.success(response)
