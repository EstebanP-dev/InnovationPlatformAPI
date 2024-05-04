from fastapi.security import OAuth2PasswordRequestForm

from src.shared import Depends, Result
from src.shared.presentation import APIRouter, status, handle_result

from ...application import (LogInCommand,
                            LogInRequest,
                            LogInCommandHandler,
                            GetCurrentUserQuery,
                            GetCurrentUserQueryHandler)

token_router = APIRouter(prefix="/token")


@token_router.post("/", status_code=status.HTTP_200_OK)
async def log_in(
        request: LogInRequest,
        handler: LogInCommandHandler = Depends()):
    command = LogInCommand(**request.model_dump())
    result = await handler.handle(command)

    return handle_result(result)


@token_router.get("/current",
                  status_code=status.HTTP_200_OK)
async def get_current_user(handler: GetCurrentUserQueryHandler = Depends()):
    query = GetCurrentUserQuery()
    result = await handler.handle(query)

    return handle_result(result)
