from fastapi import APIRouter, Depends

from src.shared import handle_result

from ..application import GetDeliverableTypesQuery, GetDeliverableTypesQueryHandler

deliverable_types_router = APIRouter(prefix="/deliverable_types")


@deliverable_types_router.get("/")
async def get_deliverable_types(
        handler: GetDeliverableTypesQueryHandler = Depends()
):
    query = GetDeliverableTypesQuery()

    result = await handler.handle(query)

    return handle_result(result)
