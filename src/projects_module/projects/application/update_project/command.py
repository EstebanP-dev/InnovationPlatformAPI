from pydantic import BaseModel, Field
from typing import Optional

from src.shared import UUID_REGEX

from ...domain import ProjectStatusEnum


class UpdateProjectCommand(BaseModel):
    branch: Optional[str] = Field(None, pattern=UUID_REGEX)
    assessor: Optional[str] = Field(None, pattern=UUID_REGEX)
    type: Optional[str] = Field(None, pattern=UUID_REGEX)
    title: Optional[str] = Field(None, max_length=255, min_length=5)
    description: Optional[str] = Field(None, max_length=255, min_length=5)
    status: ProjectStatusEnum = Field(None)
