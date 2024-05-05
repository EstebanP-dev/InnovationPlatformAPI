from src.shared import Depends, QueryHandler, Result, List

from .query import GetDeliverableTypesQuery
from .response import GetDeliverableTypesResponse

from ...infrastructure import DeliverableTypesRepository


class GetDeliverableTypesQueryHandler(QueryHandler[GetDeliverableTypesQuery, List[GetDeliverableTypesResponse]]):
    def __init__(self, repository: DeliverableTypesRepository = Depends()):
        self._repository = repository

    async def handle(self, query: GetDeliverableTypesQuery) -> Result[List[GetDeliverableTypesResponse]]:
        deliverable_types = await self._repository.get_deliverable_types()

        response = [GetDeliverableTypesResponse(
            id=deliverable_type.get('id'),
            name=deliverable_type.get('name'),
            extension=deliverable_type.get('extension')
        ) for deliverable_type in deliverable_types]

        return Result.success(response)
