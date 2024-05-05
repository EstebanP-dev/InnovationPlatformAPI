from src.shared import APIRouter, Depends, handle_result, status

from ..application import GetProjectAssessorsQuery, GetProjectAssessorsQueryHandler

assessors_router = APIRouter(
    prefix="/assessors")


@assessors_router.get("/", status_code=status.HTTP_200_OK)
async def get_project_assessors(handler: GetProjectAssessorsQueryHandler = Depends()):
    query = GetProjectAssessorsQuery()
    result = await handler.handle(query)

    return handle_result(result)
