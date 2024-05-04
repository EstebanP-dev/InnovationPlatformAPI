from src.shared import Depends
from src.shared.presentation import APIRouter, status, handle_result
from ...application import GetProjectTypesQuery, GetProjectTypesQueryHandler

project_types_router = APIRouter(
    prefix="/types")


@project_types_router.get("/for_creation", status_code=status.HTTP_200_OK)
async def get_project_types(handler: GetProjectTypesQueryHandler = Depends()):
    query = GetProjectTypesQuery()
    result = await handler.handle(query)

    return handle_result(result)
