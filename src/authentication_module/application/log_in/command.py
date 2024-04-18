from src.shared import BaseModel, Field, List, Optional


class LogInCommand(BaseModel):
    user_name: str = Field(..., max_length=255, min_length=5)
    password: str = Field(..., max_length=255, min_length=5)
