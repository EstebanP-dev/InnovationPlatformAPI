from src.shared import (Depends,
                        CommandHandler,
                        Result,
                        Error)

from .command import LogInCommand
from .response import LogInResponse

from ...infrastructure import UsersRepository, JWTProvider


class LogInCommandHandler(CommandHandler[LogInCommand, LogInResponse]):
    def __init__(self, jwt_provider: JWTProvider, user_repository: UsersRepository = Depends()):
        self._jwt_provider = jwt_provider
        self._user_repository = user_repository

    async def handle(self, command: LogInCommand) -> Result[LogInResponse]:
        user_result = await self.get_authenticated_user(command.user_name, command.password)

        if user_result.is_failure:
            return Result.failure(user_result.errors)

        access_token_expires = self._jwt_provider.get_access_token_expires()
        access_token = self._jwt_provider.create_access_token(data={
            'sub': command.user_name,
        }, expires_delta=access_token_expires)

        return Result.success(LogInResponse(access_token=access_token, token_type='bearer'))

    async def get_authenticated_user(self, user_name: str, password: str) -> Result[any]:
        user = await self._user_repository.get_user(user_name)

        if not user:
            return Result.failure(Error.unauthorized('Invalid email or password'))

        if not self._jwt_provider.verify_password(password, user.password_hash):
            return Result.failure(Error.unauthorized('Invalid email or password'))

        return Result.success(user)
