from src.shared import Depends, QueryHandler, Result, List
from ...infrastructure import AuthorialMembersRepository
from . import query as q, response as r


class GetAuthorialMembersQueryHandler(QueryHandler[q.GetAuthorialMembersQuery, List[r.GetAuthorialMembersResponse]]):
    def __init__(self, authorial_member_repository: AuthorialMembersRepository = Depends()):
        self._authorial_member_repository = authorial_member_repository

    async def handle(self, query: q.GetAuthorialMembersQuery) -> Result[List[r.GetAuthorialMembersResponse]]:
        authorial_members = self._authorial_member_repository.from_view()
        response = [r.GetAuthorialMembersResponse(
            id=authorial_member.get('id'),
            avatar=authorial_member.get('avatar'),
            full_name=f"{authorial_member.get('given_name')} {authorial_member.get('family_name')}"
        ) for authorial_member in authorial_members]

        return Result.success(response)
