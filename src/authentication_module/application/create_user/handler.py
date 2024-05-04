from src.shared import CommandHandler, Result, Error, Created, Depends, PasswordValidator
from ...infrastructure import UsersRepository, JWTProvider
from .command import CreateUserCommand


class CreateUserCommandHandler(CommandHandler[CreateUserCommand, Created]):
    def __init__(self, jwt_provider: JWTProvider = Depends(), users_repository: UsersRepository = Depends()):
        self._jwt_provider = jwt_provider
        self._users_repository = users_repository
        self._password_validator = PasswordValidator()

    async def handle(self, command: CreateUserCommand) -> Result[Created]:
        self._password_validator.validate_password(command.password)

        password_hash = self._jwt_provider.get_password_hash(command.password)

        user_data = command.model_dump()

        user_data['password_hash'] = password_hash

        result = await self._users_repository.create_user(user_data=user_data)

        if not result:
            return Result.failure(Error.unexpected('Could not create user'))

        return Result.success(Created())
