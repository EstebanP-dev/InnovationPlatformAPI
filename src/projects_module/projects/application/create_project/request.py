from src.shared import BaseModel, Field, List, Optional

from ...domain import ProjectStatusEnum


class DeliverableRequest(BaseModel):
    type: Optional[str] = Field(None, description="Type of deliverable")
    name: Optional[str] = Field(None, description="Name of deliverable")
    identifier: Optional[str] = Field(None, description="Identifier of deliverable")
    description: Optional[str] = Field(None, description="Description of deliverable")


class CreateProjectRequest(BaseModel):
    assessor: Optional[str] = Field(None, description="Assessor of project")
    type: Optional[str] = Field(None, description="Type of project")
    title: Optional[str] = Field(None, description="Title of project")
    description: Optional[str] = Field(None, description="Description of project")
    authors: Optional[List[str]] = Field(None, description="Authors of project")
    deliverables: Optional[List[DeliverableRequest]] = Field(None, description="Deliverables of project")
    status: Optional[ProjectStatusEnum] = Field(ProjectStatusEnum.PENDING, description="Status of project")
