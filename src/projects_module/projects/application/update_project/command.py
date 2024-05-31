from pydantic import BaseModel, Field
from typing import Optional, List

from src.shared import UUID_REGEX

from ...domain import ProjectStatusEnum


class UpdateProjectCommand(BaseModel):
    project_id: str = Field(..., pattern=UUID_REGEX)
    branch: str = Field(..., pattern=UUID_REGEX)
    assessor: Optional[str] = Field(None, pattern=UUID_REGEX)
    type: Optional[str] = Field(None, pattern=UUID_REGEX)
    title: Optional[str] = Field(None, max_length=255, min_length=5)
    authors: Optional[List[str]] = Field(None, min_items=1, max_items=2)
    description: Optional[str] = Field(None, max_length=255, min_length=5)
    status: Optional[ProjectStatusEnum] = Field(None)
