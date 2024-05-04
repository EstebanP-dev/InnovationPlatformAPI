from ...domain import ProjectStatusEnum
from src.shared import BaseModel, Field, List, UUID_REGEX, Optional
from fastapi import UploadFile


class DeliverableDto(BaseModel):
    type: str = Field(..., pattern=UUID_REGEX)
    name: str = Field(..., max_length=255, min_length=5)
    identifier: str = Field(..., max_length=255, min_length=5)
    description: str = Field(..., max_length=255, min_length=5)


class CreateProjectCommand(BaseModel):
    branch: str = Field(..., pattern=UUID_REGEX)
    assessor: str = Field(..., pattern=UUID_REGEX)
    type: str = Field(..., pattern=UUID_REGEX)
    title: str = Field(..., max_length=255, min_length=5)
    description: Optional[str] = Field(max_length=255, min_length=5)
    status: ProjectStatusEnum = Field(...)
    authors: List[str] = Field(..., min_items=1, max_items=2)
    deliverables: List[DeliverableDto] = Field(..., min_items=1, max_items=5)
    files: List[UploadFile] = Field(..., min_items=0, max_items=5)
