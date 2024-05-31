from src.shared import BaseModel, Field, List, Optional

from ...domain import ProjectStatusEnum


class UpdateProjectRequest(BaseModel):
    assessor: Optional[str] = Field(None, description="Assessor of project")
    type: Optional[str] = Field(None, description="Type of project")
    title: Optional[str] = Field(None, description="Title of project")
    description: Optional[str] = Field(None, description="Description of project")
    authors: Optional[List[str]] = Field(None, description="Authors of project")
    status: Optional[ProjectStatusEnum] = Field(None, description="Status of project")
