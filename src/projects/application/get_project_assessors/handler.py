from src.shared import Depends, QueryHandler, Result, List
from ...infrastructure import ProjectAssessorsRepository
from . import query as q, response as r


class GetProjectAssessorsQueryHandler(QueryHandler[q.GetProjectAssessorsQuery, List[r.GetProjectAssessorsResponse]]):
    def __init__(self, project_assessor_repository: ProjectAssessorsRepository = Depends()):
        self._project_assessor_repository = project_assessor_repository

    async def handle(self, query: q.GetProjectAssessorsQuery) -> Result[List[r.GetProjectAssessorsResponse]]:
        project_assessors = self._project_assessor_repository.from_view()
        response = [r.GetProjectAssessorsResponse(
            id=authorial_member.get('id'),
            avatar=authorial_member.get('avatar'),
            full_name=f"{authorial_member.get('given_name')} {authorial_member.get('family_name')}"
        ) for authorial_member in project_assessors]

        return Result.success(response)
