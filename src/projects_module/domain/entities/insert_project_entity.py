from src.shared import BaseModel, Field


class InsertProjectEntity(BaseModel):
    assessor_id: str = Field(...)
    project_id: str = Field(...)
    project_type_id: str = Field(...)
    project_title: str = Field(...)
    project_description: str = Field(...)
    project_status: str = Field(...)
    authors_str: str = Field(...)
    deliverables_str: str = Field(...)
