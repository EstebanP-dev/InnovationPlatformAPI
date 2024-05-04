import os
from datetime import timedelta, datetime, timezone
from jose import jwt

from dotenv import load_dotenv
from passlib.context import CryptContext

from src.shared import Depends, Result, Error


load_dotenv()

SECRET_KEY = os.getenv("SECRET_KEY")
ALGORITHM = os.getenv("ALGORITHM")
ACCESS_TOKEN_EXPIRE_MINUTES = int(os.getenv("ACCESS_TOKEN_EXPIRE_MINUTES"))


class JWTProvider:
    def __init__(self):
        self._pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
        self._secret_key = SECRET_KEY
        self._algorithm = ALGORITHM
        self._access_token_expire_minutes = ACCESS_TOKEN_EXPIRE_MINUTES

    def verify_password(self, plain_password: str, hashed_password: str):
        return self._pwd_context.verify(plain_password, hashed_password)

    def get_password_hash(self, password: str):
        return self._pwd_context.hash(password)

    def create_access_token(self, data: dict, expires_delta: timedelta or None = None) -> str:
        to_encode = data.copy()

        if expires_delta:
            expire = datetime.now(timezone.utc) + expires_delta
        else:
            expire = datetime.now(timezone.utc) + timedelta(minutes=self._access_token_expire_minutes)

        to_encode.update({'exp': expire})
        encoded_jwt = jwt.encode(to_encode, self._secret_key, algorithm=self._algorithm)

        return encoded_jwt

    def get_access_token_expires(self) -> timedelta:
        return timedelta(minutes=self._access_token_expire_minutes)
