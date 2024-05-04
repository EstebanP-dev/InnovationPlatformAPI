from src.shared import Depends, Result, Created
from src.shared.presentation import APIRouter, status, handle_result, get_tenant_id

from ...application import (GetCurrentUserResponse,
                            GetCurrentUserQueryHandler,
                            GetCurrentUserQuery,
                            CreateUserCommand,
                            CreateUserCommandHandler,
                            CreateUserRequest)

user_router = APIRouter(prefix="/users")


@user_router.post("/",
                  status_code=status.HTTP_201_CREATED)
async def create_user(
        user: CreateUserRequest,
        tenant_id: str = Depends(get_tenant_id),
        handler: CreateUserCommandHandler = Depends()):
    command = CreateUserCommand(**user.model_dump(), branch=tenant_id)

    result = await handler.handle(command)

    return handle_result(result)
