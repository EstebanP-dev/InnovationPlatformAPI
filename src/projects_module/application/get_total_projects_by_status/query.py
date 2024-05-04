from src.shared import BaseModel, Field, UUID_REGEX


class GetTotalProjectsByStatusQuery(BaseModel):
    user_id: str = Field(..., pattern=UUID_REGEX)
