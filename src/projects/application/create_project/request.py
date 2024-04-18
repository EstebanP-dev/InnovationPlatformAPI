from src.shared import BaseModel, Field, List, UUID_REGEX, Annotated, Optional
from ...domain import ProjectStatusEnum


class DeliverableRequest(BaseModel):
    type: Optional[str] = None
    name: Optional[str] = None
    url: Optional[str] = None
    description: Optional[str] = None


class CreateProjectRequest(BaseModel):
    assessor: Optional[str] = None
    type: Optional[str] = None
    title: Optional[str] = None
    description: Optional[str] = None
    authors: Optional[List[str]] = None
    deliverables: Optional[List[DeliverableRequest]] = None
    status: Optional[ProjectStatusEnum] = ProjectStatusEnum.PENDING
