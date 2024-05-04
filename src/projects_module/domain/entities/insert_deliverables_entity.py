from src.shared import BaseModel, Field


class InsertDeliverablesEntity(BaseModel):
    type: str = Field(...)
    name: str = Field(...)
    url: str = Field(...)
    description: str = Field(...)
