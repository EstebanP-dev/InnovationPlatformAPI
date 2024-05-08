from src.shared import BaseModel, Field, Optional


class ProjectEntity(BaseModel):
    assessor_id: Optional[str] = Field(None)
    project_id: Optional[str] = Field(None)
    project_type_id: Optional[str] = Field(None)
    project_title: Optional[str] = Field(None)
    project_description: Optional[str] = Field(None)
    project_status: Optional[str] = Field(None)
    authors_str: Optional[str] = Field(None)
