from pydantic import BaseModel, Field

from src.shared import UUID_REGEX


class DeleteProjectCommand(BaseModel):
    project_id: str = Field(..., pattern=UUID_REGEX)
