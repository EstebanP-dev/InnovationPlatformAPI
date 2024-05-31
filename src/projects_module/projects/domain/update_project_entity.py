from src.shared import BaseModel, Field, Optional


class UpdateProjectEntity(BaseModel):
    project_id: Optional[str] = Field(None)
    assessor_id: Optional[str] = Field(None)
    project_type_id: Optional[str] = Field(None)
    project_title: Optional[str] = Field(None)
    project_description: Optional[str] = Field(None)
    project_status: Optional[str] = Field(None)
    project_authors_str: Optional[str] = Field(None)
