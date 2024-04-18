from src.shared import Depends
from src.shared.presentation import APIRouter, status, handle_result
from ...application import GetAuthorialMembersQuery, GetAuthorialMembersQueryHandler

authorial_members_router = APIRouter(
    prefix="/authors")


@authorial_members_router.get("/for_creation", status_code=status.HTTP_200_OK)
async def get_authorial_members(handler: GetAuthorialMembersQueryHandler = Depends()):
    query = GetAuthorialMembersQuery()
    result = await handler.handle(query)

    return handle_result(result)
