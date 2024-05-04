from src.shared import BaseModel, Optional


class LogInRequest(BaseModel):
    user_name: Optional[str] = None
    password: Optional[str] = None
