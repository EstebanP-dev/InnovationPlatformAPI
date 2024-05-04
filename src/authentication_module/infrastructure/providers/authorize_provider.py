from jose import JWTError, jwt
from fastapi.security import OAuth2PasswordBearer

from src.shared import Depends, Result, Error, Success, Any
from ..repositories import UsersRepository

from .jwt_provider import SECRET_KEY, ALGORITHM

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="api/v1/auth/token")


class AuthorizeProvider:
    def __init__(self,
                 users_repository: UsersRepository = Depends(),
                 token: str = Depends(oauth2_scheme)):
        self._users_repository = users_repository
        self._token = token

    async def authorize(self) -> Result[Success]:
        failure_result = Result.failure(Error.unauthorized('Could not validate credentials'))

        result = await self.decode_token()

        if result.is_failure:
            return Result.failure(result.errors)

        user_exists, _ = await self._users_repository.user_exists(result.value)

        if not user_exists:
            return failure_result

        return Result.success(Success())

    async def get_current_user(self) -> Result[Any]:
        result = await self.decode_token()

        if result.is_failure:
            return Result.failure(result.errors)

        field = result.value

        user = await self._users_repository.get_user(field)

        if user is None:
            return Result.failure(Error.not_found('User not found.'))

        return Result.success(user)

    async def decode_token(self) -> Result[str]:
        failure_result = Result.failure(Error.unauthorized('Could not validate credentials'))

        try:
            payload = jwt.decode(self._token, SECRET_KEY, algorithms=[ALGORITHM])
            field: str = payload.get("sub")

            if field is None:
                return failure_result

            return Result.success(field)
        except JWTError:
            return failure_result
