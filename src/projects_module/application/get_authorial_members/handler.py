from src.shared import Depends, QueryHandler, Result, List
from ...infrastructure import ProjectsRepository
from . import query as q, response as r


class GetAuthorialMembersQueryHandler(QueryHandler[q.GetAuthorialMembersQuery, List[r.GetAuthorialMembersResponse]]):
    def __init__(self, repository: ProjectsRepository = Depends()):
        self._repository = repository

    async def handle(self, query: q.GetAuthorialMembersQuery) -> Result[List[r.GetAuthorialMembersResponse]]:
        authorial_members = await self._repository.get_available_authorial_members()

        response = [r.GetAuthorialMembersResponse(
            id=authorial_member.get('id'),
            avatar=authorial_member.get('avatar'),
            full_name=f"{authorial_member.get('given_name')} {authorial_member.get('family_name')}"
        ) for authorial_member in authorial_members]

        return Result.success(response)
