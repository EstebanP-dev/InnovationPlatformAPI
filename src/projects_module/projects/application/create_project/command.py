from src.shared import BaseModel, Field, UUID_REGEX, Optional, List

from ...domain import ProjectStatusEnum


class CreateProjectCommand(BaseModel):
    branch: str = Field(..., pattern=UUID_REGEX)
    assessor: str = Field(..., pattern=UUID_REGEX)
    type: str = Field(..., pattern=UUID_REGEX)
    title: str = Field(..., max_length=255, min_length=5)
    description: Optional[str] = Field(max_length=255, min_length=5)
    authors: List[str] = Field(..., min_items=1, max_items=2)
    status: ProjectStatusEnum = Field(...)
