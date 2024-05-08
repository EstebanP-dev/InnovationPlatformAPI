from pydantic import BaseModel, Field
from typing import Optional

from src.shared import UUID_REGEX


class GetProjectsQuery(BaseModel):
    user_id: Optional[str] = Field(None, pattern=UUID_REGEX)
    project_id: Optional[str] = Field(None, pattern=UUID_REGEX)
