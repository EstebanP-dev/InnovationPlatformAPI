import os
from dotenv import load_dotenv
from fastapi import HTTPException
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from jose import JWTError, jwt
from datetime import timedelta, datetime, timezone
from passlib.context import CryptContext
from starlette import status

from src.shared import Depends, Result, Error

load_dotenv()

SECRET_KEY = os.getenv("SECRET_KEY")
ALGORITHM = os.getenv("ALGORITHM")
ACCESS_TOKEN_EXPIRE_MINUTES = int(os.getenv("ACCESS_TOKEN_EXPIRE_MINUTES"))

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")


class JWTProvider:
    def __init__(self):
        self._pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

    def verify_password(self, plain_password: str, hashed_password: str):
        return self._pwd_context.verify(plain_password, hashed_password)

    def get_password_hash(self, password: str):
        return self._pwd_context.hash(password)

    def create_access_token(self, data: dict, expires_delta: timedelta or None = None) -> str:
        to_encode = data.copy()

        if expires_delta:
            expire = datetime.now(timezone.utc) + expires_delta
        else:
            expire = datetime.now(timezone.utc) + timedelta(minutes=15)

        to_encode.update({'exp': expire})
        encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)

        return encoded_jwt

    def get_access_token_expires(self) -> timedelta:
        return timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)

    def get_token_sub(self, token: str = Depends(oauth2_scheme)):
        failure_result = Result.failure(Error.unauthorized('Could not validate credentials'))
        credentials_exception = HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail=failure_result.dic(),
            headers={"WWW-Authenticate": "Bearer"})

        try:
            payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
            field: str = payload.get("sub")

            if field is None:
                raise credentials_exception

            return field
        except JWTError:
            raise credentials_exception
