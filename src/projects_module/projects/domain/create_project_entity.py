from src.shared import BaseModel, Field, Optional


class CreateProjectEntity(BaseModel):
    assessor_id: Optional[str] = Field(None)
    project_id: Optional[str] = Field(None)
    project_type_id: Optional[str] = Field(None)
    project_title: Optional[str] = Field(None)
    project_description: Optional[str] = Field(None)
    project_deliverable_folder_id: Optional[str] = Field(None)
    project_status: Optional[str] = Field(None)
    authors_str: Optional[str] = Field(None)
