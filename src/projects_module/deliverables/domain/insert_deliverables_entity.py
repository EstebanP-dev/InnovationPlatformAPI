from src.shared import BaseModel, Field


class InsertDeliverableEntity(BaseModel):
    project_id: str = Field(...)
    type_id: str = Field(...)
    deliverable_id: str = Field(...)
    deliverable_name: str = Field(...)
    deliverable_description: str = Field(...)
    deliverable_url: str = Field(...)
