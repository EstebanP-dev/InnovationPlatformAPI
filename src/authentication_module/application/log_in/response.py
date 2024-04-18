from src.shared import BaseModel


class LogInResponse(BaseModel):
    access_token: str
    token_type: str
