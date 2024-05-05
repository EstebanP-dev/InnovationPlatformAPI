from src.shared import Depends, QueryHandler, Result, List
from .query import GetAuthorsQuery
from .response import GetAuthorsResponse
from ...infrastructure import ProjectAuthorsRepository


class GetAuthorsQueryHandler(QueryHandler[GetAuthorsQuery, List[GetAuthorsResponse]]):
    def __init__(self, repository: ProjectAuthorsRepository = Depends()):
        self._repository = repository

    async def handle(self, query: GetAuthorsQuery) -> Result[List[GetAuthorsResponse]]:
        authors = await self._repository.get_authors()

        response = [GetAuthorsResponse(
            id=author.get('id'),
            avatar=author.get('avatar'),
            full_name=f"{author.get('given_name')} {author.get('family_name')}"
        ) for author in authors]

        return Result.success(response)
