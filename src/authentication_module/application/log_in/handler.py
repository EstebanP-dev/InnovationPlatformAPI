from src.shared import (Depends,
                        CommandHandler,
                        Result,
                        Error)

from .command import LogInCommand
from .response import LogInResponse

from ...infrastructure import UsersRepository, JWTProvider


class LogInCommandHandler(CommandHandler[LogInCommand, LogInResponse]):
    def __init__(self, jwt_provider: JWTProvider = Depends(), user_repository: UsersRepository = Depends()):
        self._jwt_provider = jwt_provider
        self._user_repository = user_repository

    async def handle(self, command: LogInCommand) -> Result[LogInResponse]:
        user_exists, password_hash = await self._user_repository.user_exists(command.user_name)

        if not user_exists:
            return Result.failure(Error.unauthorized('Invalid email or password'))

        if not self._jwt_provider.verify_password(command.password, password_hash):
            return Result.failure(Error.unauthorized('Invalid email or password'))

        access_token_expires = self._jwt_provider.get_access_token_expires()
        access_token = self._jwt_provider.create_access_token(data={
            'sub': command.user_name,
        }, expires_delta=access_token_expires)

        response = LogInResponse(access_token=access_token, token_type='bearer')

        return Result.success(response)
