from src.shared import APIRouter, Depends, handle_result, status

from ..application import GetAuthorsQuery, GetAuthorsQueryHandler

authors_router = APIRouter(
    prefix="/authors")


@authors_router.get("/", status_code=status.HTTP_200_OK)
async def get_project_assessors(handler: GetAuthorsQueryHandler = Depends()):
    query = GetAuthorsQuery()
    result = await handler.handle(query)

    return handle_result(result)
