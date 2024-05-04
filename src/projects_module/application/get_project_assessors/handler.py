from src.shared import Depends, QueryHandler, Result, List
from ...infrastructure import ProjectsRepository
from . import query as q, response as r


class GetProjectAssessorsQueryHandler(QueryHandler[q.GetProjectAssessorsQuery, List[r.GetProjectAssessorsResponse]]):
    def __init__(self, repository: ProjectsRepository = Depends()):
        self._repository = repository

    async def handle(self, query: q.GetProjectAssessorsQuery) -> Result[List[r.GetProjectAssessorsResponse]]:
        project_assessors = await self._repository.get_available_assessors()

        response = [r.GetProjectAssessorsResponse(
            id=authorial_member.get('id'),
            avatar=authorial_member.get('avatar'),
            full_name=f"{authorial_member.get('given_name')} {authorial_member.get('family_name')}"
        ) for authorial_member in project_assessors]

        return Result.success(response)
