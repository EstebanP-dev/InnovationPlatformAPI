from ...domain import ProjectStatusEnum
from src.shared import BaseModel, Field, List, UUID_REGEX, Optional


class DeliverableDto(BaseModel):
    type: str = Field(..., pattern=UUID_REGEX)
    name: str = Field(..., max_length=255, min_length=5)
    url: str = Field(..., max_length=255, min_length=5)
    description: str = Field(..., max_length=255, min_length=5)


class CreateProjectCommand(BaseModel):
    assessor: str = Field(..., pattern=UUID_REGEX)
    type: str = Field(..., pattern=UUID_REGEX)
    title: str = Field(..., max_length=255, min_length=5)
    description: Optional[str] = Field(max_length=255, min_length=5)
    status: ProjectStatusEnum = Field(...)
    authors: List[str] = Field(..., min_items=1, max_items=2)
    deliverables: List[DeliverableDto] = Field(..., min_items=1, max_items=5)
