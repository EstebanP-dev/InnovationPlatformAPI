from src.shared import BaseModel, Field, UUID_REGEX, Optional

from ...domain import ProjectStatusEnum


class CreateProjectCommand(BaseModel):
    branch: str = Field(..., pattern=UUID_REGEX)
    assessor: str = Field(..., pattern=UUID_REGEX)
    type: str = Field(..., pattern=UUID_REGEX)
    title: str = Field(..., max_length=255, min_length=5)
    description: Optional[str] = Field(max_length=255, min_length=5)
    status: ProjectStatusEnum = Field(...)
