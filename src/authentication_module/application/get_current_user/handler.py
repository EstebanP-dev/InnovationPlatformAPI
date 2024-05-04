import json
from src.shared import (Depends,
                        QueryHandler,
                        Result)
from .query import GetCurrentUserQuery
from .response import GetCurrentUserResponse

from ...infrastructure import AuthorizeProvider


class GetCurrentUserQueryHandler(QueryHandler[GetCurrentUserQuery, GetCurrentUserResponse]):
    def __init__(self, auth_provider: AuthorizeProvider = Depends()):
        self._auth_provider = auth_provider

    async def handle(self, query: GetCurrentUserQuery) -> Result[GetCurrentUserResponse]:
        result = await self._auth_provider.get_current_user()

        if result.is_failure:
            return Result.failure(result.errors)

        user = result.value
        user['roles'] = json.loads(user['roles'])

        response = GetCurrentUserResponse(**user)

        return Result.success(response)
