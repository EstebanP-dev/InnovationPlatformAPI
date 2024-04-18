from src.shared import Depends
from src.shared.presentation import APIRouter, status, handle_result
from ...application import GetProjectAssessorsQuery, GetProjectAssessorsQueryHandler

project_assessors_router = APIRouter(
    prefix="/assessors")


@project_assessors_router.get("/for_creation", status_code=status.HTTP_200_OK)
async def get_project_assessors(handler: GetProjectAssessorsQueryHandler = Depends()):
    query = GetProjectAssessorsQuery()
    result = await handler.handle(query)

    return handle_result(result)
